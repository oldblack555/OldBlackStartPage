import 'package:terminal/controller/system_controller.dart';
import 'package:terminal/core/base_order.dart';
import 'package:terminal/core/error/order_error.dart';
import 'package:terminal/resource/system_resource.dart';
import 'package:url_launcher/url_launcher.dart';

/// 用户指令
/// search指令: 搜索内容
/// -e: 指定搜索引擎
/// 可用搜索引擎：chrome，bing，baidu
class SearchOrder extends BaseOrder {
  /// 指令参数
  /// -e: 切换搜索引擎
  static final Map<String, SearchParams> _params = {
    "-e": SearchParams.engine,
  };

  // 选择的搜索引擎，默认为谷歌搜索
  late String _useEngine;

  // 搜索内容
  late String _content;

  @override
  String? execute(String order) {
    List<String> irs = order.split(" ");
    // 最后一个参数的位置
    int index = irs.lastIndexWhere(
      (element) => element.startsWith("-"),
    );
    parse(irs.sublist(1, index + 2));

    // 生成搜索内容
    _content = "";
    for (int i = index + 2; i < irs.length; i++) {
      if (irs[i].isEmpty) {
        continue;
      }
      _content += "${irs[i]} ";
    }

    // 启动搜索
    launchUrl(Uri.parse("$_useEngine$_content"));
    return null;
  }

  @override
  void parse(List<String> params) {
    params.removeWhere((element) => element.isEmpty);

    // 搜索引擎为空使用默认引擎
    if (params.isEmpty) {
      _useEngine = searchEngine[SystemController.defaultSearchEngine]!;
    }
    if (params.length % 2 != 0) {
      throw OrderError("search指令: 参数不合法");
    }
    // 遍历执行每个参数
    for (int i = 0; i < params.length; i = i + 2) {
      SearchParams param = _params[params[i]]!;
      switch (param) {
        case SearchParams.engine:
          _useEngine = searchEngine[params[i + 1]]!;
          break;
      }
    }
  }

  @override
  void setHelp() {
    super.helpInfo.addAll({
      "-e": "Specified search engine. The available are ${searchEngine.keys}."
    });
  }

  @override
  void setParams() {
    super.params.addAll(_params.keys);
  }
}

enum SearchParams { engine }
