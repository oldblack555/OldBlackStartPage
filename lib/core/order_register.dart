import 'package:terminal/core/base_order.dart';
import 'package:terminal/core/orders/background_order.dart';
import 'package:terminal/core/orders/bilibili_order.dart';
import 'package:terminal/core/orders/clear_order.dart';
import 'package:terminal/core/orders/config_order.dart';
import 'package:terminal/core/orders/github_order.dart';
import 'package:terminal/core/orders/info_order.dart';
import 'package:terminal/core/orders/blog_order.dart';
import 'package:terminal/core/orders/love_order.dart';
import 'package:terminal/core/orders/music_order.dart';
import 'package:terminal/core/orders/note_order.dart';
import 'package:terminal/core/orders/open_order.dart';
import 'package:terminal/core/orders/search_order.dart';
import 'package:terminal/core/orders/stackoverflow_order.dart';

/// 指令集，实现的指令需要在OrderCore下注册才可使用
/// 指令分类:
/// 1、系统指令，更新系统属性的指令
/// 2、用户指令，提供用户特定功能的指令
/// 3、直接指令，直接打开特定网址的指令
class OrderCore {
  static final Map<String, BaseOrder> orders = {
    "search": SearchOrder(),
    "music": MusicOrder(),
    "config": ConfigOrder(),
    "open": OpenOrder(),
    "cd": OpenOrder(),
    "bg": BackgroundOrder(),
    "background": BackgroundOrder(),
    "clear": ClearOrder(),
    "blog": BlogOrder(),
    "bili": BiliBiliOrder(),
    "bilibili": BiliBiliOrder(),
    "github": GitHubOrder(),
    "info": InfoOrder(),
    "love": LoveOrder(),
    "stackof": StackOverflowOrder(),
    "note": NoteOrder(),
  };
}
