import 'package:terminal/provider/others/user_provider.dart';

class TabsProvider {
  // 新增tab
  void add(String key, String value) {
    UserProvider.userController!.tabs[key] = value;
    UserProvider.userController!.save();
  }

  // 删除tab
  void remove(String key) {
    UserProvider.userController!.tabs.remove(key);
    UserProvider.userController!.save();
  }

  // 获取tab
  String? get(String key) {
    return UserProvider.userController!.tabs[key];
  }

  // 获取所有的tab
  Map<String, String> getAll() {
    return UserProvider.userController!.tabs;
  }

  // 重命名tab
  void rename(String oldName, String newName) {
    UserProvider.userController!.tabs[newName] =
        UserProvider.userController!.tabs[oldName]!;
    UserProvider.userController!.tabs.remove(oldName);
    UserProvider.userController!.save();
  }
}
