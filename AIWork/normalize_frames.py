#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Normalize sprite frames to uniform dimensions for RIFE processing.
Creates JSON metadata to track transformations for reversal.
"""

import sys
import json
from pathlib import Path
from PIL import Image

# Fix Windows console encoding
if sys.platform == 'win32':
    sys.stdout.reconfigure(encoding='utf-8')

def analyze_sequence(sequence_dir):
    """
    Analyze a sequence to find maximum dimensions.

    Returns:
        (max_width, max_height, frame_info)
    """
    frames = sorted(sequence_dir.glob("*.png"))

    if not frames:
        return None, None, []

    max_width = 0
    max_height = 0
    frame_info = []

    for frame_path in frames:
        img = Image.open(frame_path)
        w, h = img.size

        max_width = max(max_width, w)
        max_height = max(max_height, h)

        frame_info.append({
            "filename": frame_path.name,
            "original_width": w,
            "original_height": h
        })

    return max_width, max_height, frame_info

def normalize_frame(image, target_width, target_height, bg_color=(0, 0, 0, 0)):
    """
    Pad image to target dimensions, centered.

    Args:
        image: PIL Image
        target_width: Target width
        target_height: Target height
        bg_color: Background color for padding (RGBA)

    Returns:
        Normalized image, (pad_left, pad_top)
    """
    orig_w, orig_h = image.size

    # Calculate padding
    pad_left = (target_width - orig_w) // 2
    pad_top = (target_height - orig_h) // 2

    # Create new image with padding
    # Convert to RGBA if not already
    if image.mode != 'RGBA':
        image = image.convert('RGBA')

    normalized = Image.new('RGBA', (target_width, target_height), bg_color)
    normalized.paste(image, (pad_left, pad_top))

    return normalized, (pad_left, pad_top)

def normalize_sequence(input_dir, output_dir, metadata_file):
    """
    Normalize all frames in a sequence and save metadata.

    Args:
        input_dir: Directory with original frames
        output_dir: Directory for normalized frames
        metadata_file: Path to save JSON metadata
    """
    input_path = Path(input_dir)
    output_path = Path(output_dir)

    if not input_path.exists():
        print(f"❌ Input directory not found: {input_dir}")
        return False

    # Analyze sequence
    max_w, max_h, frame_info = analyze_sequence(input_path)

    if max_w is None:
        print(f"⚠️  No frames found in {input_dir}")
        return False

    print(f"  Sequence dimensions: {max_w}x{max_h}")
    print(f"  Frames to normalize: {len(frame_info)}")

    # Create output directory
    output_path.mkdir(parents=True, exist_ok=True)

    # Normalize each frame
    metadata = {
        "target_width": max_w,
        "target_height": max_h,
        "frames": []
    }

    for info in frame_info:
        frame_path = input_path / info["filename"]
        img = Image.open(frame_path)

        # Normalize
        normalized_img, (pad_left, pad_top) = normalize_frame(img, max_w, max_h)

        # Save normalized frame
        output_file = output_path / info["filename"]
        normalized_img.save(output_file, "PNG")

        # Add to metadata
        metadata["frames"].append({
            "filename": info["filename"],
            "original_width": info["original_width"],
            "original_height": info["original_height"],
            "pad_left": pad_left,
            "pad_top": pad_top,
            "normalized_width": max_w,
            "normalized_height": max_h
        })

    # Save metadata
    with open(metadata_file, 'w') as f:
        json.dump(metadata, f, indent=2)

    print(f"✅ Normalized {len(frame_info)} frames")
    print(f"  Metadata: {metadata_file}")

    return True

def main():
    """Main normalization routine."""
    print("🔧 Normalizing Sprite Frames for RIFE\n")

    # Base directories
    png_base = Path("./frame-interpolation/png-frames")
    normalized_base = Path("./frame-interpolation/normalized")
    metadata_base = Path("./frame-interpolation/metadata")

    if not png_base.exists():
        print(f"❌ PNG frames not found: {png_base}")
        return 1

    # Find all sprite collections
    sprite_dirs = [d for d in png_base.iterdir() if d.is_dir()]

    if not sprite_dirs:
        print(f"❌ No sprite directories found")
        return 1

    print(f"Found {len(sprite_dirs)} sprite collections\n")

    # Create metadata directory
    metadata_base.mkdir(parents=True, exist_ok=True)

    success_count = 0

    # Process each collection
    for sprite_dir in sprite_dirs:
        sequence_dir = sprite_dir / "sequence"

        if not sequence_dir.exists():
            print(f"⚠️  Skipping {sprite_dir.name} - no sequence directory")
            continue

        print(f"📁 Processing: {sprite_dir.name}")

        # Create output paths
        normalized_dir = normalized_base / sprite_dir.name / "sequence"
        metadata_file = metadata_base / f"{sprite_dir.name}_metadata.json"

        if normalize_sequence(sequence_dir, normalized_dir, metadata_file):
            success_count += 1

        print()

    print(f"✅ Successfully normalized {success_count}/{len(sprite_dirs)} collections")
    print(f"\n📂 Normalized frames: {normalized_base}")
    print(f"📂 Metadata files: {metadata_base}")
    print("\nNext step: Run interpolate_normalized.py")

    return 0

if __name__ == "__main__":
    sys.exit(main())
