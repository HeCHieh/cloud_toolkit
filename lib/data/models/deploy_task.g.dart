// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deploy_task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeployTaskAdapter extends TypeAdapter<DeployTask> {
  @override
  final int typeId = 1;

  @override
  DeployTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeployTask(
      id: fields[0] as String,
      name: fields[1] as String,
      sshConfig: fields[2] as SshConfig,
      localPath: fields[3] as String,
      remotePath: fields[4] as String,
      preScript: fields[5] as String?,
      postScript: fields[6] as String?,
      createdAt: fields[7] as DateTime,
      updatedAt: fields[8] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, DeployTask obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.sshConfig)
      ..writeByte(3)
      ..write(obj.localPath)
      ..writeByte(4)
      ..write(obj.remotePath)
      ..writeByte(5)
      ..write(obj.preScript)
      ..writeByte(6)
      ..write(obj.postScript)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeployTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeployTaskImpl _$$DeployTaskImplFromJson(Map<String, dynamic> json) =>
    _$DeployTaskImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      sshConfig: SshConfig.fromJson(json['sshConfig'] as Map<String, dynamic>),
      localPath: json['localPath'] as String,
      remotePath: json['remotePath'] as String,
      preScript: json['preScript'] as String?,
      postScript: json['postScript'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$DeployTaskImplToJson(_$DeployTaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sshConfig': instance.sshConfig,
      'localPath': instance.localPath,
      'remotePath': instance.remotePath,
      'preScript': instance.preScript,
      'postScript': instance.postScript,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
