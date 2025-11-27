#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Convert extracted PCX sprite frames to PNG format for RIFE processing.
Organizes frames by animation sequence for proper interpolation.
"""

import os
import sys
from pathlib import Path
from PIL import Image

# Fix Windows console encoding
if sys.platform == 'win32':
    sys.stdout.reconfigure(encoding='utf-8')

def convert_pcx_to_png(input_dir, output_dir):
    """
    Convert all PCX files in input_dir to PNG in output_dir.

    Args:
        input_dir: Source directory containing PCX files
        output_dir: Destination directory for PNG files
    """
    input_path = Path(input_dir)
    output_path = Path(output_dir)

    if not input_path.exists():
        print(f"❌ Input directory not found: {input_dir}")
        return 0

    # Create output directory
    output_path.mkdir(parents=True, exist_ok=True)

    # Find all PCX files
    pcx_files = sorted(input_path.glob("*.pcx"))

    if not pcx_files:
        print(f"⚠️  No PCX files found in {input_dir}")
        return 0

    converted = 0
    for pcx_file in pcx_files:
        try:
            # Open PCX and convert to PNG
            img = Image.open(pcx_file)

            # Generate output filename
            png_file = output_path / (pcx_file.stem + ".png")

            # Save as PNG
            img.save(png_file, "PNG")
            converted += 1

            if converted % 10 == 0:
                print(f"  Converted {converted}/{len(pcx_files)} files...")

        except Exception as e:
            print(f"❌ Failed to convert {pcx_file.name}: {e}")

    print(f"✅ Converted {converted} PCX files to PNG in {output_dir}")
    return converted

def organize_sequences(base_dir):
    """
    Organize sprite sequences by renaming to sequential numbers.
    RIFE requires input images named as: 0.png, 1.png, 2.png, etc.

    Args:
        base_dir: Directory containing PNG files
    """
    base_path = Path(base_dir)
    png_files = sorted(base_path.glob("*.png"))

    if not png_files:
        return 0

    print(f"  Organizing {len(png_files)} files for RIFE...")

    # Create a sequences subdirectory
    seq_dir = base_path / "sequence"
    seq_dir.mkdir(exist_ok=True)

    # Rename files to sequential numbers
    for idx, png_file in enumerate(png_files):
        new_name = seq_dir / f"{idx}.png"
        # Copy instead of move to preserve originals
        img = Image.open(png_file)
        img.save(new_name, "PNG")

    print(f"✅ Created sequence with {len(png_files)} frames in {seq_dir}")
    return len(png_files)

def main():
    """Main conversion routine."""
    print("🎨 Converting PCX Sprite Frames to PNG\n")

    # Base directories
    export_dir = Path("../animation-frames-export")
    png_dir = Path("./frame-interpolation/png-frames")

    if not export_dir.exists():
        print(f"❌ Export directory not found: {export_dir}")
        print("   Run spe-dump first to extract sprite frames")
        return 1

    # Find all sprite directories
    sprite_dirs = [d for d in export_dir.iterdir() if d.is_dir()]

    if not sprite_dirs:
        print(f"❌ No sprite directories found in {export_dir}")
        return 1

    print(f"Found {len(sprite_dirs)} sprite collections:")
    for sprite_dir in sprite_dirs:
        print(f"  - {sprite_dir.name}")

    print()

    total_converted = 0

    # Convert each sprite collection
    for sprite_dir in sprite_dirs:
        print(f"\n📁 Processing: {sprite_dir.name}")

        # Create output directory
        output_dir = png_dir / sprite_dir.name

        # Convert PCX to PNG
        count = convert_pcx_to_png(sprite_dir, output_dir)
        total_converted += count

        # Organize into sequences for RIFE
        if count > 0:
            organize_sequences(output_dir)

    print(f"\n✅ Total converted: {total_converted} frames")
    print(f"\n📂 PNG frames saved to: {png_dir}")
    print("\nNext step: Run interpolate_sprites.py")

    return 0

if __name__ == "__main__":
    sys.exit(main())
