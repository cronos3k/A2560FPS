# Interpolated Sprite Integration Design

## Overview

Integrate AI-interpolated 60 FPS sprite animations into Abuse 2025 as an optional, non-destructive feature that preserves the original sprite system.

## System Analysis

### Current System (15 FPS physics, 60 FPS rendering)

**Physics**: Updates every 65ms (ticks 0, 4, 8, 12, 16, ...)
**Rendering**: Every 16.67ms (60 FPS)
**Problem**: Between physics updates, positions interpolated but animation frames are NOT
**Result**: Same animation frame shown 4 times → choppy motion

### Animation Pipeline

```
CharacterType → sequence[] → figure IDs → cache.fig(id) → TransImage
                    ↓
            current_frame (short)
                    ↓
        sequence->get_frame(current_frame, direction)
                    ↓
                drawer() → PutImage()
```

### Key Files

- `items.h`: `figure` struct (forward/backward TransImages, xcfg)
- `seq.h`: `sequence` class (array of figure IDs)
- `objects.cpp`: `drawer()`, `picture()`, `next_picture()`
- `cache.h/cpp`: Figure loading/caching system
- `setup.h`: Settings class

## Implementation Design

### 1. Configuration Option

**File**: `src/sdlport/setup.h`
**Addition**:
```cpp
class Settings {
    // ... existing fields ...

    // AI-interpolated sprites (60 FPS smooth animations)
    bool interpolated_sprites_enabled;  // Enable 4x interpolated sprite frames
```

**File**: `src/sdlport/setup.cpp`
**Additions**:
- Read/write setting from config file
- Default to `false` (preserve original behavior)

### 2. Parallel Sprite Files

**Strategy**: Create separate .spe files for interpolated frames

**Structure**:
```
art/bigexp.spe        (original 7 frames)
art/bigexp_interp.spe (interpolated 25 frames)
art/aliens.spe        (original 143 frames)
art/aliens_interp.spe (interpolated 569 frames)
...
```

**Naming Convention**:
- Original figure names: `bigexp0`, `bigexp1`, ... `bigexp6`
- Interpolated figure names: `bigexp_i0`, `bigexp_i1`, ... `bigexp_i24`
- Suffix `_i` prevents name conflicts

### 3. Sequence Expansion

**Current**:
```cpp
sequence seq_bigexp = {7 frames: [fig0, fig1, fig2, fig3, fig4, fig5, fig6]}
```

**With Interpolation** (optional, loaded only when enabled):
```cpp
sequence seq_bigexp_interp = {25 frames: [i0, i1, i2, i3, i4, i5, ...]}
```

**Implementation**:
- Extend `CharacterType` to track interpolated sequences
- Add `sequence **interp_seq` parallel to `sequence **seq`
- Load interpolated sequences only when `interpolated_sprites_enabled == true`

### 4. Sub-Frame Timing

**Calculate render frame offset**:
```cpp
// In level.cpp or objects.cpp
float get_render_frame_offset() {
    // Time since last physics update (0.0 to 1.0)
    // If rendering at 60 FPS and physics at 15 FPS:
    //   Render frame 0: offset = 0.00 → select interp frame 0
    //   Render frame 1: offset = 0.25 → select interp frame 1
    //   Render frame 2: offset = 0.50 → select interp frame 2
    //   Render frame 3: offset = 0.75 → select interp frame 3
    //   Render frame 4: offset = 0.00 → next physics frame

    static int last_physics_tick = 0;
    int current_tick = current_vt;  // from level.cpp

    // Calculate sub-frame position
    float physics_delta = 65.0f; // ms between physics updates
    float offset = (current_tick - last_physics_tick) / physics_delta;

    if (offset >= 1.0f) {
        last_physics_tick = current_tick;
        offset = 0.0f;
    }

    return offset;
}
```

### 5. Frame Selection Logic

**Modify `sequence::get_frame()`** or **add new method**:

```cpp
// In seq.h
class sequence {
    sequence *interp_version;  // Points to interpolated version if loaded

    TransImage *get_frame_interpolated(short physics_frame,
                                       float sub_frame_offset,
                                       int direction) {
        if (!interp_version) {
            // Fallback to original
            return get_frame(physics_frame, direction);
        }

        // Map physics frame to interpolated frame range
        // If physics frame 5, and 4x interpolation:
        //   interp frames 20-23 correspond to physics frame 5
        int interp_base = physics_frame * 4;
        int sub_frame = (int)(sub_frame_offset * 4.0f);
        int interp_frame = interp_base + sub_frame;

        // Bounds check
        if (interp_frame >= interp_version->length()) {
            interp_frame = interp_version->length() - 1;
        }

        // Get interpolated frame
        if (direction > 0)
            return cache.fig(interp_version->seq[interp_frame])->forward;
        else
            return cache.fig(interp_version->seq[interp_frame])->backward;
    }
};
```

### 6. Alignment/Positioning

**Problem**: Interpolated frames have varying dimensions (from metadata JSON)
**Solution**: Interpolate `xcfg` (x-center) values

**Metadata Structure**:
```json
{
  "frames": [
    {
      "filename": "0.png",
      "original_width": 97,
      "original_height": 107,
      "pad_left": 20,
      "pad_top": 7
    },
    ...
  ]
}
```

