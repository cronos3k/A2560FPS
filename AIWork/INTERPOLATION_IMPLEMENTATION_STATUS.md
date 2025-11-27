# Interpolated Sprite Implementation - STATUS

## Overview

Integrating AI-interpolated 60 FPS sprite animations into Abuse 2025 as an optional feature.

**Goal**: Smooth 60 FPS animations that match the 60 FPS rendering, using our 852 AI-generated interpolated frames.

## ✅ Completed Work

### 1. AI Frame Interpolation (COMPLETE)
- ✅ Extracted 216 original PCX frames from .spe files
- ✅ Created normalization system with JSON metadata
- ✅ AI interpolation with RIFE (4x multiplier)
- ✅ Denormalized frames back to original dimensions
- ✅ **Result**: 852 interpolated PNG frames in `AIWork/frame-interpolation/final/`

**Collections**:
- `aliens/`: 143 → 569 frames (3.98x)
- `bigexp/`: 7 → 25 frames (3.57x)
- `droid/`: 33 → 129 frames (3.91x)
- `fire/`: 33 → 129 frames (3.91x)

### 2. System Analysis (COMPLETE)
- ✅ Analyzed .spe file format and sprite system
- ✅ Understood sequence/cache/figure architecture
- ✅ Mapped animation frame selection pipeline
- ✅ Identified rendering hooks (drawer, picture())
- ✅ Designed non-destructive parallel system

### 3. Design Document (COMPLETE)
- ✅ Created `INTERPOLATION_INTEGRATION_DESIGN.md`
- ✅ Documented system architecture
- ✅ Defined implementation phases
- ✅ Specified sub-frame timing approach

### 4. Configuration System (COMPLETE)
- ✅ Added `bool interpolated_sprites_enabled` to `Settings` class (setup.h)
- ✅ Initialization (defaults to `false` - preserves original behavior)
- ✅ Config file write (`CreateConfigFile`)
- ✅ Config file read (`ReadConfigFile`)
- ✅ Documentation in config comments

**Files Modified**:
- `src/sdlport/setup.h:44` - Added setting field
- `src/sdlport/setup.cpp:113` - Initialization (default false)
- `src/sdlport/setup.cpp:229-230` - Write to config
- `src/sdlport/setup.cpp:408-409` - Read from config

## 🚧 In Progress

### 5. PNG Loading System (NEXT)

**Objective**: Load interpolated PNG frames directly into the game engine

**Approach**:
1. Create PNG loader that reads from `AIWork/frame-interpolation/final/`
2. Read metadata JSONs for frame dimensions/alignment
3. Convert PNGs to game's internal `image` format
4. Create `TransImage` objects for forward/backward directions
5. Build `figure` objects with proper `xcfg` (x-center) values
6. Register figures in cache with unique names

**Key Challenges**:
- PNG color conversion (RGBA → 8-bit indexed palette)
- Transparency handling (alpha channel → color 0)
- X-center calculation for proper sprite alignment
- Memory management (only load when enabled)

**Required New Files**:
- `src/interp_loader.h` - PNG loading declarations
- `src/interp_loader.cpp` - PNG loading implementation

## 📋 Remaining Work

### 6. Sequence System Modification
**Task**: Extend sequence system to support interpolated frames

**Implementation**:
```cpp
// In seq.h
class sequence {
    sequence *interp_version;  // Points to interpolated sequence

    TransImage *get_frame_with_interp(short physics_frame,
                                      float render_offset,
                                      int direction);
};
```

**Steps**:
1. Add `interp_version` pointer to `sequence` class
2. Create interpolated sequences with 4x frames
3. Link interpolated sequences to originals
4. Implement `get_frame_with_interp()` method

### 7. Sub-Frame Timing
**Task**: Calculate which interpolated frame to show based on render time

**Timing Logic**:
```
Physics updates: Every 65ms (ticks 0, 65, 130, 195, ...)
Rendering: Every 16.67ms (60 FPS)

Within a 65ms physics frame:
- Render tick 0ms:   offset = 0.00 → show interp frame 0 (original)
- Render tick 16ms:  offset = 0.25 → show interp frame 1 (AI)
- Render tick 33ms:  offset = 0.50 → show interp frame 2 (AI)
- Render tick 49ms:  offset = 0.75 → show interp frame 3 (AI)
- Render tick 65ms:  offset = 0.00 → next physics frame
```

**Implementation Location**: `level.cpp` or `objects.cpp`

### 8. Rendering Integration
**Task**: Modify drawing pipeline to use interpolated frames when enabled

**Hook Point**: `game_object::drawer()` (objects.cpp:736)

**Approach**:
```cpp
void game_object::drawer() {
    if (settings.interpolated_sprites_enabled && has_interpolated_sequence()) {
        float offset = get_render_frame_offset();
        TransImage *cpict = current_sequence()->get_frame_with_interp(
            current_frame, offset, direction);
        cpict->PutImage(main_screen, calculate_position());
    } else {
        // Original behavior
        TransImage *cpict = picture();
        cpict->PutImage(main_screen, calculate_position());
    }
}
```

### 9. GUI Toggle (Optional Enhancement)
**Task**: Add in-game menu option to toggle interpolated sprites

**Location**: Options/Settings menu

