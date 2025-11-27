# Abuse 2560 FPS - Enhanced Edition

![hero](https://github.com/user-attachments/assets/143352b6-dfe5-474f-926d-dd7f74548a85)

## About This Fork

**Abuse 2560 FPS** is an enhanced fork of [Abuse 2025](https://github.com/apancik/Abuse_2025) by Andrej Pancik, focused on modernizing the gameplay experience with advanced movement mechanics and AI-enhanced visual improvements while maintaining the core classic Abuse experience.

This project builds directly upon the excellent work of the Abuse 2025 project and the long lineage of community ports that came before it.

## New Features in This Fork

### 1. **Advanced Wall Jump Mechanics**
- **Wall Climbing**: Press W+Space near a wall to perform a vertical wall jump (2x jump height)
- **Wall Kick**: Press toward wall + Space to kick away horizontally (2x horizontal speed)
- **Configurable Grace Period**: Wall-jump buffer window for fluid movement
- **Wall Hang System**: Hold toward wall to latch and climb
- **Debug Overlay**: Visual feedback for wall detection (toggle with Alt+N)

Configuration options:
```ini
wall_jump_enabled=1           # Enable/disable wall jumping
wall_coyote_frames=60         # Grace window after leaving wall (frames at 60Hz)
wall_hang_hold_frames=12      # Frames to hold toward wall before latching
wall_debug_overlay=0          # Show wall-hang debug overlay
```

### 2. **AI-Enhanced Sprite Interpolation**
- **60 FPS Visual Smoothness**: AI-interpolated sprite animations using frame interpolation neural networks
- **4x Frame Rate**: Original 15 FPS physics with 60 FPS visual smoothness
- **Non-Destructive**: Runs in parallel with original sprite system
- **Optional**: Can be toggled on/off via configuration

Supported sprite collections:
- Aliens
- Large explosions
- Droid enemies
- Fire effects

Configuration:
```ini
interpolated_sprites_enabled=1   # Enable AI-interpolated 60 FPS sprites
```

Technical implementation:
- Frame interpolation using RIFE (Real-Time Intermediate Flow Estimation)
- Intelligent frame mapping system matching original→interpolated frames
- Automatic fallback to original sprites if interpolated data unavailable
- Located in `AIWork/frame-interpolation/final/`

### 3. **Enhanced Visual Effects**
- **Light/Glow Overlay System**: Dynamic lighting for particles and explosions
- **Configurable Effects**: Toggle visual enhancements independently

Configuration:
```ini
lights_overlay_enabled=1         # Enable light/glow overlay for effects
```

### 4. **Modern Configuration System**
- **Dedicated Jump Key**: Separate Space key for jumping (in addition to W)
- **60 FPS Frame Pacing**: Smooth frame limiting with configurable cap
- **Enhanced Debug Output**: Comprehensive config loading diagnostics
- **Modern Default Controls**: WASD + Space layout out of the box

### 5. **Quality of Life Improvements**
- **Launcher Application**: `abuse25.exe` creates optimized config and launches game
- **Config Templates**: Pre-configured `config_2025.txt` with modern defaults
- **Improved Error Messages**: Better diagnostics for troubleshooting

## Licensing

This project maintains full compatibility with the original licensing:

**Source Code:**
- Original Abuse source (src/*): Public Domain (Crack dot Com, 1995)
- SDL ports (src/sdlport/*): GNU GPL 2+
  - Anthony Kruize (2001)
  - Sam Hocevar (2005-2011)
  - Antonio Radojkovic (2016)
  - Andrej Pancik (2024-2025)
  - **This fork (2025)**
- Tools: Mixed WTFPL and GPL 2+ (see COPYING file)

**Assets:**
- Game data: Crack dot Com (1995)
- Music/SFX: Bobby Prince (permission granted for redistribution)
- AI-interpolated sprites: Derived works from original Abuse sprites (same license)

**All modifications in this fork are released under GNU GPL 2+ to maintain license compatibility.**

## Credits and Acknowledgments

### Original Abuse (1995)
- **Crack dot Com**: Jonathan Clark, Dave Taylor, and team
- **Music & Sound**: Bobby Prince
- The best 2D platform shooter ever made

### Abuse 2025 Project
- **Andrej Pancik** (2024-2025): Modern port with multiplayer, gamepad support, high-res graphics
- Project: https://github.com/apancik/Abuse_2025

### Previous Port Maintainers
- **Anthony Kruize** (2001): Original SDL port
- **Jeremy Scott** (2001): Windows port
- **Sam Hocevar** (2005-2011): SDL port maintenance and improvements
- **Xenoveritas** (2014): SDL2 port
- **Antonio Radojkovic** (2016): Abuse 1996 project

### This Fork's Additions (2025)
- **Wall Jump System**: Advanced movement mechanics implementation
- **AI Sprite Interpolation**: Neural network-based frame interpolation
- **Visual Effects**: Light overlay and glow systems
- **Configuration Improvements**: Modern defaults and enhanced options
- **Quality of Life**: Launcher, templates, improved diagnostics

### AI Assistance
This fork was developed with assistance from Claude (Anthropic), including:
- Code architecture and implementation
- Documentation
- Testing and debugging workflows

## Installation

See the [releases page](https://github.com/cronos3k/A2560FPS/releases) for pre-built binaries.

### Building from Source

The build process is identical to Abuse 2025. See the Development section below.

## Configuration

### Quick Start - Modern Gameplay
Use the included `config_2025.txt` for a modern experience with all new features enabled:

```ini
# Copy to your user data folder and rename to config.txt
# Windows: %APPDATA%\abuse\data\config.txt
```

### Feature Toggles

```ini
# Movement
wall_jump_enabled=1              # Enable wall jump mechanics
wall_coyote_frames=60            # Wall jump grace period (frames)
wall_hang_hold_frames=12         # Frames to hold before wall latch

# Visuals
interpolated_sprites_enabled=1   # AI-enhanced 60 FPS sprites
lights_overlay_enabled=1         # Dynamic lighting effects
fps_limit=60                     # Frame rate cap (0=uncapped)

# Controls
jump=SPACE                       # Dedicated jump key
```

### Default Controls (Modern Layout)

| Action      | Key Binding |
|-------------|-------------|
| Move Left   | A           |
| Move Right  | D           |
| Move Up     | W           |
| Move Down   | S           |
| Jump        | Space       |
| Fire        | F           |
| Special     | Left Shift  |
| Prev Weapon | Q           |
| Next Weapon | E           |
| Special 2   | Left Ctrl   |

## Development

### Requirements
- SDL2 2.0.0+
- SDL2_mixer 2.0.0+
- CMake 3.0+
- C++11 compatible compiler

### Building on Windows (MSVC)

```bash
# Install SDL2 via vcpkg
D:\DEV\vcpkg\vcpkg install sdl2:x64-windows sdl2-mixer:x64-windows

# Configure
mkdir msvc-build && cd msvc-build
cmake .. -G "Visual Studio 17 2022" -A x64 \
  -DCMAKE_TOOLCHAIN_FILE=D:/DEV/vcpkg/scripts/buildsystems/vcpkg.cmake

# Build
cmake --build . --config Release

# Install
cmake --install . --config Release
```

### Building on Linux/macOS

See the original [Abuse 2025 README](https://github.com/apancik/Abuse_2025) for detailed instructions.

## AI Sprite Interpolation Setup (Optional)

To use AI-interpolated sprites:

1. Ensure `interpolated_sprites_enabled=1` in config
2. Place interpolated sprite data in `AIWork/frame-interpolation/final/`
3. Required structure:
   ```
   AIWork/frame-interpolation/final/
   ├── aliens/
   ├── bigexp/
   ├── droid/
   └── fire/
   ```

Interpolated sprites are generated using RIFE neural networks. The process is documented in `AIWork/frame-interpolation/`.

## Technical Documentation

### Wall Jump System Architecture

The wall jump system integrates with Abuse's original physics:

1. **Input Detection**: W+Spacebar combination (src/objects.cpp:1517)
2. **Wall Detection**: Uses original `try_move()` collision system
3. **Jump Execution**:
   - Vertical: 2x jump height when not pressing toward wall
   - Horizontal: 2x speed away from wall when pressing toward it
4. **State Management**: Compatible with gravity(), floating(), and original physics

### Sprite Interpolation System

- **Manager Class**: `InterpSpriteManager` (src/interpolation/interp_sprite.cpp)
- **Frame Mapping**: Intelligent mapping of original frames to interpolated sequences
- **Rendering**: Integrated into main render loop with optional toggle
- **Performance**: Minimal overhead, only active when enabled

## Known Issues

- Config system diagnostics still being refined (debug output available)
- AI sprite interpolation requires significant disk space for interpolated frames
- Wall jump may interact unexpectedly with certain original game mechanics

## Contributing

Contributions are welcome! Please:

1. Maintain compatibility with original Abuse mechanics
2. Follow existing code style and conventions
3. Respect the GPL 2+ license
4. Test on Windows, Linux, and macOS when possible
5. Document new features thoroughly

## Support

- Report issues: https://github.com/cronos3k/A2560FPS/issues
- Upstream project: https://github.com/apancik/Abuse_2025
- Original Abuse resources: See links in Resources section

## Resources

### Community
- [ETTiNGRiNDER's Fortress](https://ettingrinder.youfailit.net/abuse-main.html)
- [Assorted Abuse Files](https://dl.pancik.com/abuse/)
- [Moby Games](http://www.mobygames.com/game/abuse)

### Historical Ports
- [Original Source Code (1995)](https://archive.org/details/abuse_sourcecode)
- [Anthony Kruize SDL Port (2001)](http://web.archive.org/web/20070205093016/http://www.labyrinth.net.au/~trandor/abuse)
- [Sam Hocevar SDL Port (2011)](http://abuse.zoy.org)
- [Xenoveritas SDL2 Port (2014)](http://github.com/Xenoveritas/abuse)
- [Antonio Radojkovic Abuse 1996](https://github.com/antrad/Abuse_1996)
- [Andrej Pancik Abuse 2025](https://github.com/apancik/Abuse_2025)

---

**Celebrating 30 years of Abuse** (1995-2025) - One of the pioneers of freely available gaming.

*This project stands on the shoulders of giants - thank you to everyone who kept Abuse alive for three decades.*
