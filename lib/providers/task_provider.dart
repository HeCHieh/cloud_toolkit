import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/models.dart';
import '../data/repositories/repositories.dart';

final taskRepositoryProvider = Provider((ref) => TaskRepository());

final tasksProvider =
    StateNotifierProvider<TasksNotifier, List<DeployTask>>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TasksNotifier(repository);
});

class TasksNotifier extends StateNotifier<List<DeployTask>> {
  final TaskRepository _repository;

  TasksNotifier(this._repository) : super([]) {
    _load();
  }

  void _load() {
    state = _repository.getAll();
  }

  Future<DeployTask> create({
    required String name,
    required SshConfig sshConfig,
    required String localPath,
    required String remotePath,
    String? preScript,
    String? postScript,
  }) async {
    final task = await _repository.create(
      name: name,
      sshConfig: sshConfig,
      localPath: localPath,
      remotePath: remotePath,
      preScript: preScript,
      postScript: postScript,
    );
    _load();
    return task;
  }

  Future<void> update(DeployTask task) async {
    await _repository.update(task);
    _load();
  }

  Future<void> delete(String id) async {
    await _repository.delete(id);
    _load();
  }
}
