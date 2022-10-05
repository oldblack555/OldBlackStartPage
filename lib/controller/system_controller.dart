import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:terminal/provider/order/base_order_provider.dart';
import 'package:terminal/provider/order/order_provider.dart';
import 'package:terminal/resource/system_resource.dart';

/// 系统状态
/// 一个指令执行器和若干的系统属性
class SystemController extends ChangeNotifier {
  // order provider

  static late BaseOrderProvider baseOrderProvider;

  // 系统属性
  static late String defaultSearchEngine;
  static late bool bgIsImg;
  static late Color backgroundColor;
  static late String backgroundImage;
  static late double fontSize;
  static late Color fontColor;
  static late int alpha;
  static late double blur;
  static late String user;
  static late String blog;

  // 系统初始化，类似于开机
  static Future loadSystemInfo() async {
    // 执行器初始化
    baseOrderProvider = OrderProvider();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    defaultSearchEngine = (preferences.getString("engine") ?? defaultEngine);
    bgIsImg = preferences.getBool("isImg") ?? defalutIsImg;
    backgroundColor =
        systemColors[preferences.getString("bgColor") ?? defaultBgColor]!;
    backgroundImage = preferences.getString("bgImg") ?? defaultBgImg;
    fontSize = preferences.getDouble("fontSize") ?? defaultFontSize;
    fontColor =
        systemColors[preferences.getString("fontColor") ?? defaultFontColor]!;
    alpha = preferences.getInt("alpha") ?? defalutAlpha;
    user = preferences.getString("user") ?? defaultUser;
    blur = preferences.getDouble("blur") ?? defaultBlur;
    blog = preferences.getString("blog") ?? defaultBlog;
  }

  // 持久化系统状态，个性化用户的设置，使得用户无需二次设置个人偏好
  static void saveLoadInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("engine", defaultSearchEngine);
    preferences.setBool("isImg", bgIsImg);
    preferences.setString(
        "bgColor",
        systemColors.entries
            .firstWhere((element) => element.value == backgroundColor)
            .key);
    preferences.setString("bgImg", backgroundImage);
    preferences.setDouble("fontSize", fontSize);
    preferences.setString(
        "fontColor",
        systemColors.entries
            .firstWhere((element) => element.value == fontColor)
            .key);
    preferences.setInt("alpha", alpha);
    preferences.setString("user", user);
    preferences.setDouble("blur", blur);
    preferences.setString("blog", blog);
  }
}
