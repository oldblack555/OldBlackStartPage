import 'package:provider/provider.dart';
import 'package:terminal/controller/content_controller.dart';
import 'package:terminal/main.dart';

/// 消息状态更新provider
class ContentProvider {
  static void clear() {
    ContentController contentController = Provider.of<ContentController>(
      navigatorKey.currentState!.overlay!.context,
      listen: false,
    );
    contentController.message.clear();
  }
}
