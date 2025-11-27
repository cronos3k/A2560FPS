#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Check if RIFE setup is complete and ready to run.
"""

import sys
import os
from pathlib import Path

# Fix Windows console encoding
if sys.platform == 'win32':
    sys.stdout.reconfigure(encoding='utf-8')

def check_venv():
    """Check if running in virtual environment."""
    in_venv = hasattr(sys, 'real_prefix') or (
        hasattr(sys, 'base_prefix') and sys.base_prefix != sys.prefix
    )
    if in_venv:
        print("✅ Running in virtual environment")
        print(f"   Python: {sys.version.split()[0]}")
        return True
    else:
        print("❌ NOT running in virtual environment")
        print("   Run: venv\\Scripts\\activate")
        return False

def check_pytorch():
    """Check if PyTorch is installed with CUDA."""
    try:
        import torch
        print(f"✅ PyTorch installed: {torch.__version__}")

        if torch.cuda.is_available():
            print(f"✅ CUDA available: {torch.version.cuda}")
            print(f"✅ GPU detected: {torch.cuda.get_device_name(0)}")
            return True
        else:
            print("⚠️  CUDA not available (will use CPU - slower)")
            return True
    except ImportError:
        print("❌ PyTorch not installed")
        print("   Run: pip install torch torchvision --index-url https://download.pytorch.org/whl/cu124")
        return False

def check_dependencies():
    """Check if required packages are installed."""
    packages = {
        'PIL': 'Pillow',
        'cv2': 'opencv-python',
        'tqdm': 'tqdm',
        'moviepy': 'moviepy'
    }

    all_installed = True
    for module_name, package_name in packages.items():
        try:
            __import__(module_name)
            print(f"✅ {package_name} installed")
        except ImportError:
            print(f"❌ {package_name} not installed")
            all_installed = False

    return all_installed

def check_rife():
    """Check if RIFE is cloned."""
    rife_dir = Path("Practical-RIFE")
    if rife_dir.exists() and (rife_dir / "inference_video.py").exists():
        print(f"✅ Practical-RIFE cloned")
        return True
    else:
        print(f"❌ Practical-RIFE not found")
        print("   Run: git clone https://github.com/hzwer/Practical-RIFE.git")
        return False

def check_model():
    """Check if RIFE model is downloaded."""
    train_log = Path("Practical-RIFE/train_log")

    if not train_log.exists():
        print("❌ train_log directory not found")
        print("   Create: Practical-RIFE\\train_log\\")
        return False

    model_files = list(train_log.glob("*.pkl")) + list(train_log.glob("*.pth"))

    if model_files:
        print(f"✅ Model files found: {len(model_files)} files")
        for f in model_files[:3]:  # Show first 3
            print(f"   - {f.name}")
        if len(model_files) > 3:
            print(f"   ... and {len(model_files) - 3} more")
        return True
    else:
        print("❌ No model files found in train_log/")
        print("   Download model from: https://github.com/hzwer/Practical-RIFE#model-list")
        print("   Extract to: Practical-RIFE\\train_log\\")
        return False

def check_sprites():
    """Check if sprite frames are extracted."""
    export_dir = Path("../animation-frames-export")

    if not export_dir.exists():
        print("⚠️  Sprite frames not extracted yet")
        print("   Location: ../animation-frames-export/")
        return False

    sprite_dirs = [d for d in export_dir.iterdir() if d.is_dir()]
    pcx_count = sum(len(list(d.glob("*.pcx"))) for d in sprite_dirs)

    if pcx_count > 0:
        print(f"✅ Sprite frames extracted: {pcx_count} frames")
        print(f"   Collections: {', '.join(d.name for d in sprite_dirs)}")
        return True
    else:
        print("⚠️  No sprite frames found")
        return False

def main():
    """Main check routine."""
    print("="*60)
    print("RIFE Setup Check")
    print("="*60)
    print()

    checks = {
        "Virtual Environment": check_venv(),
        "PyTorch + CUDA": check_pytorch(),
        "Dependencies": check_dependencies(),
        "RIFE Repository": check_rife(),
        "Model Weights": check_model(),
        "Sprite Frames": check_sprites()
    }

    print()
    print("="*60)
    print("Summary")
    print("="*60)

    for name, status in checks.items():
        symbol = "✅" if status else "❌"
        print(f"{symbol} {name}")

    print()

    ready = all(checks.values())

    if ready:
        print("🎉 ALL CHECKS PASSED! Ready to run interpolation!")
        print()
        print("Next step:")
        print("  run_interpolation.bat")
        print()
        print("Or manually:")
        print("  python convert_pcx_to_png.py")
        print("  python interpolate_sprites.py")
        print("  python compare_results.py")
        return 0
    else:
        print("⚠️  Setup incomplete. Please fix the issues above.")

        if not checks["Model Weights"]:
            print()
            print("📥 Most likely you just need to download the model:")
            print("   See: download_model.md")

        return 1

if __name__ == "__main__":
    sys.exit(main())