**Implementation**:
- Add checkbox in settings menu
- Bind to `settings.interpolated_sprites_enabled`
- Save to config on change

### 10. Build & Test
**Tasks**:
1. Compile with new code
2. Test with `interpolated_sprites_enabled=0` (original behavior)
3. Test with `interpolated_sprites_enabled=1` (smooth animations)
4. Verify alignment/positioning
5. Check memory usage
6. Performance testing

## Technical Approach

### PNG Loading Strategy

**Problem**: PNGs are RGBA, game uses 8-bit indexed palette

**Solution**:
1. Load PNG with SDL2_image or stb_image
2. Find or create matching palette (use existing game palette)
3. Convert RGBA → indexed using nearest color matching
4. Map alpha channel: alpha < 128 → color 0 (transparent)

### X-Center Calculation

**Problem**: Interpolated frames have different widths

**Solution**: Use metadata JSON to calculate proper xcfg values

```python
# From metadata
frame_width = metadata['original_width']
pad_left = metadata['pad_left']

# X-center is typically middle of sprite
xcfg = frame_width // 2

# Adjust for any specific character requirements
# (some characters may have off-center registration points)
```

### Memory Management

**Strategy**:
- Check `settings.interpolated_sprites_enabled` at startup
- Only load interpolated data if enabled
- Use existing cache eviction system
- Fallback to original frames if out of memory

## File Inventory

### AI-Generated Data
```
AIWork/frame-interpolation/
├── final/
│   ├── aliens/     - 569 PNG frames
│   ├── bigexp/     - 25 PNG frames
│   ├── droid/      - 129 PNG frames
│   └── fire/       - 129 PNG frames
└── metadata/
    ├── aliens_metadata.json
    ├── bigexp_metadata.json
    ├── droid_metadata.json
    └── fire_metadata.json
```

### Modified Source Files
- ✅ `src/sdlport/setup.h` - Settings class
- ✅ `src/sdlport/setup.cpp` - Config read/write
- ⏳ `src/interp_loader.h` - NEW: PNG loading
- ⏳ `src/interp_loader.cpp` - NEW: PNG loading
- ⏳ `src/seq.h` - Interpolated sequence support
- ⏳ `src/seq.cpp` - Frame selection logic
- ⏳ `src/objects.cpp` - Rendering integration
- ⏳ `src/level.cpp` - Timing calculations

### Documentation
- ✅ `AIWork/FINAL_SUMMARY.md` - AI interpolation results
- ✅ `AIWork/INTERPOLATION_INTEGRATION_DESIGN.md` - System design
- ✅ `AIWork/INTERPOLATION_IMPLEMENTATION_STATUS.md` - This file

## Next Steps

### Immediate (Phase 1)
1. **Create PNG loader** (`src/interp_loader.cpp`)
   - Load PNGs from filesystem
   - Read metadata JSONs
   - Convert to game image format
   - Create TransImage/figure objects

2. **Test loader in isolation**
   - Verify PNG loading
   - Check color conversion
   - Validate transparency
   - Confirm alignment

### Short-Term (Phase 2)
3. **Extend sequence system**
   - Add interp_version pointer
   - Create interpolated sequences
   - Link to original sequences

4. **Implement sub-frame timing**
   - Calculate render offset
   - Map to interpolated frame index

### Medium-Term (Phase 3)
5. **Integrate into rendering**
   - Modify drawer() to use interpolated frames
   - Test with one sprite collection (bigexp)
   - Verify alignment and smooth motion

6. **Expand to all collections**
   - Test aliens, droid, fire
   - Performance profiling
   - Memory usage analysis

### Polish (Phase 4)
7. **GUI toggle** (optional)
8. **Performance optimization**
9. **Documentation**

## Testing Plan

### Unit Tests
- [ ] PNG loading (read files successfully)
- [ ] Color conversion (RGBA → indexed)
- [ ] Transparency mapping (alpha → color 0)
- [ ] Metadata parsing (JSON read)
- [ ] X-center calculation (proper alignment)

### Integration Tests
- [ ] Sequence creation (interpolated sequences)
- [ ] Frame selection (sub-frame timing)
- [ ] Rendering (sprites display correctly)
- [ ] Fallback (original behavior preserved)

### In-Game Tests
- [ ] Bigexp explosion - smooth animation
- [ ] Aliens - smooth movement
- [ ] Droid - smooth animation
- [ ] Fire - smooth effects
- [ ] Toggle on/off - no crashes
- [ ] Performance - 60 FPS maintained
- [ ] Memory - no leaks

## Success Criteria

✅ **Functional**:
- Smooth 60 FPS animations visible in-game
- Proper sprite alignment (no "jumping")
- Toggle works (on/off)
- Original behavior preserved when disabled

✅ **Performance**:
- Maintains 60 FPS rendering
- Memory usage acceptable (<200MB increase)
- Load time reasonable (<2 seconds)

✅ **Quality**:
- Animations look smooth and natural
- No visual artifacts or glitches
- Consistent with original art style

✅ **Robustness**:
- Graceful fallback if files missing
- No crashes on toggle
- Compatible with saves/demos

---

**Current Status**: Configuration system complete, ready to implement PNG loading
**Next Task**: Create `src/interp_loader.cpp` for PNG loading
**Estimated Remaining Work**: 8-12 hours of development + testing
