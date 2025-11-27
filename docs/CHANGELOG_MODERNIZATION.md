# Abuse 2025 – Modern Gameplay & Engine Enhancements

This document summarizes the major gameplay and engine improvements we introduced while modernizing Abuse, describes the motivation behind each change, and outlines the technical approach with file references for future maintenance.

## Table of Contents

1. [Dedicated Jump Input & Modernized Controls](#dedicated-jump-input--modernized-controls)
2. [Wall-Jump & Proximity-Based Mid-Air Boosts](#wall-jump--proximity-based-mid-air-boosts)
3. [Frame Rate Control & Rendering Stability](#frame-rate-control--rendering-stability)
4. [Dynamic Lighting & Glow Overlay](#dynamic-lighting--glow-overlay)
5. [Quality-of-Life Debugging & Editor Flow](#quality-of-life-debugging--editor-flow)

---

## Dedicated Jump Input & Modernized Controls

**Why:** The original control scheme tied jump to the “Up” direction key, which made diagonal movement unintuitive (especially for WASD players) and interfered with new abilities that rely on pressing `W` while already airborne (e.g., wall interactions). A separate jump binding is standard in modern platformers and also keeps ladder climbing usable without accidental jumps.

**How:**
- Added `Settings::jump` in `src/sdlport/setup.h`, persisted through config parsing/writing (`src/sdlport/setup.cpp`, `src/configuration.cpp`).
- The input mapper now emits `jump` when that key/button is pressed, separate from `y` direction.
- Gameplay code checks the dedicated jump flag for initiating jumps or augmenting wall actions (`src/objects.cpp`, `src/cop.cpp` when needed).

**Benefit:** Players can use standard WASD + Space controls, controller mappings can bind A/B to jump cleanly, and future mechanics can detect “up” vs. “jump” independently (ladders, elevators, walls).

## Wall-Jump & Proximity-Based Mid-Air Boosts

**Why:** The classic wall-hang system felt clunky on modern hardware and often made the character “stick” unintentionally. We replaced it with a purposeful mechanic: when the player is within a few pixels of a vertical surface, pressing jump triggers contextual boosts—higher hops if holding Up, or powerful lateral kicks if pressing away. This keeps traversal fluid, supports double-jump style moves, and matches player expectations from contemporary platformers.

**How:**
- Implemented three horizontal probes (at body center, ±5 px vertically) to detect nearby walls within 3 px (`src/objects.cpp` jump logic).
- When airborne and near a wall, pressing the jump binding injects additional impulse:
  - Jump + Up: 1.5× vertical boost to climb.
  - Jump + horizontal away: 2× lateral kick.
- Legacy wall-hang code remains behind an always-false branch for future tuning reference.
- Added `wall_debug_overlay` (settings flag + Alt+N toggle) to visualize probe hits, coyote frames, and state while tuning.

**Benefit:** Movement feels deliberate, enabling “wall bounce” navigation in tight corridors without the old sticky wall behaviour. The debug overlay helped fine-tune edge cases and can remain available for modders.

## Frame Rate Control & Rendering Stability

**Why:** On modern GPUs Abuse can run at hundreds of FPS, causing runaway physics timing and input jitter. We needed deterministic pacing (e.g., 60 FPS) without regressing the original fixed-physics feel. Additionally, the rendering path needed a clean logical size so window upscaling doesn’t distort mouse input.

**How:**
- Added `Settings::fps_limit` (0 = uncapped, or standard targets 30/60/120).
- The SDL renderer now enforces frame pacing around the target while leaving the fixed physics step untouched (`src/game.cpp`, `src/sdlport/event.cpp`).
- F11 cycles through presets at runtime and writes back to config.
- Reworked `handle_window_resize` and `SDL_RenderSetLogicalSize` so input scaling stays consistent at high resolutions.

**Benefit:** Smooth frame pacing on modern hardware, no runaway CPU usage, and the physics remain deterministic regardless of monitor refresh rates. Players can pick a comfortable FPS cap or leave it uncapped if desired.

## Dynamic Lighting & Glow Overlay

**Why:** Abuse’s original lightmap-based shading is atmospheric, but effects like muzzle flashes and explosions looked flat on modern displays. We introduced an optional glow overlay that respects player viewports, renders colored halos, and can be fed by scripted events without rewriting the legacy light system.

**How:**
- Added an ARGB overlay surface/texture managed in `src/sdlport/video.cpp`.
- Introduced APIs (`LightOverlay_Clear`, `LightOverlay_AddRadialScreen`, `LightOverlay_AddWorldGlow`, `LightOverlay_AddViewRect`) declared in `src/imlib/video.h`.
- Particle system now adds warm glows per sprite (`src/particle.cpp`), weapon fire injects colored boosts based on ammo type (`src/cop.cpp` via `LightOverlay_AddWorldGlow` in `src/game.cpp`).
- The renderer clips the overlay to gameplay views so UI stays untouched, blends it at ~30 % opacity to avoid washing out tiles, and clears it every frame.
- Editor-authored lights continue to function; we just add modern bloom-like highlights on top.

**Benefit:** Visual feedback for projectiles/explosions feels more alive, giving the 30-year-old art style extra depth without replacing original lightmaps. The system is optional (`lights_overlay_enabled` in `config.txt`) and automatically adapts to multiple splitscreen views.

## Quality-of-Life Debugging & Editor Flow

**Why:** Rapid iteration needs visibility into new systems (wall probes, lighting) and easier access to the editor.

**How:**
- Alt+N toggles the on-screen wall debug overlay, showing probe status, coyote frames, and state near the player (`src/objects.cpp`, `src/view.cpp`).
- Added `run_editor.bat` to start the installed build directly in editor mode with foreground/background/object windows open (`run_editor.bat`, `README.md` references).
- Updated documentation (`docs/TECH_DESIGN.md`, this changelog) so contributors understand the new architecture.

**Benefit:** Designers and programmers can quickly validate traversal tuning and lighting modifications, while modders get one-click access to the editor UI.

---

These changes keep Abuse true to its roots but remove friction for modern players: standard inputs, responsive traversal, stable frame pacing, and enhanced visuals all contribute to a better first impression without forcing mods or source tweaks. Refer to the indicated source files when adjusting any subsystem. If additional modernization efforts are planned, append them here for future maintainers.
