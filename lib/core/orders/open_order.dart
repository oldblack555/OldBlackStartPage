import 'package:terminal/core/base_order.dart';
import 'package:terminal/core/error/order_error.dart';
import 'package:terminal/provider/others/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';

/// 用户指令
/// Open指令：打开网页
/// open key(收藏的key-value) 或者 open url
/// 自动补全http://
class OpenOrder extends BaseOrder {
  @override
  String? execute(String order) {
    List<String> irs = order.split(" ");
    // 去除空字符串
    irs.removeWhere((element) => element.isEmpty);
    if (irs.length != 2) {
      throw OrderError("open指令: 输入网址或收藏的网址名称");
    }

    // 判断是用户收藏的tab还是url。
    String url = UserProvider.get(irs.last) ?? irs.last;

    //补全http://
    if (!url.startsWith("http://") && !url.startsWith("https://")) {
      url = "http://$url";
    }

    // 打开网页
    launchUrl(Uri.parse(url));
    return null;
  }

  @override
  void setHelp() {}

  @override
  void setParams() {}

  @override
  void parse(List<String> params) {}
}
