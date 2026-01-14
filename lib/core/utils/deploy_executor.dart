import 'dart:io';
import '../../data/models/models.dart';
import '../../data/services/ssh_service.dart';

typedef LogCallback = void Function(String message);
typedef ProgressCallback = void Function(double progress);

class DeployExecutor {
  final SshService _sshService = SshService();

  Future<void> execute(
    DeployTask task, {
    required LogCallback onLog,
    ProgressCallback? onProgress,
  }) async {
    try {
      onLog('开始部署任务: ${task.name}');
      onProgress?.call(0.0);

      // 1. 连接 SSH
      await _sshService.connect(task.sshConfig, onLog: onLog);
      onProgress?.call(0.1);

      // 2. 验证连接 - 执行一个简单的命令
      onLog('验证 SSH 连接...');
      await _sshService.runCommand('echo "SSH 连接验证成功"', onLog: onLog);

      // 3. 执行上传前脚本
      if (task.preScript != null && task.preScript!.isNotEmpty) {
        onLog('执行上传前脚本...');
        final lines = task.preScript!.split('\n');
        for (final line in lines) {
          if (line.trim().isNotEmpty) {
            await _sshService.runCommand(line.trim(), onLog: onLog);
          }
        }
      }
      onProgress?.call(0.2);

      // 4. 上传文件/目录
      onLog('开始上传文件...');
      final localPath = task.localPath;
      final remotePath = task.remotePath;

      final entity = await FileSystemEntity.type(localPath);
      if (entity == FileSystemEntityType.directory) {
        await _sshService.uploadDirectory(
          localPath,
          remotePath,
          onLog: onLog,
          onFileProgress: (current, total) {
            final progress = 0.2 + (current / total) * 0.6;
            onProgress?.call(progress);
          },
        );
      } else if (entity == FileSystemEntityType.file) {
        final fileName = localPath.split(Platform.pathSeparator).last;
        final remoteFilePath = '$remotePath/$fileName';
        await _sshService.uploadFile(
          localPath,
          remoteFilePath,
          onLog: onLog,
          onProgress: (sent, total) {
            final progress = 0.2 + (sent / total) * 0.6;
            onProgress?.call(progress);
          },
        );
      } else {
        throw SshSessionException('本地路径不存在: $localPath', '检查路径');
      }
      onProgress?.call(0.8);

      // 5. 执行上传后脚本
      if (task.postScript != null && task.postScript!.isNotEmpty) {
        onLog('执行上传后脚本...');
        final lines = task.postScript!.split('\n');
        for (final line in lines) {
          if (line.trim().isNotEmpty) {
            await _sshService.runCommand(line.trim(), onLog: onLog);
          }
        }
      }
      onProgress?.call(0.95);

      // 6. 断开连接
      await _sshService.disconnect();
      onProgress?.call(1.0);
      onLog('✓ 部署完成');
    } on SshConnectionException catch (e) {
      await _sshService.disconnect();
      onLog('✗ 连接失败: ${e.message}');
      rethrow;
    } on SshAuthenticationException catch (e) {
      await _sshService.disconnect();
      onLog('✗ 认证失败: ${e.message}');
      rethrow;
    } on SshSessionException catch (e) {
      await _sshService.disconnect();
      onLog('✗ ${e.message}');
      rethrow;
    } catch (e) {
      await _sshService.disconnect();
      onLog('✗ 部署失败: $e');
      rethrow;
    }
  }
}
