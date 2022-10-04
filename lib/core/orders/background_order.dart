import 'package:terminal/controller/system_controller.dart';
import 'package:terminal/core/base_order.dart';
import 'package:terminal/core/error/order_error.dart';
import 'package:terminal/provider/others/system_provider.dart';
import 'package:terminal/resource/system_resource.dart';

/// 系统指令
/// background指令: 设置背景图片
class BackgroundOrder extends BaseOrder {
  @override
  String? execute(String order) {
    List<String> irs = order.split(" ");
    irs.removeWhere((element) => element.isEmpty);
    SystemController.bgIsImg = true;
    if (irs.length > 2) {
      throw OrderError("Background order: invalid input");
    }
    if (irs.length == 1) {
      SystemController.backgroundImage = defaultBgImg;
    } else {
      SystemController.backgroundImage = irs.last;
    }
    SystemProvider.save();
    return null;
  }

  @override
  void parse(List<String> params) {}

  @override
  void setParams() {}

  @override
  void setHelp() {}
}