**Implementation**:
When creating .spe files, calculate and store xcfg for each interpolated frame:
```python
def interpolate_xcfg(frame1_metadata, frame2_metadata, ratio):
    """
    Calculate x-center for interpolated frame.

    Original frames have xcfg values from game data.
    Interpolated frames need xcfg calculated based on:
    1. Width of interpolated frame
    2. Ratio between original frames (0.0 to 1.0)
    """
    # Get original widths
    w1 = frame1_metadata['original_width']
    w2 = frame2_metadata['original_width']

    # Interpolate width
    interp_width = int(w1 * (1.0 - ratio) + w2 * ratio)

    # Get original x-centers (usually width // 2)
    xcfg1 = w1 // 2
    xcfg2 = w2 // 2

    # Interpolate x-center
    xcfg_interp = int(xcfg1 * (1.0 - ratio) + xcfg2 * ratio)

    return xcfg_interp, interp_width
```

### 7. File Loading

**Conditional Loading**:
```cpp
// In chars.cpp or cache initialization
if (flags->interpolated_sprites_enabled) {
    // Load interpolated .spe files
    load_interpolated_sprites("art/bigexp_interp.spe");
    load_interpolated_sprites("art/aliens_interp.spe");
    load_interpolated_sprites("art/droid_interp.spe");
    load_interpolated_sprites("art/fire_interp.spe");

    // Link interpolated sequences to original sequences
    link_interpolated_sequences();
}
```

## Simplified Implementation Approach

**Key Insight**: Creating .spe files from scratch is complex. Instead, load PNG frames directly into the engine when interpolation is enabled.

**Benefits**:
- Simpler implementation
- Faster iteration/testing
- PNGs already in correct format from AI processing
- No binary format reverse engineering needed

### Phase 1: PNG Loading System
1. Create PNG loader for interpolated frames
2. Read interpolated PNGs from `AIWork/frame-interpolation/final/`
3. Read metadata JSONs for frame dimensions/alignment
4. Convert to TransImage format
5. Register in cache with unique names (`bigexp_i0`, `bigexp_i1`, etc.)

### Phase 2: Configuration System
1. Add setting to `setup.h`
2. Add config file read/write in `setup.cpp`
3. Add command-line option `--interpolated-sprites`
4. Add GUI toggle (options menu)

### Phase 3: Core Engine Changes
1. Extend `sequence` class with interpolated variant pointer
2. Add sub-frame timing calculation
3. Modify `picture()` or `get_frame()` to use interpolated frames
4. Update drawer() to use new frame selection

### Phase 4: Integration & Testing
1. Load interpolated .spe files conditionally
2. Link sequences
3. Test in-game
4. Verify alignment and positioning
5. Performance testing

## File Checklist

### New Files
- [ ] `AIWork/build_interpolated_spe.py` - Python tool to create .spe files
- [ ] `art/bigexp_interp.spe` - Interpolated explosion sprites
- [ ] `art/aliens_interp.spe` - Interpolated alien sprites
- [ ] `art/droid_interp.spe` - Interpolated droid sprites
- [ ] `art/fire_interp.spe` - Interpolated fire sprites
- [ ] `AIWork/INTERPOLATION_INTEGRATION_DESIGN.md` - This document

### Modified Files
- [ ] `src/sdlport/setup.h` - Add setting
- [ ] `src/sdlport/setup.cpp` - Read/write setting
- [ ] `src/seq.h` - Add interpolated sequence support
- [ ] `src/seq.cpp` - Implement interpolated frame selection
- [ ] `src/objects.cpp` - Sub-frame timing, modify drawer()
- [ ] `src/game.cpp` or `src/level.cpp` - Timing calculations
- [ ] `src/chars.cpp` or init code - Load interpolated sprites

## Technical Constraints

1. **Memory**: Only load interpolated sprites when enabled
2. **Performance**: Frame selection must be fast (1 multiply, 1 add, 1 lookup)
3. **Compatibility**: Must work with saves/demos from original system
4. **Fallback**: Gracefully degrade to original sprites if interpolated not available

## Benefits

✅ **Non-destructive**: Original sprite system completely preserved
✅ **Optional**: Can toggle on/off via config and GUI
✅ **Performant**: Minimal overhead (simple calculation + lookup)
✅ **Smooth**: Proper 60 FPS animation matching 60 FPS rendering
✅ **Aligned**: Correct sprite positioning maintained
✅ **Compatible**: Works with existing game saves and demos

## Risks & Mitigations

**Risk**: Memory usage increase (4x sprites)
**Mitigation**: Only load when enabled, cache system handles memory pressure

**Risk**: Incorrect alignment causes sprites to "jump"
**Mitigation**: Interpolate xcfg, test thoroughly

**Risk**: Breaking original behavior
**Mitigation**: Feature completely optional, defaults OFF

**Risk**: Performance impact
**Mitigation**: Minimal calculation overhead, same rendering pipeline

---

**Status**: Design Complete - Ready for Implementation
**Next Step**: Build Python tool to create .spe files from interpolated PNGs
