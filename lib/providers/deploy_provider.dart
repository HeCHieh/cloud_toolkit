import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/models.dart';
import '../data/repositories/repositories.dart';
import '../data/services/services.dart';
import '../core/utils/deploy_executor.dart';
import 'execution_provider.dart';

class DeployState {
  final Map<String, ExecutionStatus> taskStatuses;
  final Map<String, double> taskProgress;
  final Map<String, String?> currentExecutionIds;

  const DeployState({
    this.taskStatuses = const {},
    this.taskProgress = const {},
    this.currentExecutionIds = const {},
  });

  DeployState copyWith({
    Map<String, ExecutionStatus>? taskStatuses,
    Map<String, double>? taskProgress,
    Map<String, String?>? currentExecutionIds,
  }) {
    return DeployState(
      taskStatuses: taskStatuses ?? this.taskStatuses,
      taskProgress: taskProgress ?? this.taskProgress,
      currentExecutionIds: currentExecutionIds ?? this.currentExecutionIds,
    );
  }

  ExecutionStatus getStatus(String taskId) {
    return taskStatuses[taskId] ?? ExecutionStatus.pending;
  }

  double getProgress(String taskId) {
    return taskProgress[taskId] ?? 0.0;
  }

  bool isRunning(String taskId) {
    return taskStatuses[taskId] == ExecutionStatus.running;
  }
}

class DeployNotifier extends StateNotifier<DeployState> {
  final ExecutionRepository _executionRepository;
  final DeployExecutor _executor = DeployExecutor();
  final Ref _ref;

  DeployNotifier(this._executionRepository, this._ref)
      : super(const DeployState());

  Future<void> deploy(DeployTask task) async {
    // Clear any previous execution state to allow re-deployment
    state = const DeployState();

    state = state.copyWith(
      taskStatuses: {...state.taskStatuses, task.id: ExecutionStatus.running},
      taskProgress: {...state.taskProgress, task.id: 0.0},
    );

    final record = await _executionRepository.create(task.id);
    await _executionRepository.updateStatus(record.id, ExecutionStatus.running);

    state = state.copyWith(
      currentExecutionIds: {...state.currentExecutionIds, task.id: record.id},
    );

    try {
      await _executor.execute(
        task,
        onLog: (message) async {
          await _executionRepository.appendLog(record.id, message);
        },
        onProgress: (progress) {
          state = state.copyWith(
            taskProgress: {...state.taskProgress, task.id: progress},
          );
        },
      );

      await _executionRepository.updateStatus(
          record.id, ExecutionStatus.success);

      // Reset state to allow re-deployment
      state = state.copyWith(
        taskStatuses: {...state.taskStatuses, task.id: ExecutionStatus.pending},
        taskProgress: {...state.taskProgress, task.id: 0.0},
        currentExecutionIds: {...state.currentExecutionIds, task.id: null},
      );

      // Refresh execution detail and list
      _ref.read(executionRefreshProvider(record.id).notifier).state++;
      _ref.read(executionsProvider(task.id).notifier).refresh();

      await NotificationService.showDeploymentSuccess(task.name);
    } catch (e) {
      await _executionRepository.updateStatus(
        record.id,
        ExecutionStatus.failed,
        errorMessage: e.toString(),
      );

      // Reset state to allow re-deployment
      state = state.copyWith(
        taskStatuses: {...state.taskStatuses, task.id: ExecutionStatus.pending},
        taskProgress: {...state.taskProgress, task.id: 0.0},
        currentExecutionIds: {...state.currentExecutionIds, task.id: null},
      );

      // Refresh execution detail and list
      _ref.read(executionRefreshProvider(record.id).notifier).state++;
      _ref.read(executionsProvider(task.id).notifier).refresh();

      await NotificationService.showDeploymentFailure(task.name, e.toString());
    }
  }
}

final deployProvider =
    StateNotifierProvider<DeployNotifier, DeployState>((ref) {
  final executionRepository = ref.watch(executionRepositoryProvider);
  return DeployNotifier(executionRepository, ref);
});
