#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Run RIFE frame interpolation on sprite animations.
Generates intermediate frames to smooth animations from 15 FPS to 60 FPS.
"""

import os
import sys
import subprocess
from pathlib import Path

# Fix Windows console encoding
if sys.platform == 'win32':
    sys.stdout.reconfigure(encoding='utf-8')

def check_rife_setup():
    """Verify RIFE is installed and configured."""
    rife_dir = Path("Practical-RIFE")

    if not rife_dir.exists():
        print("❌ Practical-RIFE not found")
        print("   Run: python setup_rife.py")
        return False

    if not (rife_dir / "inference_video.py").exists():
        print("❌ inference_video.py not found in Practical-RIFE")
        return False

    # Check for model
    train_log = rife_dir / "train_log"
    if not train_log.exists() or not list(train_log.glob("*.pkl")):
        print("❌ Model not found in train_log/")
        print("   Download a model from:")
        print("   https://github.com/hzwer/Practical-RIFE#model-list")
        return False

    print("✅ RIFE setup verified")
    return True

def interpolate_sequence(input_dir, output_dir, multiplier=4):
    """
    Run RIFE interpolation on a sequence of frames.

    Args:
        input_dir: Directory containing sequence (0.png, 1.png, 2.png, ...)
        output_dir: Output directory for interpolated frames
        multiplier: Frame multiplier (4 = 15 FPS -> 60 FPS)
    """
    input_path = Path(input_dir)
    output_path = Path(output_dir)

    if not input_path.exists():
        print(f"❌ Input directory not found: {input_dir}")
        return False

    # Count input frames
    input_frames = sorted(input_path.glob("*.png"))
    if len(input_frames) < 2:
        print(f"⚠️  Need at least 2 frames to interpolate, found {len(input_frames)}")
        return False

    print(f"  Input: {len(input_frames)} frames")
    print(f"  Multiplier: {multiplier}x")
    print(f"  Expected output: ~{len(input_frames) * multiplier} frames")

    # Create output directory
    output_path.mkdir(parents=True, exist_ok=True)

    # Run RIFE
    print("  🎬 Running RIFE interpolation...")

    # Force CPU mode (RTX 5090 sm_120 not supported by PyTorch 2.6)
    env = os.environ.copy()
    env['CUDA_VISIBLE_DEVICES'] = ''  # Disable CUDA

    try:
        result = subprocess.run([
            sys.executable,
            "Practical-RIFE/inference_video.py",
            f"--multi={multiplier}",  # Multiply frame count by 4 (NOT exp!)
            f"--img={input_path}/",
            f"--output={output_path}/output.mp4",  # Specify output (needed even for PNG)
            "--png",  # Output as PNG
        ], cwd=".", capture_output=True, text=True, env=env)

        if result.returncode != 0:
            print(f"❌ RIFE failed:")
            print(result.stderr)
            return False

        # RIFE outputs to ./vid_out/ when using --png
        # Move to our desired location
        rife_output = Path("vid_out")
        if rife_output.exists() and list(rife_output.glob("*.png")):
            # Copy files to our output directory
            import shutil
            for frame in sorted(rife_output.glob("*.png")):
                dest = output_path / frame.name
                shutil.copy2(frame, dest)

            # Clean up vid_out
            shutil.rmtree(rife_output)

            print(f"✅ Interpolation complete")
            output_frames = len(list(output_path.glob("*.png")))
            print(f"  Output: {output_frames} frames")
            return True
        else:
            print(f"⚠️  Output directory not found or empty: {rife_output}")
            print(f"  STDERR: {result.stderr[:500]}")
            return False

    except Exception as e:
        print(f"❌ Error running RIFE: {e}")
        return False

def main():
    """Main interpolation routine."""
    print("🎬 RIFE Sprite Animation Interpolation\n")

    # Check setup
    if not check_rife_setup():
        return 1

    # Use normalized frames instead of original PNG
    png_base = Path("./frame-interpolation/normalized")

    if not png_base.exists():
        print(f"❌ PNG frames not found: {png_base}")
        print("   Run: python convert_pcx_to_png.py")
        return 1

    # Find all sprite collections with sequences
    sprite_dirs = [d for d in png_base.iterdir() if d.is_dir()]

    if not sprite_dirs:
        print(f"❌ No sprite directories found in {png_base}")
        return 1

    print(f"Found {len(sprite_dirs)} sprite collections:\n")

    # Process each collection
    output_base = Path("./frame-interpolation/interpolated")

    success_count = 0
    for sprite_dir in sprite_dirs:
        sequence_dir = sprite_dir / "sequence"

        if not sequence_dir.exists():
            print(f"⚠️  Skipping {sprite_dir.name} - no sequence directory")
            continue

        print(f"📁 Processing: {sprite_dir.name}")

        output_dir = output_base / sprite_dir.name

        if interpolate_sequence(sequence_dir, output_dir, multiplier=4):
            success_count += 1

        print()

    print(f"\n✅ Successfully interpolated {success_count}/{len(sprite_dirs)} collections")
    print(f"\n📂 Interpolated frames saved to: {output_base}")

    if success_count > 0:
        print("\nNext step: Review interpolated frames and integrate into game")

    return 0

if __name__ == "__main__":
    sys.exit(main())
