# Retro CRT Pong

A small two-player Pong game built with LÖVE 2D, featuring a CRT-style look, power-ups, and a pause menu.

## Features

- First to 5 points wins
- Large paddle, curve shot, and disorient power-ups
- Pause menu with resume, restart, how-to-play, and quit options
- Keyboard or mouse menu controls

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

- Player 1: `W` / `S` to move, `E` for large paddle, `Q` for curve shot, `Left Arrow` to disorient Player 2
- Player 2: `Up Arrow` / `Down Arrow` to move, `Right Shift` for large paddle, `\` for curve shot, `D` to disorient Player 1
- Start / serve: `Enter`
- Pause / resume: `Esc`
- Pause menu: `W` / `S` or `Up Arrow` / `Down Arrow` to select, `Enter` to confirm, or click an option
- Return from how-to-play: `Backspace`, `Enter`, or click `Back`
