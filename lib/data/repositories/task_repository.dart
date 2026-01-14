import 'package:uuid/uuid.dart';
import '../models/models.dart';
import '../services/storage_service.dart';

class TaskRepository {
  final _uuid = const Uuid();

  List<DeployTask> getAll() {
    return StorageService.tasksBox.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  DeployTask? getById(String id) {
    return StorageService.tasksBox.get(id);
  }

  Future<DeployTask> create({
    required String name,
    required SshConfig sshConfig,
    required String localPath,
    required String remotePath,
    String? preScript,
    String? postScript,
  }) async {
    final task = DeployTask(
      id: _uuid.v4(),
      name: name,
      sshConfig: sshConfig,
      localPath: localPath,
      remotePath: remotePath,
      preScript: preScript,
      postScript: postScript,
      createdAt: DateTime.now(),
    );

    await StorageService.tasksBox.put(task.id, task);
    return task;
  }

  Future<DeployTask> update(DeployTask task) async {
    final updated = task.copyWith(updatedAt: DateTime.now());
    await StorageService.tasksBox.put(updated.id, updated);
    return updated;
  }

  Future<void> delete(String id) async {
    await StorageService.tasksBox.delete(id);
  }
}
