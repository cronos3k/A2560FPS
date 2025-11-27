#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Compare original and interpolated sprite frames side-by-side.
Generates comparison sheets to evaluate interpolation quality.
"""

import sys
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

# Fix Windows console encoding
if sys.platform == 'win32':
    sys.stdout.reconfigure(encoding='utf-8')

def create_comparison_sheet(original_frames, interpolated_frames, output_file, title="Frame Comparison"):
    """
    Create a visual comparison sheet showing original vs interpolated frames.

    Args:
        original_frames: List of original frame paths
        interpolated_frames: List of interpolated frame paths
        output_file: Path to save comparison image
        title: Title for the comparison sheet
    """
    if not original_frames:
        print("❌ No original frames provided")
        return False

    # Load first frame to get dimensions
    first_frame = Image.open(original_frames[0])
    frame_width, frame_height = first_frame.size

    # Calculate layout
    frames_per_row = min(8, len(original_frames))
    rows_needed = (len(original_frames) + frames_per_row - 1) // frames_per_row

    # Add space for interpolated frames
    row_height = frame_height * 2 + 40  # Original + interpolated + labels
    margin = 20
    title_height = 40

    sheet_width = (frame_width + margin) * frames_per_row + margin
    sheet_height = title_height + (row_height + margin) * rows_needed + margin

    # Create blank sheet
    sheet = Image.new('RGB', (sheet_width, sheet_height), color=(40, 40, 40))
    draw = ImageDraw.Draw(sheet)

    # Draw title
    try:
        font = ImageFont.truetype("arial.ttf", 24)
        small_font = ImageFont.truetype("arial.ttf", 12)
    except:
        font = ImageFont.load_default()
        small_font = ImageFont.load_default()

    # Center title
    title_bbox = draw.textbbox((0, 0), title, font=font)
    title_width = title_bbox[2] - title_bbox[0]
    draw.text(((sheet_width - title_width) // 2, 10), title, fill=(255, 255, 255), font=font)

    # Place frames
    y_offset = title_height + margin

    for idx, orig_path in enumerate(original_frames):
        row = idx // frames_per_row
        col = idx % frames_per_row

        x = margin + col * (frame_width + margin)
        y = y_offset + row * (row_height + margin)

        # Original frame
        try:
            orig_img = Image.open(orig_path)
            sheet.paste(orig_img, (x, y))
            draw.text((x, y - 15), f"Orig {idx}", fill=(200, 200, 200), font=small_font)
        except Exception as e:
            print(f"⚠️  Failed to load {orig_path}: {e}")

        # Interpolated frame (if exists)
        if idx < len(interpolated_frames):
            try:
                interp_img = Image.open(interpolated_frames[idx])
                sheet.paste(interp_img, (x, y + frame_height + 20))
                draw.text((x, y + frame_height + 5), f"AI {idx}", fill=(100, 255, 100), font=small_font)
            except Exception as e:
                print(f"⚠️  Failed to load interpolated frame: {e}")

    # Save comparison sheet
    sheet.save(output_file, "PNG")
    print(f"✅ Saved comparison to: {output_file}")
    return True

def create_animation_preview(frames, output_gif, duration=100):
    """
    Create an animated GIF to preview the animation.

    Args:
        frames: List of frame paths
        output_gif: Path to save GIF
        duration: Frame duration in milliseconds
    """
    if not frames:
        return False

    images = []
    for frame_path in frames:
        try:
            img = Image.open(frame_path)
            images.append(img)
        except Exception as e:
            print(f"⚠️  Failed to load {frame_path}: {e}")

    if not images:
        return False

    # Save as animated GIF
    images[0].save(
        output_gif,
        save_all=True,
        append_images=images[1:],
        duration=duration,
        loop=0
    )

    print(f"✅ Saved animation preview: {output_gif}")
    return True

def main():
    """Main comparison routine."""
    print("📊 Creating Frame Comparison Sheets\n")

    # Paths
    png_dir = Path("./frame-interpolation/png-frames")
    interpolated_dir = Path("./frame-interpolation/interpolated")
    comparison_dir = Path("./frame-interpolation/comparisons")

    if not png_dir.exists():
        print(f"❌ PNG frames not found: {png_dir}")
        return 1

    # Create comparison directory
    comparison_dir.mkdir(parents=True, exist_ok=True)

    # Find sprite collections
    sprite_dirs = [d for d in png_dir.iterdir() if d.is_dir()]

    if not sprite_dirs:
        print("❌ No sprite directories found")
        return 1

    # Process each collection
    for sprite_dir in sprite_dirs:
        print(f"\n📁 Processing: {sprite_dir.name}")

        # Original frames
        sequence_dir = sprite_dir / "sequence"
        if not sequence_dir.exists():
            print(f"  ⚠️  No sequence directory found")
            continue

        original_frames = sorted(sequence_dir.glob("*.png"))

        # Interpolated frames (if they exist)
        interp_dir = interpolated_dir / sprite_dir.name
        interpolated_frames = sorted(interp_dir.glob("*.png")) if interp_dir.exists() else []

        if not original_frames:
            print(f"  ⚠️  No frames found")
            continue

        print(f"  Original frames: {len(original_frames)}")
        print(f"  Interpolated frames: {len(interpolated_frames)}")

        # Create comparison sheet
        comparison_file = comparison_dir / f"{sprite_dir.name}_comparison.png"
        create_comparison_sheet(
            original_frames[:16],  # Limit to first 16 frames for readability
            interpolated_frames[:16] if interpolated_frames else [],
            comparison_file,
            title=f"{sprite_dir.name} - Original vs AI Interpolated"
        )

        # Create animation previews
        if len(original_frames) >= 2:
            # Original animation at 15 FPS (65ms per frame)
            orig_gif = comparison_dir / f"{sprite_dir.name}_original_15fps.gif"
            create_animation_preview(original_frames, orig_gif, duration=65)

        if len(interpolated_frames) >= 2:
            # Interpolated animation at 60 FPS (16ms per frame)
            interp_gif = comparison_dir / f"{sprite_dir.name}_interpolated_60fps.gif"
            create_animation_preview(interpolated_frames, interp_gif, duration=16)

    print(f"\n✅ Comparison sheets saved to: {comparison_dir}")
    print("\nOpen the PNG files to compare frame quality")
    print("Open the GIF files to preview animations")

    return 0

if __name__ == "__main__":
    sys.exit(main())
