import 'package:provider/provider.dart';
import 'package:terminal/controller/user_controller.dart';
import 'package:terminal/main.dart';

class UserProvider {
  // 初始化用户状态
  static void load() {
    UserController userController = Provider.of<UserController>(
      navigatorKey.currentState!.overlay!.context,
      listen: false,
    );
    userController.load();
  }

  // 新增tab
  static void add(String key, String value) {
    UserController userController = Provider.of<UserController>(
      navigatorKey.currentState!.overlay!.context,
      listen: false,
    );
    userController.tabs[key] = value;
    userController.save();
  }

  // 删除tab
  static void remove(String key) {
    UserController userController = Provider.of<UserController>(
      navigatorKey.currentState!.overlay!.context,
      listen: false,
    );
    userController.tabs.remove(key);
    userController.save();
  }

  // 获取tab
  static String? get(String key) {
    UserController userController = Provider.of<UserController>(
      navigatorKey.currentState!.overlay!.context,
      listen: false,
    );
    return userController.tabs[key];
  }

  // 获取所有的tab
  static Map<String, String> getAll() {
    UserController userController = Provider.of<UserController>(
      navigatorKey.currentState!.overlay!.context,
      listen: false,
    );
    return userController.tabs;
  }

  // 重命名tab
  static void rename(String oldName, String newName) {
    UserController userController = Provider.of<UserController>(
      navigatorKey.currentState!.overlay!.context,
      listen: false,
    );
    userController.tabs[newName] = userController.tabs[oldName]!;
    userController.tabs.remove(oldName);
    userController.save();
  }
}
