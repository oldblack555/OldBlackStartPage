/// 执行指令的provider
/// 可继承该类实现自己的执行器
abstract class BaseOrderProvider {
  // 指令执行方法，必须实现，最简单方式直接调用指令的excute方法即可。
  List<String> excute(String value);

  // 指令补全方法
  String orderTab(String value);
}
