import 'dart:math';
import 'package:uuid/uuid.dart';
import '../models/models.dart';
import '../services/storage_service.dart';

class ExecutionRepository {
  final _uuid = const Uuid();
  static const int pageSize = 20;

  List<ExecutionRecord> getByTaskId(String taskId) {
    return StorageService.executionsBox.values
        .where((e) => e.taskId == taskId)
        .toList()
      ..sort((a, b) => b.startTime.compareTo(a.startTime));
  }

  List<ExecutionRecord> getByTaskIdPaged(String taskId, {int page = 0}) {
    final all = getByTaskId(taskId);
    final start = page * pageSize;
    final end = start + pageSize;
    if (start >= all.length) return [];
    return all.sublist(start, min(end, all.length));
  }

  int getTotalPages(String taskId) {
    final all = getByTaskId(taskId);
    return (all.length / pageSize).ceil();
  }

  ExecutionRecord? getById(String id) {
    return StorageService.executionsBox.get(id);
  }

  Future<ExecutionRecord> create(String taskId) async {
    final record = ExecutionRecord(
      id: _uuid.v4(),
      taskId: taskId,
      startTime: DateTime.now(),
      status: ExecutionStatus.pending,
    );

    await StorageService.executionsBox.put(record.id, record);
    return record;
  }

  Future<ExecutionRecord> updateStatus(
    String id,
    ExecutionStatus status, {
    String? errorMessage,
  }) async {
    final record = StorageService.executionsBox.get(id);
    if (record == null) {
      throw Exception('执行记录不存在: $id');
    }

    final updated = record.copyWith(
      status: status,
      endTime:
          status == ExecutionStatus.success || status == ExecutionStatus.failed
              ? DateTime.now()
              : null,
      errorMessage: errorMessage,
    );

    await StorageService.executionsBox.put(id, updated);
    return updated;
  }

  Future<ExecutionRecord> appendLog(String id, String log) async {
    final record = StorageService.executionsBox.get(id);
    if (record == null) {
      throw Exception('执行记录不存在: $id');
    }

    final timestamp = DateTime.now().toString().substring(11, 19);
    final updated = record.copyWith(
      logs: [...record.logs, '[$timestamp] $log'],
    );
    await StorageService.executionsBox.put(id, updated);
    return updated;
  }

  Future<void> delete(String id) async {
    await StorageService.executionsBox.delete(id);
  }

  Future<void> deleteByTaskId(String taskId) async {
    final records = getByTaskId(taskId);
    for (final record in records) {
      await StorageService.executionsBox.delete(record.id);
    }
  }
}
