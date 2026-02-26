<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${team_name} - GruntCon CDMX</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #0f172a, #1e293b);
            color: #f8fafc;
            overflow-x: hidden;
            position: relative;
            cursor: url("data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' width='32' height='32' viewBox='0 0 32 32'><text y='24' font-size='24'>🌮</text></svg>") 4 4, auto;
        }

        /* Papel picado banner across the top */
        .papel-picado {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 80px;
            z-index: 20;
            pointer-events: none;
            display: flex;
            justify-content: center;
        }
        .papel-picado svg {
            animation: sway 3s ease-in-out infinite;
            transform-origin: top center;
        }
        @keyframes sway {
            0%, 100% { transform: rotate(-1deg); }
            50% { transform: rotate(1deg); }
        }

        /* Animated background grid */
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background-image:
                linear-gradient(rgba(56, 189, 248, 0.03) 1px, transparent 1px),
                linear-gradient(90deg, rgba(56, 189, 248, 0.03) 1px, transparent 1px);
            background-size: 60px 60px;
            animation: gridShift 20s linear infinite;
        }
        @keyframes gridShift {
            to { transform: translate(60px, 60px); }
        }

        /* Taco columns on left and right */
        .taco-column {
            position: fixed;
            top: 0;
            width: 120px;
            height: 100vh;
            z-index: 1;
            pointer-events: none;
        }
        .taco-column.left { left: 20px; }
        .taco-column.right { right: 20px; }

        .taco-wrapper {
            position: absolute;
            opacity: 0;
        }

        @keyframes floatUp {
            0%   { transform: translateY(110vh) rotate(0deg) scale(0.8); opacity: 0; }
            5%   { opacity: 0.9; }
            90%  { opacity: 0.9; }
            100% { transform: translateY(-10vh) rotate(360deg) scale(1); opacity: 0; }
        }

        /* Spicy particle bursts */
        .particle {
            position: fixed;
            width: 4px;
            height: 4px;
            border-radius: 50%;
            pointer-events: none;
            animation: sparkle 3s ease-in-out infinite;
        }
        @keyframes sparkle {
            0%, 100% { opacity: 0; transform: scale(0); }
            50% { opacity: 1; transform: scale(1); }
        }

        /* Confetti pieces */
        .confetti {
            position: fixed;
            pointer-events: none;
            z-index: 100;
            animation: confettiFall linear forwards;
        }
        @keyframes confettiFall {
            0% { transform: translateY(0) rotate(0deg) scale(1); opacity: 1; }
            100% { transform: translateY(100vh) rotate(720deg) scale(0.5); opacity: 0; }
        }

        /* Main content */
        .container {
            text-align: center;
            padding: 2rem;
            padding-top: 90px;
            z-index: 10;
            position: relative;
        }

        .subtitle {
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.3em;
            color: #fbbf24;
            margin-bottom: 0.5rem;
            animation: fadeSlideIn 1s ease-out 0.2s both;
        }

        h1 {
            font-size: 3rem;
            margin-bottom: 0.5rem;
            background: linear-gradient(90deg, #006847, #fff, #ce1126, #fff, #006847);
            background-size: 200% auto;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: shimmer 4s linear infinite, fadeSlideIn 1s ease-out 0.4s both;
        }
        @keyframes shimmer {
            to { background-position: 200% center; }
        }

        .tagline {
            font-size: 1.1rem;
            color: #94a3b8;
            margin-bottom: 2rem;
            animation: fadeSlideIn 1s ease-out 0.6s both;
        }


        @keyframes fadeSlideIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .image-frame {
            position: relative;
            display: inline-block;
            animation: fadeSlideIn 1s ease-out 0.8s both;
        }
        .image-frame::before {
            content: '';
            position: absolute;
            inset: -3px;
            border-radius: 15px;
            background: linear-gradient(135deg, #006847, #fff, #ce1126, #fbbf24, #006847);
            background-size: 300% 300%;
            animation: borderRotate 4s ease infinite;
            z-index: -1;
        }
        @keyframes borderRotate {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }

        img {
            max-width: 500px;
            width: 100%;
            border-radius: 12px;
            display: block;
        }

        /* Neon glow ring behind the image */
        .glow-ring {
            position: absolute;
            top: 50%;
            left: 50%;
            width: 120%;
            height: 120%;
            transform: translate(-50%, -50%);
            border-radius: 50%;
            background: radial-gradient(circle, rgba(249, 115, 22, 0.15) 0%, transparent 70%);
            animation: pulse 4s ease-in-out infinite;
            z-index: -2;
        }
        @keyframes pulse {
            0%, 100% { transform: translate(-50%, -50%) scale(1); opacity: 0.5; }
            50% { transform: translate(-50%, -50%) scale(1.1); opacity: 1; }
        }

        /* Pinata */
        .pinata-zone {
            margin-top: 1.5rem;
            animation: fadeSlideIn 1s ease-out 1s both;
        }
        .pinata {
            font-size: 3.5rem;
            cursor: pointer;
            display: inline-block;
            transition: transform 0.1s;
            animation: pinataSwing 2s ease-in-out infinite;
            user-select: none;
            filter: drop-shadow(0 0 8px rgba(251, 191, 36, 0.4));
        }
        .pinata:active {
            transform: scale(0.85) rotate(-15deg) !important;
        }
        @keyframes pinataSwing {
            0%, 100% { transform: rotate(-8deg); }
            50% { transform: rotate(8deg); }
        }
        .pinata-hint {
            font-size: 0.75rem;
            color: #64748b;
            margin-top: 0.25rem;
        }

        .footer {
            margin-top: 1.5rem;
            font-size: 0.8rem;
            color: #475569;
            animation: fadeSlideIn 1s ease-out 1.2s both;
        }
    </style>
</head>
<body>

    <!-- Papel picado banner -->
    <div class="papel-picado">
        <svg viewBox="0 0 1200 80" width="100%" height="80" preserveAspectRatio="none">
            <defs>
                <path id="flag-shape" d="M0,0 L0,55 L5,50 L10,55 L15,50 L20,55 L25,50 L30,55 L35,50 L40,55 L45,50 L50,55 L55,50 L60,55 L60,0 Z"/>
            </defs>
            <!-- String -->
            <path d="M0,8 Q300,18 600,8 Q900,0 1200,8" stroke="#8c6000" stroke-width="2" fill="none"/>
            <!-- Flags -->
            <g id="banners">
                <use href="#flag-shape" x="30" y="6" fill="#006847" opacity="0.85"/>
                <use href="#flag-shape" x="100" y="10" fill="#ce1126" opacity="0.85"/>
                <use href="#flag-shape" x="170" y="8" fill="#fbbf24" opacity="0.85"/>
                <use href="#flag-shape" x="240" y="12" fill="#ec4899" opacity="0.85"/>
                <use href="#flag-shape" x="310" y="7" fill="#006847" opacity="0.85"/>
                <use href="#flag-shape" x="380" y="11" fill="#8b5cf6" opacity="0.85"/>
                <use href="#flag-shape" x="450" y="9" fill="#ce1126" opacity="0.85"/>
                <use href="#flag-shape" x="520" y="6" fill="#38bdf8" opacity="0.85"/>
                <use href="#flag-shape" x="590" y="10" fill="#fbbf24" opacity="0.85"/>
                <use href="#flag-shape" x="660" y="8" fill="#006847" opacity="0.85"/>
                <use href="#flag-shape" x="730" y="12" fill="#ec4899" opacity="0.85"/>
                <use href="#flag-shape" x="800" y="7" fill="#ce1126" opacity="0.85"/>
                <use href="#flag-shape" x="870" y="11" fill="#8b5cf6" opacity="0.85"/>
                <use href="#flag-shape" x="940" y="9" fill="#fbbf24" opacity="0.85"/>
                <use href="#flag-shape" x="1010" y="6" fill="#38bdf8" opacity="0.85"/>
                <use href="#flag-shape" x="1080" y="10" fill="#006847" opacity="0.85"/>
                <use href="#flag-shape" x="1150" y="8" fill="#ce1126" opacity="0.85"/>
            </g>
            <!-- Cut-out patterns on each flag (little diamonds/circles) -->
            <g fill="rgba(0,0,0,0.15)">
                <circle cx="60" cy="30" r="6"/><circle cx="130" cy="34" r="6"/><circle cx="200" cy="32" r="6"/>
                <circle cx="270" cy="36" r="6"/><circle cx="340" cy="31" r="6"/><circle cx="410" cy="35" r="6"/>
                <circle cx="480" cy="33" r="6"/><circle cx="550" cy="30" r="6"/><circle cx="620" cy="34" r="6"/>
                <circle cx="690" cy="32" r="6"/><circle cx="760" cy="36" r="6"/><circle cx="830" cy="31" r="6"/>
                <circle cx="900" cy="35" r="6"/><circle cx="970" cy="33" r="6"/><circle cx="1040" cy="30" r="6"/>
                <circle cx="1110" cy="34" r="6"/><circle cx="1180" cy="32" r="6"/>
            </g>
        </svg>
    </div>

    <!-- Hidden taco template (cleaned OpenClipart public domain SVG) -->
    <div id="taco-template" style="display:none">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 926.081 1000.859">
            <g transform="translate(-582.156,3.39)">
              <g>
                <g transform="translate(964.956,-166)">
                  <g transform="matrix(1.5855,0,0,1.47,-172.24,-76.43)">
                    <g transform="matrix(2.867,0.637,-0.549,3.329,-998.93,-1069.56)">
                      <g transform="matrix(0.812,-0.549,0.528,0.92,12.19,203.24)">
                        <path fill="#fccc0a" d="m371.45,429.33 3.73-3.75.36-8.57-.36-11.96-3.2-11.97-1.07-1.43-3.56-10.71-3.73-4.82-5.33-8.04-6.4-5.54-9.42-9.1-9.78-4.29-14.4-1.25-4.09-.89-2.31-1.07-11.56-.36-8.71 2.14-12.09 5.9-5.51 6.25-5.69 7.32-3.56 5-1.6 2.32 3.56-1.61 12.62-1.25 13.51 1.07 18.49 6.07 18.14 9.29 10.85 6.61 11.2 9.46 12.09 14.46z"/>
                        <path fill="#da331c" d="m369.9,430.23 5.61-4.01.77-6.45-.25-5.42-3.82-4.13-3.31-7.22-7.9-4.9-5.1-10.06-2.8-8.51-7.13-5.42-6.1-2.92-9.93-3.41-8.43-4.31-27.26-4.32-10.19 3.35-12.99 5.68-8.41 6.19-1.27 2.06 16.31-4.13 15.8 1.55 23.18 9.54 21.91 10.84 16.05 12.9 11.47 15.48z"/>
                        <path fill="#eecd1a" d="m249.11,393.97 1.79-5.54 3.57-5.18 6.96-6.96 6.25-3.39 9.82-1.07 14.46.89 18.39 6.07 19.29 10 10 5.89 12.32 10 8.39 9.82 7.86 11.07 1.43 2.5.89 1.43-1.07.89-3.39-1.43-20.36-5.89-54.64-14.64-24.46-6.43-9.82-2.5-4.29-1.96-2.86-.89z"/>
                      </g>
                      <g transform="translate(257.97,91.92)">
                        <g transform="translate(-40.36,-213.78)">
                          <path fill="#cf4629" d="m273.01,482.51-.65-4.42 9.33 5.56.39 4.29z"/>
                          <path fill="#d56240" d="m272.55,478.03c-1.95 1.85-2.7 5.18-3.85 7.89l1.26 5.3 3.16-9.09z"/>
                          <path fill="#bb3121" d="m269.96,491.22 6.06 3.28 5.05-4.29 1.01-2.27-9.09-5.56z"/>
                        </g>
                        <path fill="#ffbe2c" d="m213.5,286.86 4.38-.98 3.3-1.88 4.73-3.57 3.39-3.04 1.96-2.5 1.43 2.86-6.52 5.98-9.38 5.63-3.57 1.88z"/>
                        <path fill="#aed311" d="m195.83,287.76-9.82 8.75-5.54 3.3-4.91 2.77-2.5 1.43.89-2.05 1.61-1.79 1.07-.63.8-1.43-.8-2.23-1.16-1.16-1.34-.09 2.14-.8 1.34-1.52 1.52-1.61.98-2.14.27-2.59.09-1.25 1.96-1.43 2.05-2.14.63-2.59.36-3.13-.8-4.29 2.5 3.3 1.88.71 2.14-.27 1.61.09 3.75-.45 5.45-2.59 5-3.04 4.91-2.68-7.32 7.86-5.98 8.21z"/>
                        <path fill="#8c6000" d="m213.32,281.6 1.67.29 5.43-2.87 2.8-2.19.74-1.2-.54-2.05-1.93-2.37 1.87 1.81 2.48.39 2.15.22 1.49-.48 3.96-2.84 2.08-3.46 1.01-2.79-4.29-.07-8.96 3.89-3.19 1.92-1.27 1.91-.13 2.17.41 1.01-5.05-1.17-2.92.33-1.37.78-2.7 1.76-2.58-.32-2.32.93-2.82 2.28.41 2.57 3.14 2.65 1.95.27 4.02-.35 2.84-1.18z"/>
                        <path fill="#ffbe2c" d="m240.42,280.61 2.53 3.41 2.65.88 5.93-.13 8.59-1.52 7.45-2.78-4.29-1.14-7.83 1.52-6.82.38-6.19-.51z"/>
                        <path fill="#ffbe2c" d="m194.17,288.49 5.05-2.53 6.82-1.14 6.69-.25 7.45 1.01 2.53.63 5.68-2.15-5.93-.76-7.45-.88-8.46-.76-7.58.76-5.3 2.02-2.53 2.53 2.15 1.77z"/>
                        <path fill="#ffbe2c" d="m225.41,275.95 5.63-.38 6.73 1.59 6.27 2.35 6.48 3.81 2.09 1.56 6.07.21-5.18-2.99-6.53-3.69-7.51-3.97-7.28-2.23-5.67-.18-3.3 1.35 1.3 2.46z"/>
                        <path fill="#ffbe2c" d="m176.69,298.62 2.46-5.08 4.71-5.06 5.15-4.28 6.52-3.74 2.39-1.04 3.2-5.17-5.17 3.02-6.44 3.84-7.17 4.56-5.54 5.22-2.97 4.83-.46 3.54 2.78.09z"/>
                        <path fill="#aed311" d="m245.75,287.49-11.21-6.88-4.76-4.35-4.07-3.9-2.09-1.98 2.22.26 2.17 1.02.91.85 1.6.36 1.91-1.41.78-1.45-.3-1.31 1.39 1.82 1.84.84 1.98.99 2.34.32 2.56-.49 1.22-.28 1.93 1.47 2.64 1.35 2.66-.15 3.1-.56 3.87-2.01-2.44 3.35-.14 2 .87 1.97.38 1.56 1.51 3.46 4.05 4.47 4.35 3.91 3.98 3.93-9.63-4.74-9.59-3.36z"/>
                        <path fill="#8c6000" d="m262.09,290.8.82 1 4.26 1.48 2.49.44.92-.17.55-1.21-.11-2.07.31 1.79 1.24 1.45 1.12 1.21 1.04.54 3.42.74 2.61-.51 1.73-.75-2.4-2.24-6.68-2.84-2.6-.77-1.51.22-.98.92-.19.67-2.37-3.13-1.79-1.35-1.1-.35-2.26-.58-1.33-1.48-1.7-.77-2.54-.41-.83 1.39.68 2.83.99 1.13 2.42 1.91 2.09.92z"/>
                        <g transform="translate(-40.36,-213.78)">
                          <path fill="#cf4629" d="m273.01,482.51-.65-4.42 9.33 5.56.39 4.29z"/>
                          <path fill="#d56240" d="m272.55,478.03c-1.95 1.85-2.7 5.18-3.85 7.89l1.26 5.3 3.16-9.09z"/>
                          <path fill="#bb3121" d="m269.96,491.22 6.06 3.28 5.05-4.29 1.01-2.27-9.09-5.56z"/>
                        </g>
                        <g transform="translate(-69.83,-213.78)">
                          <path fill="#cf4629" d="m273.01,482.51-.65-4.42 9.33 5.56.39 4.29z"/>
                          <path fill="#d56240" d="m272.55,478.03c-1.95 1.85-2.7 5.18-3.85 7.89l1.26 5.3 3.16-9.09z"/>
                          <path fill="#bb3121" d="m269.96,491.22 6.06 3.28 5.05-4.29 1.01-2.27-9.09-5.56z"/>
                        </g>
                        <g transform="translate(-96.25,-198.78)">
                          <path fill="#cf4629" d="m273.01,482.51-.65-4.42 9.33 5.56.39 4.29z"/>
                          <path fill="#d56240" d="m272.55,478.03c-1.95 1.85-2.7 5.18-3.85 7.89l1.26 5.3 3.16-9.09z"/>
                          <path fill="#bb3121" d="m269.96,491.22 6.06 3.28 5.05-4.29 1.01-2.27-9.09-5.56z"/>
                        </g>
                        <path fill="#ffbe2c" d="m200.42,271.68 2.53 3.41 2.65.88 5.93-.13 8.59-1.52 7.45-2.78-4.29-1.14-7.83 1.52-6.82.38-6.19-.51z"/>
                        <g transform="matrix(0.729,0,0,0.729,69.04,-63.92)">
                          <path fill="#cf4629" d="m273.01,482.51-.65-4.42 9.33 5.56.39 4.29z"/>
                          <path fill="#d56240" d="m272.55,478.03c-1.95 1.85-2.7 5.18-3.85 7.89l1.26 5.3 3.16-9.09z"/>
                          <path fill="#bb3121" d="m269.96,491.22 6.06 3.28 5.05-4.29 1.01-2.27-9.09-5.56z"/>
                        </g>
                      </g>
                    </g>
                  </g>
                </g>
              </g>
            </g>
        </svg>
    </div>

    <!-- Left taco column -->
    <div class="taco-column left" id="taco-left"></div>

    <!-- Right taco column -->
    <div class="taco-column right" id="taco-right"></div>

    <!-- Spicy particles -->
    <div id="particles"></div>

    <div class="container">
        <div class="subtitle">GruntCon CDMX presents</div>
        <h1>${team_name}</h1>
        <p class="tagline">Bringing the heat since deploy #1</p>

        <div class="image-frame">
            <div class="glow-ring"></div>
            <img src="${image_filename}" alt="${team_name}">
        </div>

        <div class="pinata-zone">
            <div class="pinata" id="pinata" title="Hit me!">
                <svg width="100" height="100" viewBox="0 0 120 110" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <!-- String -->
                    <line x1="60" y1="0" x2="60" y2="20" stroke="#8c6000" stroke-width="2"/>
                    <!-- Body -->
                    <ellipse cx="60" cy="50" rx="30" ry="22" fill="#ec4899"/>
                    <!-- Head -->
                    <ellipse cx="98" cy="35" rx="14" ry="11" fill="#ec4899"/>
                    <!-- Snout -->
                    <ellipse cx="110" cy="38" rx="7" ry="5" fill="#f9a8d4"/>
                    <!-- Eye -->
                    <circle cx="100" cy="32" r="2.5" fill="#1e293b"/>
                    <circle cx="101" cy="31.5" r="0.8" fill="#fff"/>
                    <!-- Ears -->
                    <polygon points="92,26 88,14 95,24" fill="#ec4899"/>
                    <polygon points="100,24 102,12 105,23" fill="#ec4899"/>
                    <polygon points="93,26 89.5,17 95,25" fill="#f9a8d4"/>
                    <polygon points="101,24 102.5,15 104,23.5" fill="#f9a8d4"/>
                    <!-- Legs -->
                    <rect x="38" y="65" width="7" height="20" rx="3" fill="#ec4899"/>
                    <rect x="50" y="65" width="7" height="22" rx="3" fill="#db2777"/>
                    <rect x="68" y="65" width="7" height="22" rx="3" fill="#ec4899"/>
                    <rect x="78" y="65" width="7" height="20" rx="3" fill="#db2777"/>
                    <!-- Hooves -->
                    <rect x="37" y="82" width="9" height="5" rx="2" fill="#8c6000"/>
                    <rect x="49" y="84" width="9" height="5" rx="2" fill="#8c6000"/>
                    <rect x="67" y="84" width="9" height="5" rx="2" fill="#8c6000"/>
                    <rect x="77" y="82" width="9" height="5" rx="2" fill="#8c6000"/>
                    <!-- Tail -->
                    <path d="M30,45 Q18,40 16,50 Q14,58 22,55" stroke="#ec4899" stroke-width="4" fill="none" stroke-linecap="round"/>
                    <circle cx="22" cy="55" r="4" fill="#fbbf24"/>
                    <!-- Fringe decorations on body -->
                    <g>
                        <rect x="42" y="38" width="4" height="7" rx="1" fill="#fbbf24"/>
                        <rect x="50" y="36" width="4" height="8" rx="1" fill="#38bdf8"/>
                        <rect x="58" y="37" width="4" height="7" rx="1" fill="#22c55e"/>
                        <rect x="66" y="38" width="4" height="7" rx="1" fill="#ce1126"/>
                        <rect x="74" y="39" width="4" height="6" rx="1" fill="#8b5cf6"/>
                        <rect x="46" y="48" width="4" height="7" rx="1" fill="#f97316"/>
                        <rect x="54" y="47" width="4" height="8" rx="1" fill="#fbbf24"/>
                        <rect x="62" y="48" width="4" height="7" rx="1" fill="#38bdf8"/>
                        <rect x="70" y="49" width="4" height="6" rx="1" fill="#ec4899"/>
                        <rect x="42" y="56" width="4" height="6" rx="1" fill="#8b5cf6"/>
                        <rect x="50" y="57" width="4" height="6" rx="1" fill="#22c55e"/>
                        <rect x="58" y="56" width="4" height="7" rx="1" fill="#ce1126"/>
                        <rect x="66" y="57" width="4" height="6" rx="1" fill="#fbbf24"/>
                    </g>
                </svg>
            </div>
            <div class="pinata-hint">click for a surprise</div>
        </div>

        <div class="footer">
        </div>
    </div>

    <script>
        // ---- Floating tacos ----
        var tacoSource = document.querySelector('#taco-template svg');

        function spawnTaco(column) {
            var wrapper = document.createElement('div');
            wrapper.className = 'taco-wrapper';
            var size = 40 + Math.random() * 40;
            var svg = tacoSource.cloneNode(true);
            svg.setAttribute('width', size);
            svg.setAttribute('height', size * 1.08);
            wrapper.appendChild(svg);
            wrapper.style.left = Math.random() * 60 + 'px';
            var duration = 8 + Math.random() * 12;
            var delay = Math.random() * -duration;
            wrapper.style.animation = 'floatUp ' + duration + 's linear ' + delay + 's infinite';
            column.appendChild(wrapper);

            setTimeout(function() {
                wrapper.remove();
                spawnTaco(column);
            }, duration * 1000);
        }

        // ---- Particles (Mexican flag colors) ----
        function spawnParticles() {
            var container = document.getElementById('particles');
            var colors = ['#006847', '#ce1126', '#fbbf24', '#fff', '#ec4899', '#8b5cf6'];
            for (var i = 0; i < 30; i++) {
                var p = document.createElement('div');
                p.className = 'particle';
                p.style.left = Math.random() * 100 + 'vw';
                p.style.top = Math.random() * 100 + 'vh';
                p.style.background = colors[Math.floor(Math.random() * colors.length)];
                p.style.animationDelay = Math.random() * 3 + 's';
                p.style.animationDuration = 2 + Math.random() * 3 + 's';
                container.appendChild(p);
            }
        }

        // ---- Confetti burst (on click and from pinata) ----
        var confettiColors = ['#006847', '#ce1126', '#fbbf24', '#ec4899', '#8b5cf6', '#38bdf8', '#fff'];
        var confettiShapes = ['\u25a0', '\u25cf', '\u25b2', '\u2605', '\u2666'];

        function burstConfetti(x, y, count) {
            for (var i = 0; i < count; i++) {
                var c = document.createElement('div');
                c.className = 'confetti';
                c.textContent = confettiShapes[Math.floor(Math.random() * confettiShapes.length)];
                c.style.left = x + (Math.random() - 0.5) * 200 + 'px';
                c.style.top = y + 'px';
                c.style.color = confettiColors[Math.floor(Math.random() * confettiColors.length)];
                c.style.fontSize = (8 + Math.random() * 14) + 'px';
                c.style.animationDuration = (1.5 + Math.random() * 2) + 's';
                document.body.appendChild(c);
                (function(el) {
                    setTimeout(function() { el.remove(); }, 4000);
                })(c);
            }
        }

        // Click anywhere for mini confetti
        document.addEventListener('click', function(e) {
            burstConfetti(e.clientX, e.clientY, 8);
        });

        // ---- Pinata ----
        var pinataHits = 0;
        var pinata = document.getElementById('pinata');
        var pinataOriginal = pinata.innerHTML;
        pinata.addEventListener('click', function(e) {
            e.stopPropagation();
            pinataHits++;
            burstConfetti(e.clientX, e.clientY, 15 + pinataHits * 5);

            // Shake it harder each hit
            pinata.style.animation = 'none';
            pinata.offsetHeight; // trigger reflow
            pinata.style.animation = 'pinataSwing ' + Math.max(0.3, 2 - pinataHits * 0.2) + 's ease-in-out infinite';

            // After enough hits, it "breaks"
            if (pinataHits >= 5) {
                pinata.innerHTML = '<span style="font-size:3rem">\ud83c\udf89\ud83c\udf6c\ud83c\udf6d\ud83c\udf89</span>';
                pinata.style.animation = 'none';
                pinata.style.transform = 'scale(1.5)';
                burstConfetti(e.clientX, e.clientY, 80);

                // Reset after celebration
                setTimeout(function() {
                    pinataHits = 0;
                    pinata.innerHTML = pinataOriginal;
                    pinata.style.animation = 'pinataSwing 2s ease-in-out infinite';
                    pinata.style.transform = '';
                }, 3000);
            }
        });

        // ---- Init ----
        var leftCol = document.getElementById('taco-left');
        var rightCol = document.getElementById('taco-right');

        for (var i = 0; i < 5; i++) {
            spawnTaco(leftCol);
            spawnTaco(rightCol);
        }
        spawnParticles();
    </script>
</body>
</html>
