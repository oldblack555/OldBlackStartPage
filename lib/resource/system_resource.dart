import 'package:flutter/material.dart';

/// Search Engine
/// chrome: 谷歌搜索
/// bing: 必应搜索
/// baidu: 百度搜搜
const Map<String, String> searchEngine = {
  "chrome": "https://www.google.com/search?q=",
  "bing": "https://cn.bing.com/search?q=",
  "baidu": "https://www.baidu.com/s?word="
};

/// System properties
const String defaultEngine = "chrome";
const bool defalutIsImg = true;
const String defaultBgColor = "black";
const String defaultBgImg = "assets/images/bg-rem.jpg";
const double defaultFontSize = 20;
const String defaultFontColor = "yellow";
const int defalutAlpha = 100;
const double defaultBlur = 10;

/// System colors
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

/// User Infomation
const String defaultUser = "[@local]";
const String defaultBlog = "https://oldblack555.github.io";

/// Order Help Info
const Map<String, String> orderHelpInfo = {
  "System order": "",
  "[config]": "Set system properties. Such as 'config -se bing'.",
  "[bg|bakground]": "Set system backgound image. Such as 'bg url'.",
  "[clear]": "Clear history messages",
  "User order": "",
  "[love]":
      "Add a entry to cache (key-value). Such as 'love -a bili bilibili.com'.",
  "[open|cd]": "Open website for specified URL. Such as 'cd url or open url'.",
  "[search]":
      "Search content-related. Such as 'search -e bing key or search key'.",
  "[music]": "Play music.",
  "Open order": "",
  "[blog]": "Open website for individual blog.",
  "[bili|bilibili]": "Open website for bilibili.com.",
  "[github]": "Open website for github.com.",
  "[stackof]": "Open website for stackoverflow.com."
};
