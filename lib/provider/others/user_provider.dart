import 'package:provider/provider.dart';
import 'package:terminal/controller/user_controller.dart';
import 'package:terminal/main.dart';
import 'package:terminal/provider/others/note_provider.dart';
import 'package:terminal/provider/others/tabs_provider.dart';

class UserProvider {
  static UserController? userController;
  static TabsProvider? tabsProvider;
  static NoteProvider? noteProvider;

  // 初始化用户状态
  static void load() {
    userController = Provider.of<UserController>(
      navigatorKey.currentState!.overlay!.context,
      listen: false,
    );
    userController!.load();
    tabsProvider = TabsProvider();
    noteProvider = NoteProvider();
  }
}
