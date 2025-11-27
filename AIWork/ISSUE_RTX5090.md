# RTX 5090 Compatibility Issue

## Problem
The RTX 5090 has CUDA compute capability `sm_120`, which is newer than what PyTorch 2.6.0+cu124 supports (up to sm_90).

## Error
```
RuntimeError: CUDA error: no kernel image is available for execution on the device
```

## Solution Applied
Forced CPU mode by patching:
1. `Practical-RIFE/train_log/RIFE_HDv3.py` - Line 14: `device = torch.device("cpu")`
2. `Practical-RIFE/inference_video.py` - Line 85: `device = torch.device("cpu")`

## Performance Impact
- **With GPU**: Would be ~1 second for all 216 frames
- **With CPU**: Will take ~5-10 minutes for all frames (slower but functional)

## Current Issue
Sprite frames have different dimensions within the same sequence:
- `0.png`: 50x46
- `1.png`: 51x46
- `10.png`: 48x24

RIFE requires all frames in a sequence to have identical dimensions.

## Next Step
Normalize all frames in a sequence to the same size (pad to largest dimensions in sequence).
