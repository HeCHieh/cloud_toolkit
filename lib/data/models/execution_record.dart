import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'execution_record.freezed.dart';
part 'execution_record.g.dart';

@HiveType(typeId: 3)
enum ExecutionStatus {
  @HiveField(0)
  pending,
  @HiveField(1)
  running,
  @HiveField(2)
  success,
  @HiveField(3)
  failed,
}

@freezed
@HiveType(typeId: 2)
class ExecutionRecord with _$ExecutionRecord {
  const ExecutionRecord._();

  const factory ExecutionRecord({
    @HiveField(0) required String id,
    @HiveField(1) required String taskId,
    @HiveField(2) required DateTime startTime,
    @HiveField(3) DateTime? endTime,
    @HiveField(4) required ExecutionStatus status,
    @HiveField(5) @Default(<String>[]) List<String> logs,
    @HiveField(6) String? errorMessage,
  }) = _ExecutionRecord;

  Duration? get duration => endTime?.difference(startTime);

  factory ExecutionRecord.fromJson(Map<String, dynamic> json) =>
      _$ExecutionRecordFromJson(json);
}
