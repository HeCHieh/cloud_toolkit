# Cloud Toolkit

<div align="center">

**SSH deployment tool for uploading and deploying applications to remote servers**

[![Flutter](https://img.shields.io/badge/Flutter-3.24.1-42a5f5.svg?logo=flutter)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![GitHub Actions](https://img.shields.io/badge/GitHub-Actions-2088ff.svg?logo=github-actions)](https://github.com/features/actions)

*English | [中文](README_CN.md)*

</div>

---

## Features

- **SSH/SFTP Connection** - Securely connect to remote servers
- **File Upload** - Upload files and directories via SFTP
- **Remote Execution** - Run commands on remote servers
- **Cross-Platform** - Windows, macOS, and Linux support
- **Deployment Scripts** - Pre and post-upload script execution
- **Progress Tracking** - Real-time upload progress monitoring

---

## Quick Start

### Download Pre-built Installers

Pre-built installers are available on the [Releances page](https://github.com/code-yeongyu/cloud-toolkit/releases):

| Platform | Format | Installation |
|----------|--------|--------------|
| Windows | `.exe` installer | Double-click to run installer |
| macOS | `.dmg` disk image | Mount and drag to Applications |
| Linux | `.deb` package | `sudo apt install ./cloud-toolkit_*.deb` |

### Build from Source

#### Prerequisites

| Requirement | Version | Notes |
|-------------|---------|-------|
| Flutter | 3.24.1+ | SDK required |
| Dart | 3.5.1+ | Included with Flutter |
| Git | 2.0+ | Version control |
| Visual Studio | 2022+ | Windows only, for desktop support |

#### Setup

```bash
# Clone the repository
git clone https://github.com/code-yeongyu/cloud-toolkit.git
cd cloud-toolkit

# Install dependencies
flutter pub get

# Generate required code
flutter pub run build_runner build --delete-conflicting-outputs
```

#### Run Locally

```bash
# Linux
flutter run -d linux

# Windows
flutter run -d windows

# macOS
flutter run -d macos
```

#### Build Release

```bash
# Linux
flutter build linux --release
# Output: build/linux/x64/release/bundle/

# Windows
flutter build windows --release
# Output: build/windows/runner/Release/

# macOS
flutter build macos --release
# Output: build/macos/Build/Products/Release/
```

---

## Usage Guide

### Connecting to a Server

1. Launch Cloud Toolkit
2. Click **Add Server** or **New Connection**
3. Enter server details:

| Field | Description | Required |
|-------|-------------|----------|
| Host | Server IP address or hostname | Yes |
| Port | SSH port (default: 22) | No |
| Username | SSH username | Yes |
| Authentication | Password or Private Key | Yes |
| Password/Private Key | Credential data | Yes |

4. Click **Connect**

### Uploading Files

1. After connecting, navigate to **Upload** tab
2. Select local file or directory
3. Set remote destination path
4. (Optional) Add pre-upload commands
5. (Optional) Add post-upload commands
6. Click **Upload**

#### Pre/Post Upload Scripts

Execute commands before or after file upload:

```bash
# Pre-upload: Stop existing service
systemctl stop myapp

# Post-upload: Restart service
systemctl restart myapp
```

### Deployment Tasks

Create reusable deployment configurations:

```yaml
name: Production Deploy
localPath: /path/to/dist
remotePath: /opt/myapp
preScript: |
  echo "Stopping service..."
  sudo systemctl stop myapp
postScript: |
  echo "Restarting service..."
  sudo systemctl restart myapp
```

---

## Project Structure

```
cloud-toolkit/
├── lib/
│   ├── main.dart              # App entry point
│   ├── core/
│   │   ├── theme/             # App theming
│   │   └── utils/             # Utility classes
│   ├── data/
│   │   ├── models/            # Data models
│   │   ├── repositories/      # Data repositories
│   │   └── services/          # Business services
│   └── providers/             # State management
├── linux/                     # Linux-specific code
├── macos/                     # macOS-specific code
├── windows/                   # Windows-specific code
├── docs/                      # Documentation
├── test/                      # Unit tests
└── pubspec.yaml               # Dependencies
```

### Key Components

| Component | Location | Purpose |
|-----------|----------|---------|
| `SshService` | `lib/data/services/ssh_service.dart` | SSH/SFTP operations |
| `DeployExecutor` | `lib/core/utils/deploy_executor.dart` | Deployment orchestration |
| `DeployTask` | `lib/data/models/deploy_task.dart` | Deployment configuration |
| `SshConfig` | `lib/data/models/ssh_config.dart` | SSH connection config |

---

## Development

### Setting Up Development Environment

#### Windows

```bash
# Enable Windows desktop support
flutter config --enable-windows-desktop

# Install Visual Studio dependencies
# Ensure "Desktop development with C++" workload is installed
```

#### macOS

```bash
# Enable macOS desktop support
flutter config --enable-macos-desktop

# Install Xcode from App Store
# Run: sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

#### Linux

```bash
# Enable Linux desktop support
flutter config --enable-linux-desktop

# Install dependencies
sudo apt-get update
sudo apt-get install -y clang cmake ninja-build pkg-config \
  libgtk-3-dev liblzma-dev
```

### Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Code Generation

This project uses code generation for data models:

```bash
# Generate model serializers
flutter pub run build_runner build --delete-conflicting-outputs

# Watch for changes
flutter pub run build_runner watch
```

### Adding New Features

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make changes following project conventions**
   - Models: `lib/data/models/`
   - Services: `lib/data/services/`
   - UI: `lib/ui/` or existing screens

3. **Run checks before committing**
   ```bash
   dart format --set-exit-if-changed lib/
   flutter analyze lib/
   flutter test
   ```

4. **Submit a pull request**

---

## CI/CD Pipeline

### GitHub Actions Workflow

The project uses GitHub Actions for automated builds:

**Trigger conditions:**
- Push to `main` branch
- New tag matching `v*` (e.g., `v1.0.0`)
- Manual workflow dispatch

**Build process:**
1. Code analysis and testing
2. Platform-specific builds (Windows, macOS, Linux)
3. Package creation (installer, DMG, DEB)
4. GitHub Release creation

**Configuration:** [`.github/workflows/build-all-platforms.yml`](.github/workflows/build-all-platforms.yml)

### Local Build Scripts

| Script | Platform | Output |
|--------|----------|--------|
| `build-windows.bat` | Windows | `.exe` installer |
| `build-macos.sh` | macOS | `.dmg` disk image |
| `build-linux.sh` | Linux | `.deb` package |

---

## Configuration

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `FLUTTER_VERSION` | Flutter SDK version | `3.24.1` |
| `CACHE_KEY` | Dependency cache key | Auto-generated |

### Dart Defines

Add custom build arguments:

```bash
flutter build windows --release \
  --dart-define=API_URL=https://api.example.com \
  --dart-define=ENVIRONMENT=production
```

---

## Troubleshooting

### Common Issues

#### SSH Connection Timeout

```
Error: Connection timeout
```
**Solution:** Check network connectivity and firewall rules

#### SFTP Upload Failed

```
Error: File upload failed
```
**Solution:** Verify remote directory permissions

#### Flutter Doctor Warnings

```bash
# Run diagnostic
flutter doctor -v

# Address any issues shown
```

#### Windows Build Fails

```bash
# Ensure Visual Studio is installed
flutter doctor

# Install missing dependencies
flutter config --enable-windows-desktop
```

### Getting Help

1. **Check existing issues** - [GitHub Issues](https://github.com/code-yeongyu/cloud-toolkit/issues)
2. **Search documentation** - [docs/](docs/)
3. **Ask questions** - Open a new issue with question template

---

## Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) before submitting PRs.

### How to Contribute

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Coding Standards

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `dart format` before committing
- Add tests for new features
- Update documentation as needed

---

## Versioning

This project uses [Semantic Versioning](https://semver.org/):

- **MAJOR** - Incompatible API changes
- **MINOR** - New features (backward compatible)
- **PATCH** - Bug fixes

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

- [Flutter](https://flutter.dev) - UI toolkit
- [dartssh2](https://pub.dev/packages/dartssh2) - SSH library
- [Riverpod](https://riverpod.dev) - State management
- [GitHub Actions](https://github.com/features/actions) - CI/CD
