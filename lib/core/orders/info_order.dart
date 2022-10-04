import 'package:terminal/core/base_order.dart';
import 'package:terminal/core/error/order_error.dart';

/// 系统指令
/// info指令: 提示可使用的指令和说明
/// 新的说明在setHelp方法中注册即可
class InfoOrder extends BaseOrder {
  @override
  String? execute(String order) {
    List<String> irs = order.split(" ");
    irs.removeWhere((element) => element.isEmpty);
    if (irs.length != 1) {
      throw OrderError("info指令: 格式不正确");
    }
    return null;
  }

  @override
  void parse(List<String> params) {}

  @override
  void setParams() {}

  @override
  void setHelp() {
    super.helpInfo.addAll(
      {
        "System order": "",
        "[config]": "Set system properties. Such as 'config -se bing'.",
        "[bg|bakground]": "Set system backgound image. Such as 'bg url'.",
        "[clear]": "Clear history messages",
        "User order": "",
        "[love]":
            "Add a entry to cache (key-value). Such as 'love -a bili bilibili.com'.",
        "[open|cd]":
            "Open website for specified URL. Such as 'cd url or open url'.",
        "[search]":
            "Search content-related. Such as 'search -e bing key or search key'.",
        "[music]": "Play music.",
        "Open order": "",
        "[blog]": "Open website for individual blog.",
        "[bili|bilibili]": "Open website for bilibili.com.",
        "[github]": "Open website for github.com.",
      },
    );
  }
}
