# Cloud Toolkit

<div align="center">

**用于上传和部署应用到远程服务器的 SSH 部署工具**

[![Flutter](https://img.shields.io/badge/Flutter-3.24.1-42a5f5.svg?logo=flutter)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![GitHub Actions](https://img.shields.io/badge/GitHub-Actions-2088ff.svg?logo=github-actions)](https://github.com/features/actions)

*[English](README.md) | 中文*

</div>

---

## 功能特性

- **SSH/SFTP 连接** - 安全连接远程服务器
- **文件上传** - 通过 SFTP 上传文件和目录
- **远程执行** - 在远程服务器上执行命令
- **跨平台支持** - Windows、macOS、Linux
- **部署脚本** - 上传前后脚本执行
- **进度跟踪** - 实时上传进度监控

---

## 快速开始

### 下载预构建安装包

预构建安装包可在 [发布页面](https://github.com/code-yeongyu/cloud-toolkit/releases) 下载：

| 平台 | 格式 | 安装方式 |
|------|------|----------|
| Windows | `.exe` 安装程序 | 双击运行安装向导 |
| macOS | `.dmg` 磁盘映像 | 挂载后拖动到应用程序文件夹 |
| Linux | `.deb` 软件包 | `sudo apt install ./cloud-toolkit_*.deb` |

### 从源码构建

#### 环境要求

| 要求 | 版本 | 备注 |
|------|------|------|
| Flutter | 3.24.1+ | 必需 |
| Dart | 3.5.1+ | 随 Flutter 附带 |
| Git | 2.0+ | 版本控制 |
| Visual Studio | 2022+ | 仅 Windows，桌面支持必需 |

#### 环境搭建

```bash
# 克隆仓库
git clone https://github.com/code-yeongyu/cloud-toolkit.git
cd cloud-toolkit

# 安装依赖
flutter pub get

# 生成必需代码
flutter pub run build_runner build --delete-conflicting-outputs
```

#### 本地运行

```bash
# Linux
flutter run -d linux

# Windows
flutter run -d windows

# macOS
flutter run -d macos
```

#### 构建发布版本

```bash
# Linux
flutter build linux --release
# 输出目录: build/linux/x64/release/bundle/

# Windows
flutter build windows --release
# 输出目录: build/windows/runner/Release/

# macOS
flutter build macos --release
# 输出目录: build/macos/Build/Products/Release/
```

---

## 使用指南

### 连接服务器

1. 启动 Cloud Toolkit
2. 点击 **添加服务器** 或 **新建连接**
3. 输入服务器信息：

| 字段 | 描述 | 必需 |
|------|------|------|
| 主机 | 服务器 IP 地址或主机名 | 是 |
| 端口 | SSH 端口（默认: 22） | 否 |
| 用户名 | SSH 用户名 | 是 |
| 认证方式 | 密码或私钥 | 是 |
| 密码/私钥 | 认证凭据 | 是 |

4. 点击 **连接**

### 上传文件

1. 连接成功后，切换到 **上传** 选项卡
2. 选择本地文件或目录
3. 设置远程目标路径
4. （可选）添加上传前命令
5. （可选）添加上传后命令
6. 点击 **上传**

#### 上传前/后脚本示例

```bash
# 上传前：停止现有服务
systemctl stop myapp

# 上传后：重启服务
systemctl restart myapp
```

### 部署任务

创建可复用的部署配置：

```yaml
name: 生产环境部署
localPath: /path/to/dist
remotePath: /opt/myapp
preScript: |
  echo "停止服务..."
  sudo systemctl stop myapp
postScript: |
  echo "重启服务..."
  sudo systemctl restart myapp
```

---

## 项目结构

```
cloud-toolkit/
├── lib/
│   ├── main.dart              # 应用入口
│   ├── core/
│   │   ├── theme/             # 应用主题
│   │   └── utils/             # 工具类
│   ├── data/
│   │   ├── models/            # 数据模型
│   │   ├── repositories/      # 数据仓库
│   │   └── services/          # 业务服务
│   └── providers/             # 状态管理
├── linux/                     # Linux 特定代码
├── macos/                     # macOS 特定代码
├── windows/                   # Windows 特定代码
├── docs/                      # 文档
├── test/                      # 单元测试
└── pubspec.yaml               # 依赖配置
```

### 核心组件

| 组件 | 位置 | 用途 |
|------|------|------|
| `SshService` | `lib/data/services/ssh_service.dart` | SSH/SFTP 操作 |
| `DeployExecutor` | `lib/core/utils/deploy_executor.dart` | 部署编排 |
| `DeployTask` | `lib/data/models/deploy_task.dart` | 部署配置 |
| `SshConfig` | `lib/data/models/ssh_config.dart` | SSH 连接配置 |

---

## 开发指南

### 开发环境搭建

#### Windows

```bash
# 启用 Windows 桌面支持
flutter config --enable-windows-desktop

# 安装 Visual Studio 依赖
# 确保已安装 "Desktop development with C++" 工作负载
```

#### macOS

```bash
# 启用 macOS 桌面支持
flutter config --enable-macos-desktop

# 从 App Store 安装 Xcode
# 运行: sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

#### Linux

```bash
# 启用 Linux 桌面支持
flutter config --enable-linux-desktop

# 安装依赖
sudo apt-get update
sudo apt-get install -y clang cmake ninja-build pkg-config \
  libgtk-3-dev liblzma-dev
```

### 运行测试

```bash
# 运行所有测试
flutter test

# 运行并生成覆盖率报告
flutter test --coverage

# 生成 HTML 覆盖率报告
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### 代码生成

本项目使用代码生成处理数据模型：

```bash
# 生成模型序列化器
flutter pub run build_runner build --delete-conflicting-outputs

# 监听变化自动生成
flutter pub run build_runner watch
```

### 添加新功能

1. **创建功能分支**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **遵循项目规范进行修改**
   - 模型: `lib/data/models/`
   - 服务: `lib/data/services/`
   - 界面: `lib/ui/` 或现有页面

3. **提交前运行检查**
   ```bash
   dart format --set-exit-if-changed lib/
   flutter analyze lib/
   flutter test
   ```

4. **提交 Pull Request**

---

## CI/CD 流水线

### GitHub Actions 工作流

项目使用 GitHub Actions 进行自动化构建：

**触发条件：**
- 推送到 `main` 分支
- 新标签匹配 `v*` (例如 `v1.0.0`)
- 手动触发工作流

**构建流程：**
1. 代码分析和测试
2. 平台特定构建 (Windows、macOS、Linux)
3. 创建安装包 (安装程序、DMG、DEB)
4. 创建 GitHub Release

**配置位置:** [`.github/workflows/build-all-platforms.yml`](.github/workflows/build-all-platforms.yml)

### 本地构建脚本

| 脚本 | 平台 | 输出 |
|------|------|------|
| `build-windows.bat` | Windows | `.exe` 安装程序 |
| `build-macos.sh` | macOS | `.dmg` 磁盘映像 |
| `build-linux.sh` | Linux | `.deb` 软件包 |

---

## 配置说明

### 环境变量

| 变量 | 描述 | 默认值 |
|------|------|--------|
| `FLUTTER_VERSION` | Flutter SDK 版本 | `3.24.1` |
| `CACHE_KEY` | 依赖缓存键 | 自动生成 |

### Dart 定义

添加自定义构建参数：

```bash
flutter build windows --release \
  --dart-define=API_URL=https://api.example.com \
  --dart-define=ENVIRONMENT=production
```

---

## 常见问题

### SSH 连接超时

```
错误: 连接超时
```
**解决方案:** 检查网络连接和防火墙规则

### SFTP 上传失败

```
错误: 文件上传失败
```
**解决方案:** 验证远程目录权限

### Flutter Doctor 警告

```bash
# 运行诊断
flutter doctor -v

# 按提示解决所有问题
```

### Windows 构建失败

```bash
# 确保 Visual Studio 已安装
flutter doctor

# 安装缺失的依赖
flutter config --enable-windows-desktop
```

### 获取帮助

1. **查看现有问题** - [GitHub Issues](https://github.com/code-yeongyu/cloud-toolkit/issues)
2. **搜索文档** - [docs/](docs/)
3. **提问** - 使用问题模板新建 Issue

---

## 贡献指南

欢迎贡献！提交 PR 前请阅读[贡献指南](CONTRIBUTING.md)。

### 贡献方式

1. Fork 本仓库
2. 创建功能分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m 'Add amazing feature'`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 打开 Pull Request

### 代码规范

- 遵循 [Effective Dart](https://dart.dev/guides/language/effective-dart) 指南
- 提交前使用 `dart format` 格式化
- 为新功能添加测试
- 必要时更新文档

---

## 版本管理

本项目使用[语义化版本](https://semver.org/)：

- **主版本** - 不兼容的 API 变更
- **次版本** - 新功能（向后兼容）
- **补丁版本** - Bug 修复

---

## 开源许可

本项目基于 MIT 许可证开源 - 详见 [LICENSE](LICENSE) 文件。

---

## 致谢

- [Flutter](https://flutter.dev) - UI 工具包
- [dartssh2](https://pub.dev/packages/dartssh2) - SSH 库
- [Riverpod](https://riverpod.dev) - 状态管理
- [GitHub Actions](https://github.com/features/actions) - CI/CD
