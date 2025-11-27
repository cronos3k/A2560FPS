#!/usr/bin/env python3
"""
Setup script for RIFE frame interpolation.
Downloads and configures Practical-RIFE for sprite animation interpolation.
"""

import os
import sys
import subprocess

def check_python_version():
    """Ensure Python version is compatible."""
    version = sys.version_info
    if version.major != 3 or version.minor > 11:
        print(f"❌ Warning: Python {version.major}.{version.minor} detected.")
        print("   RIFE requires Python <= 3.11")
        print("   Consider using a virtual environment with Python 3.11 or lower")
        return False
    print(f"✅ Python {version.major}.{version.minor} is compatible")
    return True

def clone_rife():
    """Clone the Practical-RIFE repository."""
    if os.path.exists("Practical-RIFE"):
        print("✅ Practical-RIFE already cloned")
        return True

    print("📥 Cloning Practical-RIFE repository...")
    try:
        subprocess.run([
            "git", "clone",
            "https://github.com/hzwer/Practical-RIFE.git"
        ], check=True)
        print("✅ Repository cloned successfully")
        return True
    except subprocess.CalledProcessError:
        print("❌ Failed to clone repository")
        return False

def install_dependencies():
    """Install required Python packages."""
    print("📦 Installing dependencies...")
    try:
        subprocess.run([
            sys.executable, "-m", "pip", "install", "-r",
            "Practical-RIFE/requirements.txt"
        ], check=True)
        print("✅ Dependencies installed")
        return True
    except subprocess.CalledProcessError:
        print("❌ Failed to install dependencies")
        return False

def download_model():
    """Instructions for downloading the model."""
    print("\n" + "="*60)
    print("📋 MANUAL STEP REQUIRED: Download Model Weights")
    print("="*60)
    print("\nPlease download one of the following models:")
    print("\n1. Model 4.25 (Recommended for general use)")
    print("   https://drive.google.com/file/d/1SLukXz-5hzGpVxVdYu8lXMU2H3TT1yKn/view?usp=sharing")
    print("\n2. Model 4.26 (Latest version)")
    print("   https://drive.google.com/file/d/1ZN7_F9PJzRX7VmjpXjfmCwrB8wJbNj24/view?usp=sharing")
    print("\n3. Model 4.7-4.10 (Anime optimized - BEST FOR SPRITES)")
    print("   Check: https://github.com/hzwer/ECCV2022-RIFE")
    print("\nAfter downloading:")
    print("1. Extract the model files")
    print("2. Place them in: Practical-RIFE/train_log/")
    print("3. The directory should contain: flownet.pkl and other model files")
    print("\nPress Enter after you've completed this step...")
    input()

def verify_setup():
    """Verify the setup is complete."""
    print("\n🔍 Verifying setup...")

    # Check if train_log directory exists
    if not os.path.exists("Practical-RIFE/train_log"):
        print("⚠️  train_log directory not found - model may not be installed")
        return False

    # Check if flownet.pkl exists
    model_files = []
    for root, dirs, files in os.walk("Practical-RIFE/train_log"):
        model_files.extend([f for f in files if f.endswith('.pkl') or f.endswith('.pth')])

    if not model_files:
        print("⚠️  No model files found in train_log/")
        return False

    print(f"✅ Found model files: {', '.join(model_files)}")
    return True

def main():
    """Main setup routine."""
    print("🚀 Setting up RIFE for Abuse Animation Interpolation\n")

    # Step 1: Check Python version
    if not check_python_version():
        print("\n⚠️  Continuing anyway, but you may encounter issues...")

    # Step 2: Clone repository
    if not clone_rife():
        return 1

    # Step 3: Install dependencies
    if not install_dependencies():
        return 1

    # Step 4: Download model (manual step)
    download_model()

    # Step 5: Verify setup
    if verify_setup():
        print("\n✅ Setup complete! Ready to interpolate frames.")
        print("\nNext steps:")
        print("1. Run: python convert_pcx_to_png.py")
        print("2. Run: python interpolate_sprites.py")
    else:
        print("\n⚠️  Setup incomplete - please download and install the model")
        return 1

    return 0

if __name__ == "__main__":
    sys.exit(main())
