# Abuse 2025 - Upgrade Documentation

This document details the major improvements and modernizations made to Abuse for the 2025 release, building upon the Xenoveritas SDL2 port and Abuse 1996 project.

## Table of Contents

- [Performance Improvements](#performance-improvements)
- [Visual Enhancements](#visual-enhancements)
- [Input and Control Improvements](#input-and-control-improvements)
- [Audio Improvements](#audio-improvements)
- [Quality of Life Features](#quality-of-life-features)
- [Developer Features](#developer-features)
- [Known Issues](#known-issues)

---

## Performance Improvements

### 60 FPS Rendering (January 2025)

**Major game loop rewrite** that separates rendering from physics simulation.

- **Rendering**: Runs at 60 FPS (16.67ms per frame) for smooth visuals
- **Physics**: Maintains original 15 FPS (65ms) timing for authentic gameplay feel
- **Interpolated Drawing**: Smooth animation between physics updates for fluid motion
- **Frame Limiting**: Precise frame timing using SDL_Delay to prevent excessive CPU usage

**Technical Details:**
- Location: `src/game.cpp:2402-2502`
- Uses double-buffering with interpolation between physics states
- Exponential moving average for accurate FPS calculation

**Benefits:**
- Buttery smooth scrolling and animation
- More responsive visual feedback
- Original game physics preserved for authentic difficulty
- Better compatibility with modern high-refresh-rate displays

### Adaptive Performance Management

**Frame Panic Detection** automatically manages performance on slower systems.

- Monitors frame times in real-time
- Auto-disables CPU-intensive features (lighting) when frames exceed 100ms
- Gradual recovery when performance stabilizes
- Prevents unplayable slideshow scenarios

**Implementation:**
- Location: `src/game.cpp:2443-2456`
- Maintains counters for both immediate and sustained performance issues

### Configurable Physics Rate

Users can fine-tune game speed via `config.txt`:

```ini
; Physics update time in ms (65ms/15FPS original)
physics_update=65
```

**Common Settings:**
- `physics_update=65` - Original speed (15 FPS) - **Default**
- `physics_update=33` - Double speed (30 FPS)
- `physics_update=16` - Quadruple speed (60 FPS) - Warning: Very fast!

---

## Visual Enhancements

### High-Resolution Support

Support for modern display resolutions while maintaining pixel-art aesthetic.

**New Config Options:**

```ini
; Enable high resolution screens and font
hires=0          ; 0=disabled, 1=enabled, 2=Bungie logo
big_font=0       ; Enable big font for better readability

; Use linear texture filter (nearest is default)
linear_filter=0  ; 0=sharp pixels, 1=smooth scaling
```

**Features:**
- High-res versions of title screens, menus, and UI elements
- Optional big font mode for better readability on large displays
- Configurable texture filtering (nearest-neighbor vs. linear)
- Internal resolution (`virtual_width`/`virtual_height`) separate from window resolution

**Aspect Ratio Handling:**
- Auto-calculates `virtual_height` from `virtual_width` to match window aspect ratio
- Prevents stretching or distortion
- Recommended: Keep `virtual_width=320` for authentic experience

### VSync Support

```ini
vsync=1  ; Enable vertical synchronization
```

Eliminates screen tearing on modern displays while maintaining precise frame timing.

### Borderless Window Mode

```ini
borderless=1  ; Enable borderless fullscreen window
```

Perfect for multi-monitor setups and quick Alt+Tab switching.

### Performance Monitoring

**FPS Counter** - Shows real-time performance metrics:
- Current frames per second
- Active object count

Location: Top-left corner when enabled (toggle during gameplay)

---

## Input and Control Improvements

### Advanced Controller Support

Complete overhaul of gamepad controls with precision aiming.

#### Virtual Crosshair System

Solves the infamous "atan2 dead zone" problem with a virtual crosshair that moves within a circular area.

**How it Works:**
1. Right stick input creates angle: `atan2(y, x)`
2. Virtual crosshair moves in that direction based on stick deflection
3. Crosshair snaps to circle edge when reaching maximum distance
4. Eliminates dead zones and provides smooth 360° aiming

**Implementation:** `src/game.cpp:1919-1947`

#### Controller Configuration Options

```ini
; Enable aiming with right stick
ctr_aim=0

; Crosshair distance from player
ctr_cd=100

; Right stick sensitivity (affects how fast crosshair moves)
ctr_rst_s=10

; Right stick dead zone (ignore small movements)
ctr_rst_dz=5000

; Left stick dead zones (movement)
ctr_lst_dzx=10000  ; Horizontal
ctr_lst_dzy=25000  ; Vertical (larger for easier jump/crouch)

; Crosshair position correction
ctr_aim_x=0  ; Horizontal offset
```

#### Button Remapping

Full customization of all controller buttons:

```ini
; Button mappings
ctr_a=up              ; A button
ctr_b=down            ; B button
ctr_x=b3              ; X button (weapon prev)
ctr_y=b4              ; Y button (weapon next)
ctr_left_stick=b1     ; Left stick click
ctr_right_stick=down  ; Right stick click
ctr_left_shoulder=b2  ; L1/LB
ctr_right_shoulder=b3 ; R1/RB
ctr_left_trigger=bt   ; L2/LT
ctr_right_trigger=b2  ; R2/RT
```

**Quick Save/Load on Controller:**
```ini
quick_save=ctr_left_stick   ; F5 equivalent
quick_load=ctr_right_stick  ; F9 equivalent
```

### Keyboard Improvements

**Modern WASD Controls** - Default bindings updated for contemporary gamers:

| Action      | Primary     | Secondary  |
|-------------|-------------|------------|
| Left        | <kbd>A</kbd> | <kbd>←</kbd> |
| Right       | <kbd>D</kbd> | <kbd>→</kbd> |
| Up/Jump     | <kbd>W</kbd> | <kbd>↑</kbd> |
| Down/Use    | <kbd>S</kbd> | <kbd>↓</kbd> |
| Prev Weapon | <kbd>Q</kbd> | -          |
| Next Weapon | <kbd>E</kbd> | -          |

**Dual Bindings:** Arrow keys still work as alternates - perfect for accessibility or unusual keyboard layouts.

### Mouse Scaling Options

```ini
; Fullscreen mouse scaling
mouse_scale=0  ; 0=match desktop DPI, 1=match game screen
```

Ensures consistent mouse sensitivity across different display modes.

---

## Audio Improvements

### Custom Soundfont Support

Load your own high-quality soundfonts for MIDI music playback:

```ini
; Path to custom soundfont file
soundfont=AWE64 Gold Presets.sf2
```

**Included Soundfonts:**
- `AWE64 Gold Presets.sf2` - Creative AWE64 Gold card samples (default)
- `Roland SC-55 Presets.sf2` - Roland SC-55 synthesizer samples

Place custom soundfonts in the data directory for authentic retro sound or modern orchestral quality.

### Independent Volume Controls

Separate volume sliders for music and sound effects:

```ini
volume_sound=127  ; SFX volume (0-127)
volume_music=127  ; Music volume (0-127)
```

Can also be adjusted in-game via Volume menu or command-line:
```bash
abuse -sfx_volume 100 -music_volume 80
```

### Flexible Audio Options

```ini
no_music=0  ; Disable music only
no_sound=0  ; Disable sound effects only
mono=0      ; Force mono audio (compatibility mode)
```

---

## Quality of Life Features

### Bullet Time Mode

Slow-motion gameplay for dramatic effect or accessibility:

```ini
; Bullet time effect multiplier (percentage)
bullet_time=120  ; 120% = 20% slower, 80% = 20% faster
```

**Usage:**
- Bind to a key (default: <kbd>Ctrl</kbd>)
- Cheat: `fastpower` for permanent speed boost
- Great for precision platforming or cinematic moments

### Improved Save System

**User Directory Separation:**
- Game data: Installation directory
- Saves/config: User-specific directory
  - Windows: `%APPDATA%\abuse\data`
  - macOS: `~/Library/Application Support/abuse/data`
  - Linux: `~/.local/share/abuse/data`

**Quick Save/Load:**
- <kbd>F5</kbd> - Quick save to slot 1
- <kbd>F9</kbd> - Quick load from slot 1
- Works on save consoles when in range

### Multi-Language Support

```ini
language=english  ; Options: english, german, french
```

### Window Management

**Keyboard Shortcuts:**
- <kbd>F10</kbd> - Toggle fullscreen/windowed mode
- <kbd>F6</kbd> - Toggle input grab
- <kbd>F7</kbd> - Toggle mouse scaling mode
- <kbd>F8</kbd> - Toggle gamepad on/off

**Fullscreen Modes:**
```ini
fullscreen=0  ; 0=window, 1=fullscreen window, 2=exclusive fullscreen
```

### Developer Console

**Cheat Console** - Press <kbd>C</kbd> during gameplay:

```
god         - Invulnerability
giveall     - All weapons and max ammo
flypower    - Anti-gravity boots
sneakypower - Cloak ability
fastpower   - Speed boost
healthpower - Ultra health (200 HP max)
nopower     - Remove all powers
```

**Note:** Mouse cursor must be inside console window to type.

### Screenshot Support

<kbd>Print Screen</kbd> - Capture screenshots to game directory.

---

## Developer Features

### Editor Mode Enhancements

Launch directly into editor:
```bash
abuse -edit
```

Or enable in config:
```ini
editor=1
```

**Editor Shortcuts:**
- <kbd>Tab</kbd> - Toggle edit mode
- <kbd>Shift+S</kbd> - Save level
- <kbd>M</kbd> - Toggle map mode

**Editor-Specific Settings:**
- Higher resolution recommended for better visibility
- Set `virtual_width=640` or higher
- Disable lighting: `-nolight` command-line flag

### Network Development

**Server Mode:**
```bash
abuse -server MyGameName -port 12345 -min_players 2
```

**Client Mode:**
```bash
abuse -net server_address -port 12345
```

**Network Debug:**
```bash
abuse -ndb 3  ; Debug level 1-3
```

### Compilation Options

**NO_CHECK Mode:**
- Optional compile definition for development
- Disables certain runtime checks for performance testing
- Not recommended for release builds

**Location:** CMake configuration

---

## Known Issues

### Multiplayer Status

✅ **FIXED (January 2025):** Multiplayer is now fully functional on all platforms!

**What Works:**
- LAN multiplayer on Windows, Linux, and macOS
- Cross-platform multiplayer (Windows ↔ Linux ↔ macOS)
- Automatic server discovery via UDP broadcast
- Proper error logging for network diagnostics

**Recent Fixes:**
- Fixed critical Windows socket type mismatch (SOCKET vs int)
- Implemented proper UDP broadcast for server discovery (255.255.255.255)
- Added comprehensive error logging with platform-specific messages
- Improved network reliability across all platforms

**Testing Recommended:**
- Test your specific network configuration
- Firewall may need to allow UDP broadcast on the game port
- Check firewall settings if server discovery fails

### Performance Notes

**Lighting at High Resolutions:**
- May impact performance on older hardware
- Automatically disabled during frame panic
- Manual disable: Config option or `-nolight` flag

**Recommended Settings for Low-End Systems:**
```ini
virtual_width=320
virtual_height=200
linear_filter=0
hires=0
```

---

## Migration Guide

### From Original Abuse (1995)

1. **Saves are compatible** - Copy `.spe` save files to user data directory
2. **Custom levels work** - Place in `data/levels/` folder
3. **Controls updated** - Review new WASD defaults in config file
4. **Physics unchanged** - Game plays identically at default `physics_update=65`

### From Abuse SDL (2011)

1. **Config format changed** - Review new `config.txt` options
2. **New features** - Controller support, high-res, 60 FPS rendering
3. **Data paths** - Now uses OS-specific user directories

### From Abuse 1996 Port

1. **Built on same foundation** - Direct continuation of that project
2. **All improvements included** - Plus new 2025 enhancements
3. **Same compiler requirements** - SDL2, CMake

---

## Performance Tuning Guide

### For Smoothest Experience

```ini
vsync=1
physics_update=65
virtual_width=320
hires=0
linear_filter=0
```

### For Best Visuals

```ini
vsync=1
physics_update=65
virtual_width=640
hires=1
big_font=1
linear_filter=1
```

### For Competitive Play

```ini
vsync=0
physics_update=65
virtual_width=320
hires=0
grab_input=1
mouse_scale=1
```

### For Accessibility

```ini
big_font=1
hires=1
physics_update=80  ; Slightly slower
bullet_time=150    ; 50% slower
ctr_aim=1          ; Enable controller aiming
ctr_rst_s=5        ; Lower sensitivity
```

---

## Technical Architecture

### Frame Timing System

**Rendering Loop (60 FPS):**
```
Frame Start → Input → Check Physics Timer → [Physics Step?] → Render → Frame Limit → Repeat
```

**Physics Loop (15 FPS):**
```
Only runs when enough time has elapsed (default: 65ms)
Maintains original game timing and difficulty
```

**Key Files:**
- `src/game.cpp:2402-2502` - Main game loop
- `src/game.cpp:1891-2004` - Game step logic
- `src/game.cpp:1508-1562` - Screen update and interpolation

### Controller Aiming Algorithm

```cpp
// Calculate deflection percentage above dead zone
float fx = (abs(stick_x) - dead_zone) / (32767 - dead_zone);
float fy = (abs(stick_y) - dead_zone) / (32767 - dead_zone);

// Get angle from stick position
float angle = atan2(stick_y, stick_x);

// Move virtual crosshair
aimx += cos(angle) * sensitivity * fx;
aimy += sin(angle) * sensitivity * fy;

// Constrain to circle
float aim_angle = atan2(aimy, aimx);
aimx = cos(aim_angle) * max_distance;
aimy = sin(aim_angle) * max_distance;

// Set mouse position
mouse_x = player_x + cos(aim_angle) * crosshair_distance;
mouse_y = player_y + sin(aim_angle) * crosshair_distance;
```

**Location:** `src/game.cpp:1919-1947`

---

## Credits

**Abuse 2025 Enhancements:**
- Andrej Pancik - Main game loop rewrite, 60 FPS rendering, controller improvements
- Contributors - See AUTHORS file

**Built Upon:**
- Xenoveritas SDL2 port (2014)
- Antonio Radojkovic's Abuse 1996 (2016)
- Sam Hocevar's Abuse SDL port (2011)
- Jeremy Scott's Windows port (2001)
- Anthony Kruize's Abuse SDL port (2001)
- Original Abuse by Crack dot Com (1995)

---

## Version History

### 2025.1 (January 2025)
- Main game loop rewrite for 60 FPS rendering
- Frame limiting and interpolation
- Improved multiplayer compatibility (in progress)
- Enhanced window management
- MacBook notch support

### 2024.x
- Controller aiming system overhaul
- High-resolution support
- Bullet time feature
- Custom soundfont support
- Modern WASD controls

---

## Future Roadmap

**High Priority:**
- [ ] Complete cross-platform multiplayer support
- [ ] Windows multiplayer networking
- [ ] Steam Workshop integration for custom content

**Medium Priority:**
- [ ] Additional language translations
- [ ] Mod manager UI
- [ ] Replay system
- [ ] Speedrun timer

**Low Priority:**
- [ ] 4K UI scaling
- [ ] Ultrawide monitor support
- [ ] Mobile port exploration

---

For build instructions, see [BUILDING.md](BUILDING.md)
For gameplay help, see [README.md](README.md)
For bug reports: https://github.com/Xenoveritas/abuse/issues
