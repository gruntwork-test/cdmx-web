include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::github.com/gruntwork-test/cdmx-web.git//modules/team-website"
}

inputs = {
  team_name  = values.team_name
  image_path = "${get_repo_root()}/${values.image_path}"
}
