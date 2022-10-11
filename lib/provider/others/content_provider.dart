// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:provider/provider.dart';
import 'package:terminal/controller/content_controller.dart';
import 'package:terminal/main.dart';

/// 消息状态更新provider
class ContentProvider {
  static ContentController? _contentController;

  static void init() {
    _contentController = Provider.of<ContentController>(
      navigatorKey.currentState!.overlay!.context,
      listen: false,
    );
  }

  // 清除消息列表
  static void clear() {
    _contentController!.message.value.clear();
  }

  // 添加单个消息
  static void add(String msg) {
    _contentController!.message.value.add(msg);
    _contentController!.message.notifyListeners();
  }

  // 添加多个消息
  static void addAll(List<String> msgs) {
    _contentController!.message.value.addAll(msgs);
    _contentController!.message.notifyListeners();
  }

  static String getTextInput() {
    return _contentController!.editingController.text;
  }

  static void clearText() {
    _contentController!.editingController.clear();
  }

  static void clearHintText() {
    _contentController!.hintMessage.value = "";
  }
}
