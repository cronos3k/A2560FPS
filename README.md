# Abuse 2560 FPS - Enhanced Edition

![hero](https://github.com/user-attachments/assets/143352b6-dfe5-474f-926d-dd7f74548a85)

> **Enhanced fork of [Abuse 2025](https://github.com/apancik/Abuse_2025)** featuring advanced movement mechanics and AI-enhanced visuals while preserving the classic Abuse experience.

## 🎮 What's New in This Fork

### ⭐ Advanced Wall Jump System
Transform your platforming experience with fluid wall mechanics:

- **Vertical Wall Climb**: Press `W+Space` near a wall for 2x jump height
- **Horizontal Wall Kick**: Press toward-wall + `Space` to launch away with 2x speed
- **Smart Wall Detection**: Uses original collision system for perfect integration
- **Configurable Timing**: Adjust grace periods and hang mechanics via config
- **Visual Debug Mode**: Toggle with `Alt+N` to see wall detection in action

```ini
# Enable in config.txt
wall_jump_enabled=1              # Enable wall jump mechanics
wall_coyote_frames=60            # Grace window after leaving wall (frames)
wall_hang_hold_frames=12         # Frames to hold before wall latch
wall_debug_overlay=0             # Show debug overlay (Alt+N toggles)
```

**Implementation**: Non-destructive integration at `src/objects.cpp:1517` using original physics

### 🎨 AI-Enhanced 60 FPS Sprite Interpolation
Experience buttery-smooth animations powered by neural networks:

- **4x Frame Rate**: Original 15 FPS physics with 60 FPS visual smoothness
- **RIFE Neural Networks**: Real-Time Intermediate Flow Estimation for frame generation
- **Intelligent Frame Mapping**: Seamless integration with original sprite system
- **Optional Toggle**: Can be disabled to preserve classic look
- **Current Collections**: aliens, bigexp (explosions), droid, fire

```ini
# Enable in config.txt
interpolated_sprites_enabled=1   # AI-enhanced 60 FPS sprites
```

**Technical**: Uses `InterpSpriteManager` with automatic fallback to original sprites if data unavailable

### ✨ Modern Enhancements

- **Dedicated Jump Key**: `Space` for jumping (in addition to `W`)
- **60 FPS Frame Pacing**: Configurable frame rate limiting (`fps_limit=60`)
- **Enhanced Visual Effects**: Dynamic light/glow overlay system
- **Config Diagnostics**: Debug output for troubleshooting settings
- **Modern Defaults**: WASD + Space control layout
- **Auto-Config Launcher**: `abuse25.exe` creates optimized settings

### 📦 Quick Start

**Recommended**: Download the [latest release](https://github.com/cronos3k/A2560FPS/releases) and run `abuse25.exe`

**Build from source**:
```bash
mkdir msvc-build && cd msvc-build
cmake .. -G "Visual Studio 17 2022" -A x64
cmake --build . --config Release
cmake --install . --config Release
```

Full build instructions: [Development](#development)

## 🙏 Credits & Acknowledgments

### This Fork (2025)
- **Wall Jump System**: Advanced movement mechanics implementation
- **AI Sprite Interpolation**: Neural network-based frame interpolation
- **Modern Configuration**: Enhanced diagnostics and QoL improvements
- 🤖 *Developed with assistance from Claude (Anthropic)*

### Upstream: Abuse 2025
- **Andrej Pancik** (2024-2025): Modern port with multiplayer, gamepad support, high-res graphics
- Project: https://github.com/apancik/Abuse_2025

### Previous Port Maintainers
- **Anthony Kruize** (2001): Original SDL port
- **Sam Hocevar** (2005-2011): SDL port maintenance
- **Xenoveritas** (2014): SDL2 port
- **Antonio Radojkovic** (2016): Abuse 1996 project

### Original Abuse (1995)
- **Crack dot Com**: Jonathan Clark, Dave Taylor, and team
- **Music & Sound**: Bobby Prince
- The legendary 2D platform shooter that started it all

**Full credits in [AUTHORS](AUTHORS) file**

## 📜 License

All modifications released under **GNU GPL 2+** to maintain compatibility with:
- Original Abuse source (Public Domain, 1995)
- SDL ports (GPL 2+, 2001-2025)
- Upstream Abuse 2025 project

See [COPYING](COPYING) for complete license information.

---

# 📖 About Abuse

Celebrating its 30th anniversary, Abuse by Crack dot Com remains a timeless classic. Falsely imprisoned in an underground facility, Nick Vrenna becomes humanity's last hope when a genetic experiment called "Abuse" transforms guards and inmates alike into murderous mutants.

Experience revolutionary gameplay combining precision mouse aiming with fluid keyboard movement in this intense side-scrolling action platformer. **Multiplayer is fully supported on all platforms** with automatic LAN discovery via UDP broadcast.

