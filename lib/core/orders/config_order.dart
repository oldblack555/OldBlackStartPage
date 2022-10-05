import 'package:terminal/controller/system_controller.dart';
import 'package:terminal/core/base_order.dart';
import 'package:terminal/core/error/order_error.dart';
import 'package:terminal/provider/others/system_provider.dart';
import 'package:terminal/resource/system_resource.dart';

/// 系统指令
/// config指令: 设置系统属性
/// 默认搜索引擎、背景颜色、背景透明度、字体大小、字体颜色、背景模糊程度
/// 例如: config -se bing -fs 26
/// config指令允许同时设置多个属性
class ConfigOrder extends BaseOrder {
  // config参数map，新增的参数都需在这注册，同事定义对应的枚举
  static final Map<String, ConfigParams> _configParams = {
    "-se": ConfigParams.searchEngine,
    "-bg": ConfigParams.background,
    "-ba": ConfigParams.alpha,
    "-fs": ConfigParams.fontSize,
    "-fc": ConfigParams.fontColor,
    "-blur": ConfigParams.blur,
    "-blog": ConfigParams.blog,
  };

  @override
  String? execute(String order) {
    // 指令划分
    List<String> irs = order.split(" ");

    // 找到最后一个参数的位置
    int index = irs.lastIndexWhere(
      (element) =>
          element.startsWith("-") && _configParams.containsKey(element),
    );
    // 参数解析
    parse(irs.sublist(1, index + 2));
    // 持久化系统状态信息
    SystemProvider.save();
    return "Set success";
  }

  @override
  void parse(List<String> params) {
    // 排除多个连续空格的干扰
    params.removeWhere((element) => element.isEmpty);
    // 参数不完整，config参数和值成对存在，否则输入不合法
    if (params.isEmpty || params.length % 2 != 0) {
      throw OrderError("Config order: invalid input");
    }
    // 遍历所有的参数
    for (int i = 0; i < params.length; i = i + 2) {
      ConfigParams param = _configParams[params[i]]!;
      switch (param) {
        case ConfigParams.searchEngine:
          if (!searchEngine.containsKey(params[i + 1])) {
            throw OrderError(
                "Config order: invalid value, Engine has ${searchEngine.keys}");
          }
          SystemController.defaultSearchEngine = params[i + 1];
          break;
        case ConfigParams.background:
          SystemController.bgIsImg = false; // 背景图和背景色切换
          if (!systemColors.containsKey(params[i + 1])) {
            throw OrderError(
                "Config order: invalid value, Color has ${systemColors.keys}");
          }
          SystemController.backgroundColor = systemColors[params[i + 1]]!;
          break;
        case ConfigParams.fontSize:
          try {
            double value = double.parse(params[i + 1]);
            SystemController.fontSize = value > 10 ? value : 10;
          } catch (e) {
            throw OrderError(
                "Config order: value required non-negative number");
          }
          break;
        case ConfigParams.fontColor:
          if (!systemColors.containsKey(params[i + 1])) {
            throw OrderError(
                "Config order: invalid value, Color has ${systemColors.keys}");
          }
          SystemController.fontColor = systemColors[params[i + 1]]!;
          break;
        case ConfigParams.alpha:
          try {
            double value = double.parse(params[i + 1]);
            if (value < 0 || value > 1) {
              throw OrderError("");
            }
            SystemController.alpha = (255 * value).toInt();
          } catch (e) {
            throw OrderError(
                "Config order: invalid value, value between 0 and 1");
          }
          break;
        case ConfigParams.blur:
          try {
            double value = double.parse(params[i + 1]);
            if (value < 0 || value > 100) {
              throw OrderError("");
            }
            SystemController.blur = value;
          } catch (e) {
            throw OrderError(
                "Config order: invalid value,  minimum value is 0 and maximum value is 100");
          }
          break;
        case ConfigParams.blog:
          SystemController.blog = params[i + 1];
          break;
      }
    }
  }

  @override
  void setParams() {
    super.params.addAll(_configParams.keys);
  }

  @override
  void setHelp() {
    super.helpInfo.addAll(
      {
        "Params: ": "",
        "-se":
            "Set default search engine. The available engines are ${searchEngine.keys}.",
        "-bg":
            "Set backgroud color. The available colors are ${systemColors.keys}.",
        "-ba": "Set background alpha. Alpha between 0 and 1.",
        "-fs":
            "Set system font size. The Minimum font size is 10 and the maximum font size is 60.",
        "-fc":
            "Set system font color. The availabel colors are ${systemColors.keys}",
        "-blur": "Set system background blur. Default value is 10",
        "-blog": "Set individual blog",
      },
    );
  }
}

enum ConfigParams {
  searchEngine,
  background,
  fontSize,
  fontColor,
  alpha,
  blur,
  blog,
}
