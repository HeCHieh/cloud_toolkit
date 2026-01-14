import 'package:local_notifier/local_notifier.dart';

class NotificationService {
  static Future<void> initialize() async {
    await localNotifier.setup(
      appName: 'Cloud Toolkit',
      shortcutPolicy: ShortcutPolicy.requireCreate,
    );
  }

  static Future<void> showDeploymentSuccess(String taskName) async {
    final notification = LocalNotification(
      title: '部署成功',
      body: '任务「$taskName」已完成部署',
    );
    await notification.show();
  }

  static Future<void> showDeploymentFailure(
      String taskName, String error) async {
    final notification = LocalNotification(
      title: '部署失败',
      body: '任务「$taskName」部署失败: $error',
    );
    await notification.show();
  }
}
