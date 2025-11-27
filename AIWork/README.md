# AI Frame Interpolation for Abuse Animations

## Problem Statement
The game renders at 60 FPS but animations update at 15 FPS (65ms intervals), causing choppy appearance. Each animation frame is displayed 4 times before advancing to the next frame.

## Solution Approach
Use AI-powered frame interpolation to generate intermediate frames between existing animation frames, creating smooth 60 FPS animations without changing game physics.

## Technology: RIFE (Real-Time Intermediate Flow Estimation)

### What is RIFE?
- State-of-the-art neural network for video frame interpolation
- 4-27x faster than previous methods (SuperSlomo, DAIN)
- Has anime-optimized models (v4.7-4.10) perfect for sprite work
- Real-time capable: 30+ FPS for 720p interpolation on 2080Ti

### Key Repositories
- **Practical-RIFE**: https://github.com/hzwer/Practical-RIFE
  - Recommended version: 4.25 (default) or 4.26 (latest)
  - Python <= 3.11
  
- **ECCV2022-RIFE**: https://github.com/hzwer/ECCV2022-RIFE
  - Official implementation with anime models

## Workflow

### 1. Extract Frames (DONE)
Extracted 216 frames from game sprite files:
- **bigexp**: 7 frames (explosion effects)
- **fire**: 33 frames (fire animation)
- **aliens**: 143 frames (enemy sprites)
- **droid**: 33 frames (enemy sprites)

Location: `D:\DEV\Abuse_2025\animation-frames-export\`

### 2. Interpolate Frames (TODO)
For each animation sequence:
- Convert PCX frames to PNG/JPG if needed
- Run RIFE with `--multi=4` (15 FPS → 60 FPS)
- Generate 3 intermediate frames between each original pair

### 3. Import Back to Game (TODO)
- Convert interpolated frames back to game format
- Update sprite data files (.spe)
- Test in-game appearance

## Next Steps
1. Set up Python environment with RIFE
2. Convert PCX frames to compatible format
3. Run interpolation experiments
4. Evaluate quality on different sprite types
5. Integrate best results back into game

## Requirements
- Python <= 3.11
- PyTorch
- CUDA-capable GPU (recommended)
- ~2GB for model weights

