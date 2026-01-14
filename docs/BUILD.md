# Cloud Toolkit Multi-Platform Build Guide

## Quick Start

### GitHub Actions (Recommended)

Push to main branch or create a release tag to trigger builds:

```bash
# Create a version tag
git tag v1.0.0
git push origin v1.0.0
```

Or manually trigger from GitHub:
1. Go to **Actions** tab
2. Select **Build All Platforms**
3. Click **Run workflow**

### Local Build

#### Windows
```cmd
build-windows.bat
```
Output: `Output\cloud-toolkit-windows-*.exe`

#### macOS
```bash
./build-macos.sh
```
Output: `cloud-toolkit-macos-*.dmg`

#### Linux
```bash
./build-linux.sh
```
Output: `cloud-toolkit-*.deb`

## Generated Artifacts

| Platform | Format | Installation |
|----------|--------|--------------|
| Windows | `.exe` installer | Run installer, follow wizard |
| macOS | `.dmg` disk image | Mount, drag to Applications |
| Linux | `.deb` package | `sudo apt install ./cloud-toolkit-*.deb` |

## CI/CD Workflow

The GitHub Actions workflow (`.github/workflows/build-all-platforms.yml`) performs:

1. **Analysis & Testing**
   - Code formatting check
   - Dart analyzer
   - Unit tests with coverage

2. **Platform-Specific Build**
   - Windows: Inno Setup installer
   - Linux: DEB package creation
   - macOS: DMG disk image

3. **Release Creation**
   - Downloads all artifacts
   - Creates GitHub release
   - Uploads all platform installers

## Requirements

### Windows
- Windows 10/11
- Inno Setup 6.x

### macOS
- macOS 10.15+
- Xcode command line tools
- `create-dmg` (via Homebrew)

### Linux
- Ubuntu 20.04+ or similar
- `dpkg-deb` for DEB packaging

## Troubleshooting

### Windows Build Fails
- Ensure Visual Studio Build Tools are installed
- Run `flutter doctor` to check dependencies

### macOS DMG Creation Fails
- Install Homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- Install create-dmg: `brew install create-dmg`

### Linux DEB Build Fails
- Ensure `dpkg-deb` is installed: `sudo apt-get install dpkg-dev`
