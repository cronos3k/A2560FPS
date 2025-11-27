#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Reverse the normalization on interpolated frames.
Crops frames back to original sprite dimensions using metadata.
"""

import sys
import json
from pathlib import Path
from PIL import Image

# Fix Windows console encoding
if sys.platform == 'win32':
    sys.stdout.reconfigure(encoding='utf-8')

def denormalize_frame(image, metadata_entry):
    """
    Crop normalized frame back to original dimensions.

    Args:
        image: Normalized PIL Image
        metadata_entry: Metadata dict with original dimensions and padding

    Returns:
        Cropped image at original size
    """
    pad_left = metadata_entry["pad_left"]
    pad_top = metadata_entry["pad_top"]
    orig_w = metadata_entry["original_width"]
    orig_h = metadata_entry["original_height"]

    # Crop to original size
    box = (pad_left, pad_top, pad_left + orig_w, pad_top + orig_h)
    cropped = image.crop(box)

    return cropped

def interpolate_metadata(meta_frame1, meta_frame2, ratio):
    """
    Interpolate metadata for intermediate frames.

    For frames between two originals, we need to determine what dimensions
    and padding to use. We'll use the dimensions from the nearest original frame.

    Args:
        meta_frame1: Metadata for frame before
        meta_frame2: Metadata for frame after
        ratio: Interpolation ratio (0.25, 0.5, 0.75 for 4x)

    Returns:
        Interpolated metadata dict
    """
    # Use dimensions from nearest frame
    if ratio < 0.5:
        # Closer to frame1
        return {
            "original_width": meta_frame1["original_width"],
            "original_height": meta_frame1["original_height"],
            "pad_left": meta_frame1["pad_left"],
            "pad_top": meta_frame1["pad_top"]
        }
    else:
        # Closer to frame2
        return {
            "original_width": meta_frame2["original_width"],
            "original_height": meta_frame2["original_height"],
            "pad_left": meta_frame2["pad_left"],
            "pad_top": meta_frame2["pad_top"]
        }

def denormalize_sequence(interpolated_dir, metadata_file, output_dir, multiplier=4):
    """
    Denormalize an interpolated sequence using metadata.

    Args:
        interpolated_dir: Directory with interpolated normalized frames
        metadata_file: JSON metadata from normalization
        output_dir: Output directory for final frames
        multiplier: Frame multiplier (4 = 4x interpolation)
    """
    interp_path = Path(interpolated_dir)
    output_path = Path(output_dir)

    if not interp_path.exists():
        print(f"❌ Interpolated directory not found: {interpolated_dir}")
        return False

    if not Path(metadata_file).exists():
        print(f"❌ Metadata file not found: {metadata_file}")
        return False

    # Load metadata
    with open(metadata_file, 'r') as f:
        metadata = json.load(f)

    # Create output directory
    output_path.mkdir(parents=True, exist_ok=True)

    # Get all interpolated frames (sorted numerically)
    interp_frames = sorted(interp_path.glob("*.png"),
                          key=lambda x: int(x.stem))

    if not interp_frames:
        print(f"⚠️  No interpolated frames found")
        return False

    print(f"  Interpolated frames: {len(interp_frames)}")

    # Denormalize each frame
    denormalized_count = 0

    for i, frame_path in enumerate(interp_frames):
        # Determine which original frames this is between
        original_frame_idx = i // multiplier
        within_group = i % multiplier

        # Get metadata for this frame
        if within_group == 0:
            # This is an original frame
            if original_frame_idx < len(metadata["frames"]):
                meta = metadata["frames"][original_frame_idx]
            else:
                # Beyond original frames, use last metadata
                meta = metadata["frames"][-1]
        else:
            # This is an interpolated frame
            # Interpolate metadata between surrounding originals
            if original_frame_idx + 1 < len(metadata["frames"]):
                ratio = within_group / multiplier
                meta = interpolate_metadata(
                    metadata["frames"][original_frame_idx],
                    metadata["frames"][original_frame_idx + 1],
                    ratio
                )
            else:
                # Near end, use last metadata
                meta = metadata["frames"][-1]

        # Load and denormalize
        img = Image.open(frame_path)
        denormalized = denormalize_frame(img, meta)

        # Save with same filename
        output_file = output_path / frame_path.name
        denormalized.save(output_file, "PNG")
        denormalized_count += 1

        if denormalized_count % 50 == 0:
            print(f"  Denormalized {denormalized_count}/{len(interp_frames)}...")

    print(f"✅ Denormalized {denormalized_count} frames")

    return True

def main():
    """Main denormalization routine."""
    print("🔧 Denormalizing Interpolated Frames\n")

    # Base directories
    interpolated_base = Path("./frame-interpolation/interpolated")
    metadata_base = Path("./frame-interpolation/metadata")
    final_base = Path("./frame-interpolation/final")

    if not interpolated_base.exists():
        print(f"❌ Interpolated frames not found: {interpolated_base}")
        print("   Run interpolate_normalized.py first")
        return 1

    if not metadata_base.exists():
        print(f"❌ Metadata not found: {metadata_base}")
        print("   Run normalize_frames.py first")
        return 1

    # Find all collections
    sprite_dirs = [d for d in interpolated_base.iterdir() if d.is_dir()]

    if not sprite_dirs:
        print(f"❌ No interpolated sprite directories found")
        return 1

    print(f"Found {len(sprite_dirs)} interpolated collections\n")

    success_count = 0

    # Process each collection
    for sprite_dir in sprite_dirs:
        print(f"📁 Processing: {sprite_dir.name}")

        # Paths
        interpolated_dir = sprite_dir
        metadata_file = metadata_base / f"{sprite_dir.name}_metadata.json"
        output_dir = final_base / sprite_dir.name

        if denormalize_sequence(interpolated_dir, metadata_file, output_dir):
            success_count += 1

        print()

    print(f"✅ Successfully denormalized {success_count}/{len(sprite_dirs)} collections")
    print(f"\n📂 Final frames: {final_base}")
    print("\nThese are your smooth 60 FPS sprites with original dimensions!")

    return 0

if __name__ == "__main__":
    sys.exit(main())
