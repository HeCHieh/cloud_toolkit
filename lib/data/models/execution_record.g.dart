// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'execution_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExecutionRecordAdapter extends TypeAdapter<ExecutionRecord> {
  @override
  final int typeId = 2;

  @override
  ExecutionRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExecutionRecord(
      id: fields[0] as String,
      taskId: fields[1] as String,
      startTime: fields[2] as DateTime,
      endTime: fields[3] as DateTime?,
      status: fields[4] as ExecutionStatus,
      logs: (fields[5] as List).cast<String>(),
      errorMessage: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ExecutionRecord obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.taskId)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.endTime)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.logs)
      ..writeByte(6)
      ..write(obj.errorMessage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExecutionRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExecutionStatusAdapter extends TypeAdapter<ExecutionStatus> {
  @override
  final int typeId = 3;

  @override
  ExecutionStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ExecutionStatus.pending;
      case 1:
        return ExecutionStatus.running;
      case 2:
        return ExecutionStatus.success;
      case 3:
        return ExecutionStatus.failed;
      default:
        return ExecutionStatus.pending;
    }
  }

  @override
  void write(BinaryWriter writer, ExecutionStatus obj) {
    switch (obj) {
      case ExecutionStatus.pending:
        writer.writeByte(0);
        break;
      case ExecutionStatus.running:
        writer.writeByte(1);
        break;
      case ExecutionStatus.success:
        writer.writeByte(2);
        break;
      case ExecutionStatus.failed:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExecutionStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExecutionRecordImpl _$$ExecutionRecordImplFromJson(
        Map<String, dynamic> json) =>
    _$ExecutionRecordImpl(
      id: json['id'] as String,
      taskId: json['taskId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      status: $enumDecode(_$ExecutionStatusEnumMap, json['status']),
      logs:
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$$ExecutionRecordImplToJson(
        _$ExecutionRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'taskId': instance.taskId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'status': _$ExecutionStatusEnumMap[instance.status]!,
      'logs': instance.logs,
      'errorMessage': instance.errorMessage,
    };

const _$ExecutionStatusEnumMap = {
  ExecutionStatus.pending: 'pending',
  ExecutionStatus.running: 'running',
  ExecutionStatus.success: 'success',
  ExecutionStatus.failed: 'failed',
};
