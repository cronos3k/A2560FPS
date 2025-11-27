Abuse 2025 - Modern Edition Launcher
=====================================

QUICK START:
------------
Run "abuse25.exe" for the modern Abuse 2025 experience with all features enabled!

This launcher automatically configures:
✓ 60 FPS AI-interpolated sprite animations
✓ Wall jump mechanics
✓ Modern controls (WASD + Spacebar for jump)
✓ Light/glow effects
✓ 1920x1080 borderless window
✓ VSync enabled
✓ High resolution mode

WHAT'S THE DIFFERENCE?
----------------------
- abuse.exe    = Classic experience (all modern features disabled by default)
- abuse25.exe  = Modern experience (all features enabled automatically)

Both executables use the same game engine, but abuse25.exe creates a 
"config_2025.txt" file with modern settings optimized for 2025.

REQUIREMENTS:
-------------
For 60 FPS animations, ensure you have the interpolated sprite data in:
  AIWork/frame-interpolation/final/

If this directory is missing, the game will fall back to original sprites.

CONTROLS:
---------
WASD      - Move
Spacebar  - Jump (including wall jumps when enabled)
F         - Fire
Q/E       - Previous/Next weapon
Shift     - Special ability
Ctrl      - Bullet time

CONFIGURATION:
--------------
The launcher creates "config_2025.txt" which you can manually edit to:
- Adjust screen resolution
- Toggle individual features
- Customize controls
- Change wall jump parameters

To disable wall jumping: Set "wall_jump_enabled=0" in config_2025.txt
To disable 60 FPS sprites: Set "interpolated_sprites_enabled=0"

ENJOY THE MODERNIZED ABUSE EXPERIENCE!
