import 'package:terminal/core/base_order.dart';
import 'package:terminal/core/error/order_error.dart';
import 'package:terminal/provider/others/content_provider.dart';

/// 系统指令
/// clear指令: 清除content
class ClearOrder extends BaseOrder {
  @override
  String? execute(String order) {
    List<String> irs = order.split(" ");
    irs.removeWhere((element) => element.isEmpty);
    if (irs.length != 1) {
      throw OrderError("Clear order: invalid input");
    }
    ContentProvider.clear();
    return null;
  }

  @override
  void parse(List<String> params) {}

  @override
  void setHelp() {}

  @override
  void setParams() {}
}
