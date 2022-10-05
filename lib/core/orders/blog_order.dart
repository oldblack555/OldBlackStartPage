import 'package:terminal/controller/system_controller.dart';
import 'package:terminal/core/base_order.dart';
import 'package:terminal/core/error/order_error.dart';
import 'package:url_launcher/url_launcher.dart';

/// 直接指令
/// 打开个人博客
class BlogOrder extends BaseOrder {
  @override
  String? execute(String order) {
    List<String> irs = order.split(" ");
    irs.removeWhere((element) => element.isEmpty);
    if (irs.length != 1) {
      throw OrderError("LhBlog指令: 格式不正确");
    }
    String url = "";
    if (SystemController.blog.startsWith("http://") ||
        SystemController.blog.startsWith("https://")) {
      url = SystemController.blog;
    } else {
      url = "http://${SystemController.blog}";
    }
    launchUrl(Uri.parse(url));
    return null;
  }

  @override
  void setParams() {}
  @override
  void setHelp() {}

  @override
  void parse(List<String> params) {}
}
