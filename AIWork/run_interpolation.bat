@echo off
REM Batch script to run the complete frame interpolation workflow
REM Uses the Python virtual environment created in AIWork

echo ========================================
echo Abuse 2025 - AI Frame Interpolation
echo ========================================
echo.

REM Activate virtual environment
call venv\Scripts\activate.bat

echo [1/5] Converting PCX frames to PNG...
python convert_pcx_to_png.py
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to convert frames
    pause
    exit /b 1
)

echo.
echo [2/5] Normalizing frames (padding to uniform dimensions)...
python normalize_frames.py
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to normalize frames
    pause
    exit /b 1
)

echo.
echo [3/5] Running RIFE interpolation (CPU mode - may take 5-10 minutes)...
python interpolate_sprites.py
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to interpolate frames
    pause
    exit /b 1
)

echo.
echo [4/5] Denormalizing frames (cropping back to original sizes)...
python denormalize_frames.py
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to denormalize frames
    pause
    exit /b 1
)

echo.
echo [5/5] Creating comparison sheets...
python compare_results.py
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to create comparisons
    pause
    exit /b 1
)

echo.
echo Opening results directory...
explorer frame-interpolation\comparisons

echo.
echo ========================================
echo Interpolation complete!
echo ========================================
echo.
echo Results saved to: frame-interpolation\
echo - png-frames\     : Original frames as PNG
echo - normalized\     : Padded frames for RIFE
echo - metadata\       : Transformation metadata (JSON)
echo - interpolated\   : AI-generated frames (normalized)
echo - final\          : AI-generated 60 FPS frames (original sizes!)
echo - comparisons\    : Side-by-side comparisons and GIFs
echo.

pause
