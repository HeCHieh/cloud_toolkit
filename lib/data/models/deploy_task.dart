import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'ssh_config.dart';

part 'deploy_task.freezed.dart';
part 'deploy_task.g.dart';

@freezed
@HiveType(typeId: 1)
class DeployTask with _$DeployTask {
  const factory DeployTask({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required SshConfig sshConfig,
    @HiveField(3) required String localPath,
    @HiveField(4) required String remotePath,
    @HiveField(5) String? preScript,
    @HiveField(6) String? postScript,
    @HiveField(7) required DateTime createdAt,
    @HiveField(8) DateTime? updatedAt,
  }) = _DeployTask;

  factory DeployTask.fromJson(Map<String, dynamic> json) =>
      _$DeployTaskFromJson(json);
}
