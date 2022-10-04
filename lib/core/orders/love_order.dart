import 'package:terminal/core/base_order.dart';
import 'package:terminal/core/error/order_error.dart';
import 'package:terminal/provider/others/user_provider.dart';

/// 用户指令
/// love指令: 标签管理，key-value
/// love -a key value: 添加新标签
/// love -d key: 删除标签
/// love -r oldKey newKey: 重命名标签
/// 不允许多参数
class LoveOrder extends BaseOrder {
  // love指令参数
  static final Map<String, LoveParams> _loveParams = {
    "-a": LoveParams.add,
    "-d": LoveParams.delete,
    "-r": LoveParams.rename,
  };

  @override
  String? execute(String order) {
    List<String> irs = order.split(" ");
    irs.removeWhere((element) => element.isEmpty);
    // 确保love指令只使用一个参数
    if (irs.length < 3 || irs.length > 4) {
      throw OrderError("Love order: invalid input");
    }
    parse(irs.sublist(1));
    return null;
  }

  @override
  void parse(List<String> params) {
    LoveParams? loveParams = _loveParams[params.first];
    if (loveParams == null) {
      throw OrderError("love指令: 参数不合法");
    }
    switch (loveParams) {
      case LoveParams.add:
        UserProvider.add(params[1], params[2]);
        break;
      case LoveParams.delete:
        UserProvider.remove(params[1]);
        break;
      case LoveParams.rename:
        UserProvider.rename(params[1], params[2]);
        break;
    }
    setHelp();
  }

  @override
  void setHelp() {
    super.helpInfo.clear();
    super.helpInfo.addAll({
      "Love order params": "",
      "-a": "Add new key-value",
      "-r": "Rename old key to new key",
      "-d": "Delete a key-value in the cache",
      "Tab list": "",
    });
    super.helpInfo.addAll(UserProvider.getAll());
  }

  @override
  void setParams() {
    super.params.addAll(_loveParams.keys);
  }
}

enum LoveParams { add, delete, rename }
