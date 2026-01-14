import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dartssh2/dartssh2.dart';
import '../models/models.dart';

typedef LogCallback = void Function(String message);

class SshService {
  SSHClient? _client;
  SftpClient? _sftp;

  Future<void> connect(SshConfig config, {LogCallback? onLog}) async {
    onLog?.call('正在连接到 ${config.host}:${config.port}...');

    try {
      // 1. 建立 TCP 连接
      final socket = await SSHSocket.connect(
        config.host,
        config.port,
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw SshConnectionException(
            '连接超时，请检查网络或主机地址是否正确',
            config.host,
            config.port,
          );
        },
      );

      // 2. 创建 SSH 客户端
      late final SSHClient client;

      if (config.privateKeyPath != null && config.privateKeyPath!.isNotEmpty) {
        final keyFile = File(config.privateKeyPath!);
        if (!await keyFile.exists()) {
          throw SshConnectionException(
            '私钥文件不存在: ${config.privateKeyPath}',
            config.host,
            config.port,
          );
        }

        final keyContent = await keyFile.readAsString();
        onLog?.call('正在使用私钥认证...');

        final keyPairs = SSHKeyPair.fromPem(keyContent, config.passphrase);

        client = SSHClient(
          socket,
          username: config.username,
          identities: keyPairs,
        );
      } else if (config.password != null && config.password!.isNotEmpty) {
        onLog?.call('正在使用密码认证...');
        client = SSHClient(
          socket,
          username: config.username,
          onPasswordRequest: () => config.password!,
        );
      } else {
        throw SshConnectionException(
          '未配置认证方式（密码或私钥）',
          config.host,
          config.port,
        );
      }

      // 3. 等待认证完成
      onLog?.call('正在验证认证信息...');

      try {
        await client.authenticated.timeout(
          const Duration(seconds: 30),
          onTimeout: () {
            throw SshAuthenticationException(
              '认证超时，请检查用户名、密码或私钥是否正确',
              config.host,
              config.port,
              config.username,
            );
          },
        );
      } on SshAuthenticationException {
        rethrow;
      } catch (e) {
        throw SshAuthenticationException(
          '认证失败: $e',
          config.host,
          config.port,
          config.username,
        );
      }

      _client = client;
      onLog?.call('✓ 认证成功，已建立 SSH 连接');
    } on SshConnectionException catch (e) {
      onLog?.call('✗ 连接失败: ${e.message}');
      rethrow;
    } on SshAuthenticationException catch (e) {
      onLog?.call('✗ 认证失败: ${e.message}');
      rethrow;
    } catch (e) {
      onLog?.call('✗ 连接失败: $e');
      throw SshConnectionException(
        '连接异常: $e',
        config.host,
        config.port,
      );
    }
  }

  Future<String> runCommand(String command, {LogCallback? onLog}) async {
    if (_client == null) {
      throw SshSessionException('SSH 会话未建立，请重新连接', command);
    }

    onLog?.call('> $command');

    try {
      final result = await _client!.run(command).timeout(
        const Duration(minutes: 5),
        onTimeout: () {
          throw SshSessionException('命令执行超时 (5分钟)', command);
        },
      );
      final output = utf8.decode(result);
      if (output.isNotEmpty) {
        onLog?.call(output.trim());
      }
      return output;
    } on SshSessionException {
      rethrow;
    } catch (e) {
      onLog?.call('✗ 命令执行失败: $e');
      throw SshSessionException('命令执行异常: $e', command);
    }
  }

  Future<void> uploadFile(
    String localPath,
    String remotePath, {
    LogCallback? onLog,
    void Function(int sent, int total)? onProgress,
  }) async {
    if (_client == null) {
      throw SshSessionException('SSH 会话未建立，请重新连接', 'SFTP 上传');
    }

    final localFile = File(localPath);
    if (!await localFile.exists()) {
      throw SshSessionException('本地文件不存在: $localPath', 'SFTP 上传');
    }

    final fileSize = await localFile.length();
    final fileName = localPath.split(Platform.pathSeparator).last;
    onLog?.call('上传: $fileName (${_formatFileSize(fileSize)})');

    try {
      _sftp ??= await _client!.sftp();

      final remoteFile = await _sftp!.open(
        remotePath,
        mode: SftpFileOpenMode.create |
            SftpFileOpenMode.write |
            SftpFileOpenMode.truncate,
      );

      final writer = remoteFile.write(
        localFile.openRead().map((chunk) => Uint8List.fromList(chunk)),
        onProgress: (sent) => onProgress?.call(sent, fileSize),
      );
      await writer.done;
      onLog?.call('✓ $fileName 上传完成');
    } catch (e) {
      if (e is SshSessionException) rethrow;
      throw SshSessionException('文件上传失败: $e', 'SFTP 上传: $remotePath');
    }
  }

  Future<void> uploadDirectory(
    String localPath,
    String remotePath, {
    LogCallback? onLog,
    void Function(int current, int total)? onFileProgress,
  }) async {
    if (_client == null) {
      throw SshSessionException('SSH 会话未建立，请重新连接', 'SFTP 目录上传');
    }

    final localDir = Directory(localPath);
    if (!await localDir.exists()) {
      throw SshSessionException('本地目录不存在: $localPath', 'SFTP 目录上传');
    }

    _sftp ??= await _client!.sftp();

    final files = await _listFiles(localDir);
    onLog?.call('开始上传 ${files.length} 个文件...');

    int current = 0;
    for (final file in files) {
      final relativePath = file.path.substring(localDir.path.length);
      final remoteFilePath = '$remotePath$relativePath'.replaceAll('\\', '/');
      final remoteDir =
          remoteFilePath.substring(0, remoteFilePath.lastIndexOf('/'));

      await _ensureRemoteDirectory(remoteDir);

      await uploadFile(file.path, remoteFilePath, onLog: onLog);
      current++;
      onFileProgress?.call(current, files.length);
    }

    onLog?.call('上传完成 (共 ${files.length} 文件)');
  }

  Future<void> _ensureRemoteDirectory(String path) async {
    if (_sftp == null) return;

    try {
      await _sftp!.stat(path);
    } catch (_) {
      final parts = path.split('/').where((p) => p.isNotEmpty).toList();
      String currentPath = '';
      for (final part in parts) {
        currentPath += '/$part';
        try {
          await _sftp!.stat(currentPath);
        } catch (_) {
          await _sftp!.mkdir(currentPath);
        }
      }
    }
  }

  Future<List<File>> _listFiles(Directory dir) async {
    final files = <File>[];
    await for (final entity in dir.list(recursive: true)) {
      if (entity is File) {
        files.add(entity);
      }
    }
    return files;
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
  }

  Future<void> disconnect() async {
    _sftp = null;
    _client?.close();
    _client = null;
  }
}

/// SSH 连接异常
class SshConnectionException implements Exception {
  final String message;
  final String host;
  final int port;

  SshConnectionException(this.message, this.host, this.port);

  @override
  String toString() => '连接失败 [$host:$port]: $message';
}

/// SSH 认证异常
class SshAuthenticationException implements Exception {
  final String message;
  final String host;
  final int port;
  final String username;

  SshAuthenticationException(this.message, this.host, this.port, this.username);

  @override
  String toString() => '认证失败 [$username@$host:$port]: $message';
}

/// SSH 会话异常
class SshSessionException implements Exception {
  final String message;
  final String context;

  SshSessionException(this.message, this.context);

  @override
  String toString() => '会话错误 ($context): $message';
}
