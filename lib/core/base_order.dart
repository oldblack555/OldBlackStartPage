/// BaseOrder提供指令基础方法、参数列表和提示信息。
/// 每个指令需要基础BaseOrder,必须实现execute方法。
/// 如果指令存在参数和提示信息，则需要实现对应的setParams和setHelp（使用--help参数时显示的信息）方法。
/// setParams和setHelp方法在指令对象实例化时由父类默认调用和填充相应信息。
abstract class BaseOrder {
  // 指令参数列表
  final List<String> params = [];

  // 指令提示信息
  final Map<String, String> helpInfo = {};

  // 指令初始化，设置指令参数列表和提示信息
  BaseOrder() {
    setParams();
    setHelp();
  }

  // 设置参数列表
  void setParams();

  // 设置提示信息
  void setHelp();

  // 参数解析
  void parse(List<String> params);

  // 指令执行，子类必须实现对应指令的执行逻辑，返回可null的字符串类型。
  // 如果存在参数则需要调用parse方法进行参数解析。
  String? execute(String order);

  // 返回参数输入提示信息，默认实现为返回逻辑为第一个与输入匹配的参数。
  // 子类可重写逻辑
  String hint(String param) {
    return params.isEmpty
        ? ""
        : params.firstWhere(
            (element) => element.startsWith(param),
            orElse: () => "",
          );
  }

  // 返回指令帮助信息，可选
  // 子类可重写逻辑
  Map<String, String> help() {
    return helpInfo;
  }
}
