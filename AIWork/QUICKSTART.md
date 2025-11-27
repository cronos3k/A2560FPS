# Quick Start Guide: AI Frame Interpolation for Abuse Sprites

## Overview
This directory contains tools to smooth choppy sprite animations using AI-powered frame interpolation with RIFE (Real-Time Intermediate Flow Estimation).

## The Problem
- Game renders at **60 FPS** but animations update at **15 FPS**
- Each animation frame is shown **4 times** before advancing
- Result: Choppy, stuttering animations especially noticeable in bright sequences

## The Solution
Use RIFE neural network to generate **3 intermediate frames** between each original frame, creating smooth 60 FPS animations while preserving original game physics.

## Setup (One-time)

### Step 1: Install Python 3.11 or lower
RIFE requires Python <= 3.11. Check your version:
```bash
python --version
```

If you have Python 3.12+, create a virtual environment with Python 3.11:
```bash
# Windows with conda
conda create -n rife python=3.11
conda activate rife

# Or use pyenv, etc.
```

### Step 2: Install Base Dependencies
```bash
cd AIWork
pip install -r requirements.txt
```

### Step 3: Setup RIFE
```bash
python setup_rife.py
```

This will:
- Clone Practical-RIFE repository
- Install PyTorch and dependencies
- Prompt you to download model weights

**Model Download (IMPORTANT):**
When prompted, download one of these models:
- **Model 4.25** (Recommended for most cases)
- **Model 4.7-4.10** (Optimized for anime/sprites - BEST CHOICE)

Extract to: `AIWork/Practical-RIFE/train_log/`

## Usage

### Step 1: Convert PCX to PNG
The extracted sprite frames are in PCX format. Convert them to PNG:
```bash
python convert_pcx_to_png.py
```

This will:
- Convert all 216 PCX frames to PNG
- Organize them into sequences (0.png, 1.png, 2.png, ...)
- Save to `frame-interpolation/png-frames/`

### Step 2: Run Interpolation
```bash
python interpolate_sprites.py
```

This will:
- Process each sprite collection
- Generate 3 intermediate frames between each pair
- Save interpolated frames to `frame-interpolation/interpolated/`

**Expected Results:**
- **bigexp**: 7 frames → ~28 frames (4x multiplier)
- **fire**: 33 frames → ~132 frames
- **aliens**: 143 frames → ~572 frames
- **droid**: 33 frames → ~132 frames

### Step 3: Review Results
Examine the interpolated frames in `frame-interpolation/interpolated/`

Look for:
- ✅ Smooth transitions between frames
- ✅ Preserved sprite details
- ❌ Ghosting or blurring artifacts
- ❌ Color bleeding between frames

## Next Steps (After Successful Interpolation)

1. **Quality Check**: Review interpolated frames for acceptable quality
2. **Format Conversion**: Convert PNG back to PCX if needed
3. **Game Integration**:
   - Update sprite data (.spe files)
   - Modify animation frame sequences
   - Adjust animation timing to use new frame count
4. **Testing**: Run in-game and verify smooth animations

## Troubleshooting

### "Python version too high"
RIFE requires Python <= 3.11. Use virtual environment with older Python.

### "Model not found"
Download model weights and place in `Practical-RIFE/train_log/`

### "CUDA not available"
RIFE can run on CPU but will be slower. For GPU:
```bash
pip install torch torchvision --index-url https://download.pytorch.org/whl/cu118
```

### "Out of memory"
Reduce batch size or process fewer frames at once. Edit `interpolate_sprites.py` to process sprites individually.

## Technical Details

### RIFE Models
- **4.25**: Latest general-purpose model (2024.10)
- **4.26**: Newest experimental (2024.09)
- **4.7-4.10**: Anime-optimized (best for pixel art sprites)

### Frame Interpolation
- Uses optical flow estimation
- Generates intermediate frames based on motion between frames
- Works best with consistent motion and similar frames
- May struggle with rapid color changes or teleportation

### Performance
- GPU (RTX 2080Ti): ~30 FPS for 720p interpolation
- CPU: Much slower, expect minutes per sprite sequence
- Memory: ~2GB for model + frame buffers

## File Structure
```
AIWork/
├── README.md                     # Overview and documentation
├── QUICKSTART.md                 # This file
├── requirements.txt              # Python dependencies
├── setup_rife.py                # Setup script
├── convert_pcx_to_png.py        # PCX → PNG converter
├── interpolate_sprites.py       # Main interpolation script
├── Practical-RIFE/              # RIFE implementation (created by setup)
│   └── train_log/               # Model weights go here
└── frame-interpolation/
    ├── png-frames/              # Converted PNG frames
    │   ├── bigexp/
    │   ├── fire/
    │   ├── aliens/
    │   └── droid/
    └── interpolated/            # Output interpolated frames
        ├── bigexp/
        ├── fire/
        ├── aliens/
        └── droid/
```

## References
- **Practical-RIFE**: https://github.com/hzwer/Practical-RIFE
- **ECCV2022-RIFE**: https://github.com/hzwer/ECCV2022-RIFE
- **FlowFrames** (GUI tool): https://nmkd.itch.io/flowframes
- **RIFE Paper**: https://arxiv.org/abs/2011.06294
