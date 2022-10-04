import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 用户状态，全局共享
/// 负责管理用户的信息，如标签页等
/// 后期实现用户登录，保存用户信息等等
/// 实现持久化保存
class UserController extends ChangeNotifier {
  Map<String, String> tabs = {};

  void load() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String tabsInfo = preferences.getString("tabs") ?? "{}";
    tabs.addAll(Map.castFrom(jsonDecode(tabsInfo)));
  }

  // 持久化保存信息
  void save() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("tabs", jsonEncode(tabs));
  }
}
