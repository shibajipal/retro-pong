# Retro CRT Pong

A small arcade-style Pong game built with LÖVE 2D. It features a simple two-player setup, score tracking, keyboard controls, and a CRT-style shader for a retro screen look.

## Demo Video

https://github.com/user-attachments/assets/7c5b326e-b754-41d1-acaf-17bd877233df



## Project Structure

```text
pong/
├── Ball.lua              # Ball logic and movement
├── Player.lua            # Paddle logic and rendering
├── main.lua              # Game loop, controls, rendering, and state
├── push.lua              # Screen scaling utility
├── class.lua             # Tiny class helper for object-oriented patterns
├── sounds/               # In-game sound effects
├── assets/
│   ├── crt.glsl          # CRT shader effect
│   ├── demo_video.mp4    # Demo footage for the project
│   ├── font.ttf          # Custom game font
│   └── sounds/           # Additional asset organization if needed
├── README.md             # Project overview and usage
└── .gitignore            # Git ignore rules (if present)
```

## How to Run

1. Install LÖVE 2D from: https://love2d.org/
2. Open a terminal in this project folder
3. Run:

```bash
love .
```

On Windows, you can also drag the project folder onto the `love.exe` executable if preferred.

## Controls

- Player 1: `W` / `S`
- Player 2: `Up Arrow` / `Down Arrow`
- Start / serve: `Enter`
- Quit: `Esc`
