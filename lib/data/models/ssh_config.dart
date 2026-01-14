import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'ssh_config.freezed.dart';
part 'ssh_config.g.dart';

@freezed
@HiveType(typeId: 0)
class SshConfig with _$SshConfig {
  const factory SshConfig({
    @HiveField(0) required String host,
    @HiveField(1) @Default(22) int port,
    @HiveField(2) required String username,
    @HiveField(3) String? password,
    @HiveField(4) String? privateKeyPath,
    @HiveField(5) String? passphrase,
  }) = _SshConfig;

  factory SshConfig.fromJson(Map<String, dynamic> json) =>
      _$SshConfigFromJson(json);
}
