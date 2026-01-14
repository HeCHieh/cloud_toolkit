@echo off
REM Cloud Toolkit Windows Build Script
REM Run this on Windows machine

echo ============================================
echo Cloud Toolkit - Windows Build Script
echo ============================================

REM Check Flutter
flutter --version
if %errorlevel% neq 0 (
    echo [ERROR] Flutter not found. Please install Flutter first.
    exit /b 1
)

echo.
echo [1/5] Getting dependencies...
flutter pub get
if %errorlevel% neq 0 (
    echo [ERROR] Failed to get dependencies
    exit /b 1
)

echo.
echo [2/5] Generating code...
flutter pub run build_runner build --delete-conflicting-outputs
if %errorlevel% neq 0 (
    echo [ERROR] Code generation failed
    exit /b 1
)

echo.
echo [3/5] Building Windows release...
flutter build windows --release
if %errorlevel% neq 0 (
    echo [ERROR] Build failed
    exit /b 1
)

echo.
echo [4/5] Creating output directory...
if not exist "output" mkdir output

echo.
echo [5/5] Building installer with Inno Setup...
choco install innosetup -y 2>nul
iscc ".github\workflows\installer.iss"
if %errorlevel% neq 0 (
    echo [ERROR] Installer creation failed
    exit /b 1
)

echo.
echo ============================================
echo Build complete!
echo Installer location: output\cloud-toolkit-setup.exe
echo ============================================
pause
