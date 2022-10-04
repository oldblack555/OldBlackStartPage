import 'package:terminal/core/base_order.dart';
import 'package:terminal/core/error/order_error.dart';
import 'package:url_launcher/url_launcher.dart';

/// 直接指令
/// 打开github官网
class GitHubOrder extends BaseOrder {
  @override
  String? execute(String order) {
    List<String> irs = order.split(" ");
    irs.removeWhere((element) => element.isEmpty);
    if (irs.length != 1) {
      throw OrderError("Github order: invalid input");
    }
    launchUrl(Uri.parse("https://github.com"));
    return null;
  }

  @override
  void setParams() {}

  @override
  void parse(List<String> params) {}

  @override
  void setHelp() {}
}
