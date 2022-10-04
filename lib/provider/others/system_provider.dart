import 'package:terminal/controller/system_controller.dart';

/// Provider负责指令执行和更新系统状态（Controller）
/// 可根据自居需求实现provider
/// 系统Provider，只负责加载和保存系统属性
class SystemProvider {
  static Future load() async {
    await SystemController.loadSystemInfo();
  }

  static void save() async {
    SystemController.saveLoadInfo();
  }
}
