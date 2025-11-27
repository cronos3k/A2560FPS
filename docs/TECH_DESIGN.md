# Abuse 2025 – Technical & Game Design Overview

This document summarizes the overall architecture of **Abuse 2025**, explains how the major subsystems interact, and lists the most relevant source files so new contributors can find the corresponding implementation quickly. Paths are repository-relative (e.g., `src/game.cpp`).

## Table of Contents
1. [Runtime Overview](#runtime-overview)
2. [Subsystem Reference](#subsystem-reference)
   1. [Rendering Pipeline](#rendering-pipeline)
   2. [Input Stack](#input-stack)
   3. [Physics & World Simulation](#physics--world-simulation)
   4. [Gameplay Objects & Content](#gameplay-objects--content)
   5. [Audio](#audio)
   6. [Lighting](#lighting)
   7. [Networking & Multiplayer](#networking--multiplayer)
   8. [Editor & Tooling](#editor--tooling)
   9. [Configuration & Settings](#configuration--settings)
   10. [Build & Packaging](#build--packaging)

---

## Runtime Overview

### Frame Timing Diagram
```
┌────────────┐   ┌─────────┐   ┌──────────────┐   ┌───────────────┐   ┌───────────┐
│SDL Events →│--→│Input Map│--→│Physics Step(s)│--→│Render & Lighting│--→│Present/DSP│
└────────────┘   └─────────┘   └──────────────┘   └───────────────┘   └───────────┘
                                     │
                                     └─ fixed dt = Settings::physics_update (ms)
```

| Layer | Description | Key Files |
|-------|-------------|-----------|
| **Entry & Setup** | `int main` lives in `src/game.cpp` (bottom of the file). It initializes SDL, loads configuration, and boots the `Game` singleton with command-line arguments parsed in `src/sdlport/setup.cpp`. | `src/game.cpp`, `src/sdlport/setup.cpp`, `src/sdlport/setup.h` |
| **Platform / SDL Wrapper** | The `src/sdlport` directory owns SDL window management, input, audio, timers, and OS integration. It isolates the rest of the engine from platform APIs. | `src/sdlport/video.cpp`, `src/sdlport/event.cpp`, `src/sdlport/sound.cpp` |
| **Core Engine** | `Game` (in `src/game.cpp`) manages the simulation loop, state machine (RUN, MENU, PAUSE, DEV, etc.), views/cameras, time-stepping, and coordination between systems such as `level`, `objects`, `light`, and UI. | `src/game.cpp`, `src/game.h`, `src/view.cpp`, `src/level.cpp`, `src/light.cpp`, `src/dev.cpp` |
| **Content & Logic** | Entities, AI, abilities, weapons, particles, and data-driven scripts live under `src/objects.cpp`, `src/ability.cpp`, `src/cop.cpp`, `src/particle.cpp`, and the LISP VM (`src/lisp`). Assets are loaded via the SPEC/cache system (see `src/cache.cpp`, `src/specs.cpp`). | `src/objects.cpp`, `src/ability.cpp`, `src/cop.cpp`, `src/particle.cpp`, `src/cache.cpp`, `src/specs.cpp`, `src/lisp/*.cpp` |
| **Networking** | Multiplayer support is implemented as a client/server architecture. `src/net/gserver.cpp` drives the authoritative simulation, `src/net/gclient.cpp` mirrors state on peers, and `src/net/tcpip.cpp` / `src/net/sock.*` abstract sockets. Packet IDs are enumerated in `src/net/netface.h`. | `src/net/*` |

The main loop alternates between:
1. **Input**: Poll SDL events, update per-view input buffers (`src/sdlport/event.cpp`, `src/view.cpp`).
2. **Simulation**: Step gameplay at the configured physics update (`Settings::physics_update`), resolving object logic, collisions, AI, and network sync (`src/game.cpp`, `src/objects.cpp`, `src/collide.cpp`).
3. **Rendering**: Draw background tiles, foreground, sprites, UI, and lighting overlays (`src/game.cpp`, `src/sdlport/video.cpp`, `src/ui/*`).
4. **Audio**: Mix SFX/music for the frame (`src/sdlport/sound.cpp`).

## Subsystem Reference

### Rendering Pipeline
1. **Software Compositing (`src/game.cpp`)**
   - `Game::draw_map` assembles the scene into the software `main_screen` surface (`imlib` image).
   - Background tiles (`current_level->get_bg`) and foreground autotiles (`get_fg`) are blitted via `src/imlib/image.cpp`.
   - Sprites and particles draw into the same 8-bit surface using cached images (`src/cache.cpp`).

2. **Lighting (classic)**  
   `light_screen` / `double_light_screen` in `src/light.cpp` scan precomputed patches to tint pixels based on `light_source` entries. Editor-authored lights live in the level data and are collected per frame in `Game::draw_map`.

3. **SDL Present**  
   `src/sdlport/video.cpp` converts the paletted `surface` into an RGB `screen`, uploads it to an SDL texture, and presents it via the hardware renderer. The file also manages:
   - Resolution scaling / letterboxing (`handle_window_resize`).
   - FPS limiting and logical size.
   - The modern glow overlay (see [Lighting](#lighting)).

4. **UI Overlay**  
   UI widgets (menus, HUD, chat, editor palettes) live under `src/ui/` and draw after the world but before the glow overlay. The overlay now clips itself to the active views to avoid touching UI (see `LightOverlay_AddViewRect` in `src/sdlport/video.cpp`).

### Input Stack
1. **SDL Events → Settings bindings**  
   `src/sdlport/event.cpp` polls SDL keyboard/mouse/controller events every frame. It maps them to logical actions using bindings from `Settings` (`src/sdlport/setup.h`). Jump now has a dedicated binding (`settings.jump`).

2. **Per-View Suggestion Buffers**  
   Processed inputs are written into each `view`’s suggestion fields (`view::x_suggestion`, `view::b1_suggestion`, etc. in `src/view.cpp`). These suggestions are later consumed when assembling movement commands or network packets.

3. **Networking**  
   Input events are serialized through `SCMD_SET_INPUT`, `SCMD_KEYPRESS`, etc., defined in `src/net/netface.h` so remote peers see the same button state.

### Physics & World Simulation
1. **Fixed Step**  
   `Game::tick_game()` (in `src/game.cpp`) advances the world at `settings.physics_update` milliseconds per step (default ≈65 ms). The accumulator logic ensures rendering can run at higher rates without changing physics.

2. **Objects**  
   `game_object` (defined in `src/objects.cpp`) encapsulates state, movement, and collision resolution. Movement typically calls `try_move` and `current_level->all_boundary_setback` to stay inside the map geometry (`src/level.cpp`, `src/collide.cpp`).

3. **Abilities & Actions**  
   Player abilities are implemented in `src/ability.cpp`. Specific weapon behaviors live in `src/cop.cpp`, while AI for enemies often resides in `src/ant.cpp` or scriptable LISP hooks (`src/lisp`).

4. **Physics Tuning**  
   Timing knobs such as `Settings::physics_update`, wall-jump grace windows, and bullet time flags are all stored in `src/sdlport/setup.h` and persisted in `config.txt`.

### Gameplay Objects & Content
1. **Asset Pipeline**  
   SPEC archives (`*.spe`) are loaded via `src/specs.cpp`. `cache.cpp` keeps decoded images/sounds resident. Tools in `src/tool/` (e.g., `spe_dump.cpp`) can inspect packs.

2. **Entities**  
   `src/objects.cpp` and `src/chars.cpp` define object classes and state machines. Variables can be accessed via scripting thanks to the LISP binding layer in `src/clisp.cpp`.

3. **Weapons & Effects**  
   `src/cop.cpp` handles player weapon firing, offsets, and ammo. Each shot now also spawns a colored world glow via `LightOverlay_AddWorldGlow`. Explosions/particles are defined by `src/particle.cpp` sequences and draw glows after rendering.

4. **UI & HUD**  
   Status bar logic is in `src/sbar.cpp`, chat in `src/chat.cpp`, automap in `src/automap.cpp`. Menu/state transitions reside in `src/menu.cpp`.

### Audio
SDL_mixer is wrapped in `src/sdlport/sound.cpp`. It loads samples via the cache, maps user volume settings (`settings.volume_sound`, `settings.volume_music`), and hooks into gameplay events (weapon fire, ambient cues). Music playback uses HMI files (see `src/sdlport/hmi.*`).

### Lighting
1. **Static Lights (`src/light.cpp`)**  
   Level-authored `light_source` instances define shape, radius, and falloff. Editor tools (`src/dev.cpp`) create or adjust them.

2. **Modern Glow Overlay (`src/sdlport/video.cpp`)**  
   - `LightOverlay_Clear`, `LightOverlay_AddRadialScreen`, and `LightOverlay_AddViewRect` manage an ARGB surface that mirrors the viewports.
   - Particles (`src/particle.cpp`) and weapons (`src/cop.cpp` via `LightOverlay_AddWorldGlow` in `src/game.cpp`) add colored glows.
   - During `update_window_done()` the glow surface is uploaded and blended at ~30 % opacity using the renderer’s clip rect so UI and letterboxing remain untouched.

### Networking & Multiplayer
#### Packet Flow (Server ↔ Client)
```
Client                             Server
------                             ------
Input buffers ──SCMD_SET_INPUT──► gserver.cpp -> apply input
Chat/keys   ───SCMD_CHAT_KEYPRESS/KEYPRESS──►
                            │
                            │   authoritative state diff
                            └───gserver builds packets (netface.h ids)
                                    ▲
State updates ◄──gclient.cpp parses ◄┘
```
`SCMD_*` values live in `src/net/netface.h`. Transport uses `tcpip_protocol` (`src/net/tcpip.cpp`), which relies on `sock.*` for platform sockets.

1. **Architecture**  
   - `gserver` (`src/net/gserver.cpp`) is authoritative and owns the canonical `Game` instance.
   - Each peer runs `gclient` (`src/net/gclient.cpp`) which handles prediction, chat, and UI while applying server corrections.
   - Transport is abstracted in `tcpip_protocol` (`src/net/tcpip.cpp`, `src/net/tcpip.h`) but routed through a common `netface` interface (`src/net/netface.h`).

2. **Packets & Commands**  
   `SCMD_*` constants in `src/net/netface.h` describe the control protocol (view resize, input, chat, reload). Game-state deltas ride on higher-level messages built by the server/client handlers.

3. **File Synchronization**  
   `src/net/fileman.cpp` streams level data and saves when `-remote_save` or add-on hosting is enabled. This keeps clients in sync with custom content.

4. **LAN Workflow**  
   CLI switches (`README.md` “Network Settings” section) map to code paths in `src/sdlport/setup.cpp` (`-server`, `-net`, `-port`, `-nonet`, etc.), selecting the correct backend at boot.

### Editor & Tooling
1. **Integrated Editor**  
   Triggered via `-edit` or `editor=1` (`README.md`). `src/dev.cpp` implements the editor GUI, object/light placement, property windows, and undo/redo. UI widgets live in `src/ui/*`.

2. **Content Windows**  
   Flags such as `-fwin`, `-bwin`, `-owin` open dedicated fore/background/object windows (see `README.md`). They interact with level data through `src/dev.cpp` and `src/level.cpp`.

3. **Utilities**  
   - `src/tool/spe_dump.cpp`: inspects SPEC packs.
   - `src/tool/abuse-tool.cpp`: command-line helper for batch jobs (export/import).

### Configuration & Settings
Configuration is parsed by `src/sdlport/setup.cpp` into the `Settings` struct (`src/sdlport/setup.h`). Highlights:

| Area | Keys | Notes |
|------|------|-------|
| Display | `virtual_width`, `virtual_height`, `screen_width`, `fullscreen`, `linear_filter`, `fps_limit` | Affect initialization in `src/sdlport/video.cpp`. |
| Gameplay | `wall_coyote_frames`, `wall_hang_hold_frames`, `physics_update`, `lights_overlay_enabled`, `wall_debug_overlay` | Read in `src/game.cpp`, `src/objects.cpp`, and new overlay logic. |
| Input | `left/right/up/down/...`, `jump`, controller bindings (`ctr_*`) | Used by `get_key_binding`/`get_ctr_binding` in `src/sdlport/setup.cpp`. |
| Audio | `volume_sound`, `volume_music`, `soundfont`, `no_sound`, `no_music` | Consumed by `src/sdlport/sound.cpp`. |
| Networking | Command-line only (`-server`, `-net`, `-port`, etc.) | See `README.md` and `src/sdlport/setup.cpp`. |

Config files live beside the installed binary (or `%APPDATA%/abuse/data` on Windows). They’re rewritten via `Settings::CreateConfigFile()` when leaving the options menu.

### Build & Packaging
| Target | Notes |
|--------|-------|
| **CMake** | Root `CMakeLists.txt` drives the build. `src/CMakeLists.txt` wires modules and optional tools. |
| **Dependencies** | SDL2, SDL2_mixer, CMake ≥ 3.20, modern C++17 compiler (MSVC 17, Clang, or GCC). |
| **Windows** | The `msvc-build` preset links against vcpkg. Packaging uses CPack + the runtime bundler (`cmake/bundle_runtime.cmake`). |
| **macOS/Linux** | Standard `cmake .. && make && make install` per README. |
| **Tools** | `run_editor.bat` launches the installed build straight into editor mode with helper windows toggled. |

---

### Quick File Map

| Area | Files |
|------|-------|
| Core engine | `src/game.cpp`, `src/game.h`, `src/view.cpp`, `src/view.h` |
| Levels & geometry | `src/level.cpp`, `src/level.h`, `src/collide.cpp`, `src/light.cpp`, `src/light.h` |
| Objects & AI | `src/objects.cpp`, `src/objects.h`, `src/chars.cpp`, `src/ant.cpp`, `src/ability.cpp`, `src/cop.cpp` |
| Rendering | `src/sdlport/video.cpp`, `src/imlib/image.cpp`, `src/particle.cpp`, `src/ui/*` |
| Input & config | `src/sdlport/event.cpp`, `src/sdlport/setup.cpp`, `src/configuration.cpp` |
| Networking | `src/net/gserver.cpp`, `src/net/gclient.cpp`, `src/net/netface.h`, `src/net/tcpip.cpp`, `src/net/fileman.cpp` |
| Audio | `src/sdlport/sound.cpp`, `src/sdlport/hmi.cpp` |
| Editor | `src/dev.cpp`, `src/ui/*`, `run_editor.bat` |
| Tools | `src/tool/abuse-tool.cpp`, `src/tool/spe_dump.cpp` |

Use this document as a starting point when diving deeper into any subsystem; each referenced file contains further comments and function-level details.
