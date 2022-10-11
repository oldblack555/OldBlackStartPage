import 'package:flutter/material.dart';

/// 消息列表状态，全局共享
/// 负责临时存储消息以及更新通知
/// 输入控制器、消息列表、提示消息组成
class ContentController extends ChangeNotifier {
  final TextEditingController editingController = TextEditingController();

  final ValueNotifier<List<String>> message = ValueNotifier([]);
  ValueNotifier<String> hintMessage = ValueNotifier("");
}
