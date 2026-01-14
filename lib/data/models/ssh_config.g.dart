// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ssh_config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SshConfigAdapter extends TypeAdapter<SshConfig> {
  @override
  final int typeId = 0;

  @override
  SshConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SshConfig(
      host: fields[0] as String,
      port: fields[1] as int,
      username: fields[2] as String,
      password: fields[3] as String?,
      privateKeyPath: fields[4] as String?,
      passphrase: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SshConfig obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.host)
      ..writeByte(1)
      ..write(obj.port)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.privateKeyPath)
      ..writeByte(5)
      ..write(obj.passphrase);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SshConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SshConfigImpl _$$SshConfigImplFromJson(Map<String, dynamic> json) =>
    _$SshConfigImpl(
      host: json['host'] as String,
      port: (json['port'] as num?)?.toInt() ?? 22,
      username: json['username'] as String,
      password: json['password'] as String?,
      privateKeyPath: json['privateKeyPath'] as String?,
      passphrase: json['passphrase'] as String?,
    );

Map<String, dynamic> _$$SshConfigImplToJson(_$SshConfigImpl instance) =>
    <String, dynamic>{
      'host': instance.host,
      'port': instance.port,
      'username': instance.username,
      'password': instance.password,
      'privateKeyPath': instance.privateKeyPath,
      'passphrase': instance.passphrase,
    };
