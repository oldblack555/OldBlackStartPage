import 'package:terminal/core/base_order.dart';
import 'package:terminal/core/error/order_error.dart';
import 'package:terminal/resource/system_resource.dart';

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
    super.helpInfo.addAll(orderHelpInfo);
  }
}
