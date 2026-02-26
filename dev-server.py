#!/usr/bin/env python3
"""
Dev server for the team-website template.
Renders the HTML template, serves it on localhost:8080,
and auto-reloads the browser when any source file changes.

Usage: python3 dev-server.py
"""

import http.server
import os
import re
import string
import threading
import time

PORT = 8080
PROJECT_ROOT = os.path.dirname(os.path.abspath(__file__))
TEMPLATE_PATH = os.path.join(PROJECT_ROOT, "modules", "team-website", "templates", "index.html.tpl")
IMAGE_SOURCE = os.path.join(PROJECT_ROOT, "examples", "gruntcon-cdmx-teamname", "us-east-1", "gruntcon-web", "team-image.png")
SERVE_DIR = os.path.join(PROJECT_ROOT, ".dev")

TEMPLATE_VARS = {
    "team_name": "My Awesome Team",
    "image_filename": "team-image.png",
}

RELOAD_SCRIPT = """
<script>
(function() {
  let lastHash = null;
  setInterval(async () => {
    try {
      const r = await fetch('/__reload');
      const h = await r.text();
      if (lastHash && h !== lastHash) location.reload();
      lastHash = h;
    } catch(e) {}
  }, 500);
})();
</script>
"""

file_hash = [str(time.time())]


def render_template():
    with open(TEMPLATE_PATH) as f:
        content = f.read()

    # Handle Terraform's $$ escape (literal $) before substituting template vars
    content = content.replace('$$', '$')
    rendered = re.sub(r'\$\{(\w+)\}', lambda m: TEMPLATE_VARS.get(m.group(1), m.group(0)), content)
    rendered = rendered.replace("</body>", RELOAD_SCRIPT + "</body>")

    os.makedirs(SERVE_DIR, exist_ok=True)
    with open(os.path.join(SERVE_DIR, "index.html"), "w") as f:
        f.write(rendered)

    if os.path.exists(IMAGE_SOURCE):
        import shutil
        shutil.copy2(IMAGE_SOURCE, os.path.join(SERVE_DIR, "team-image.png"))

    file_hash[0] = str(time.time())
    print(f"  Rendered template ({time.strftime('%H:%M:%S')})")


def watch_files():
    watch_paths = [TEMPLATE_PATH, IMAGE_SOURCE]
    mtimes = {}
    while True:
        for p in watch_paths:
            if not os.path.exists(p):
                continue
            mtime = os.path.getmtime(p)
            if p in mtimes and mtimes[p] != mtime:
                render_template()
            mtimes[p] = mtime
        time.sleep(0.3)


class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=SERVE_DIR, **kwargs)

    def do_GET(self):
        if self.path == "/__reload":
            self.send_response(200)
            self.send_header("Content-Type", "text/plain")
            self.send_header("Cache-Control", "no-cache")
            self.end_headers()
            self.wfile.write(file_hash[0].encode())
            return
        super().do_GET()

    def log_message(self, format, *args):
        if "/__reload" not in str(args):
            super().log_message(format, *args)


if __name__ == "__main__":
    render_template()

    watcher = threading.Thread(target=watch_files, daemon=True)
    watcher.start()

    print(f"\n  Dev server running at http://localhost:{PORT}")
    print(f"  Watching: {TEMPLATE_PATH}")
    print(f"  Press Ctrl+C to stop\n")

    server = http.server.HTTPServer(("", PORT), Handler)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nStopped.")
