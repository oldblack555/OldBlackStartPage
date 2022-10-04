import 'package:flutter/material.dart';

const Map<String, Color> systemColors = {
  "red": Colors.redAccent,
  "black": Colors.black,
  "blue": Colors.blueAccent,
  "green": Colors.greenAccent,
  "pink": Colors.pinkAccent,
  "purple": Colors.purpleAccent,
  "white": Colors.white,
  "orange": Colors.orangeAccent,
  "yellow": Colors.yellowAccent,
};

/// 搜索引擎
/// chrome: 谷歌搜索
/// bing: 必应搜索
/// baidu: 百度搜搜
const Map<String, String> searchEngine = {
  "chrome": "https://www.google.com/search?q=",
  "bing": "https://cn.bing.com/search?q=",
  "baidu": "https://www.baidu.com/s?word="
};

const String defaultEngine = "chrome";
const bool defalutIsImg = true;
const String defaultBgColor = "black";
const String defaultBgImg = "assets/images/bg-rem.jpg";
const double defaultFontSize = 20;
const String defaultFontColor = "yellow";
const int defalutAlpha = 100;
const double defaultBlur = 10;

const String defaultUser = "[@local]";
