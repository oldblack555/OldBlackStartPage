import 'package:terminal/controller/system_controller.dart';
import 'package:terminal/core/base_order.dart';
import 'package:terminal/core/order_register.dart';
import 'package:terminal/provider/order/base_order_provider.dart';

/// 指令执行器
class OrderProvider extends BaseOrderProvider {
  @override
  List<String> excute(String value) {
    // 需要更新的消息列表
    List<String> messages = [];
    List<String> orders = value.split(" ");
    orders.removeWhere((element) => element.isEmpty);

    // 从指令集获取相应的指令
    BaseOrder baseOrder = OrderCore.orders[orders.first]!;

    // 对特殊的指令添加相应的显示消息
    if (orders.first != "clear") {
      messages.add("${SystemController.user} $value");
    }
    // 判断是否为帮助指令或参数
    if (orders.last == "--help" || orders.first == "info") {
      // info指令需要校验指令正确性
      if (orders.first == "infor") {
        baseOrder.execute(value);
      }
      // 更新消息列表，输出帮助信息
      baseOrder.help().entries.forEach((element) {
        messages.add("${element.key}: ${element.value}");
      });
    } else {
      // 非帮助指令执行
      String? res = baseOrder.execute(value);
      if (res != null) {
        messages.add(res);
      }
    }
    return messages;
  }

  @override
  String orderTab(String value) {
    if (value.isEmpty) {
      return "";
    }
    List<String> irs = value.split(" ");
    irs.removeWhere((element) => element.isEmpty);
    // 判断输入是指令还是参数，指令则调用orderHandle进行指令补全
    // 否则调用paramsHandle进行参数补全
    return irs.length == 1 ? orderHandle(irs) : paramsHandle(irs);
  }

  String orderHandle(List<String> irs) {
    String ir = OrderCore.orders.keys.firstWhere(
      (element) => element.startsWith(irs.first),
      orElse: () => "",
    );
    ir += ir.isEmpty ? "" : " ";
    return ir;
  }

  String paramsHandle(List<String> irs) {
    // 参数以'-'开始，不是则不进行提示
    if (!irs.last.startsWith("-")) {
      return "";
    }
    String param = irs.lastWhere(
      (element) => element.startsWith("-"),
      orElse: () => "",
    );
    // 获取对应的指令
    BaseOrder baseOrder = OrderCore.orders[irs.first]!;
    // 如果为'--'表示提示参数，否则使用order的hint方法获取提示信息
    String hint = param.startsWith("--") ? "--help" : baseOrder.hint(param);
    String ir = "";
    for (int i = 0; i < irs.length; i++) {
      if (i == irs.lastIndexOf(param)) {
        // 更新提示信息
        ir += hint.isEmpty ? "" : "$hint ";
      } else {
        ir += "${irs[i]} ";
      }
    }
    return ir;
  }
}
