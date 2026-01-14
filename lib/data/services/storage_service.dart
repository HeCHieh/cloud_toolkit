import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../models/models.dart';

class StorageService {
  static const String tasksBoxName = 'tasks';
  static const String executionsBoxName = 'executions';

  static Future<void> initialize() async {
    final appDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter('${appDir.path}/cloud_toolkit');

    Hive.registerAdapter(SshConfigAdapter());
    Hive.registerAdapter(DeployTaskAdapter());
    Hive.registerAdapter(ExecutionRecordAdapter());
    Hive.registerAdapter(ExecutionStatusAdapter());

    await Hive.openBox<DeployTask>(tasksBoxName);
    await Hive.openBox<ExecutionRecord>(executionsBoxName);
  }

  static Box<DeployTask> get tasksBox => Hive.box<DeployTask>(tasksBoxName);
  static Box<ExecutionRecord> get executionsBox =>
      Hive.box<ExecutionRecord>(executionsBoxName);
}
