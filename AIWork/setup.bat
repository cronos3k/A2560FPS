@echo off
REM One-time setup script for RIFE frame interpolation
echo ========================================
echo RIFE Setup for Abuse 2025
echo ========================================
echo.

echo This script has already created the virtual environment.
echo PyTorch is currently installing in the background.
echo.
echo After PyTorch finishes installing, you need to:
echo.
echo 1. Download a RIFE model (anime-optimized recommended):
echo    - Model 4.7-4.10 (Anime): https://github.com/hzwer/ECCV2022-RIFE
echo    - Model 4.25 (General):   https://drive.google.com/file/d/1SLukXz-5hzGpVxVdYu8lXMU2H3TT1yKn/view
echo.
echo 2. Extract the model to: Practical-RIFE\train_log\
echo.
echo 3. Run: run_interpolation.bat
echo.
echo ========================================

pause
