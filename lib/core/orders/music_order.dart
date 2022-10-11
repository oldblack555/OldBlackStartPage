import 'package:terminal/core/base_order.dart';
import 'package:terminal/core/error/order_error.dart';
import 'package:terminal/provider/others/music_provider.dart';
import 'package:terminal/util/params_util.dart';

/// 娱乐指令（开发阶段）
/// music指令: 播放音乐
class MusicOrder extends BaseOrder {
  static final Map<String, MusicParams> _musicParams = {
    "-stop": MusicParams.stop,
    "-start": MusicParams.start,
    "-add": MusicParams.add,
    "-remove": MusicParams.remove,
  };

  @override
  String? execute(String order) {
    List<String> irs = order.split(" ");
    irs.removeWhere((element) => element.isEmpty);
    parse(irs.sublist(1));
    MusicProvider.excute();
    return null;
  }

  @override
  void parse(List<String> params) {
    if (params.isEmpty) {
      MusicProvider.pause();
      MusicProvider.setId();
      MusicProvider.setPlay();
      return;
    }
    // 只允许一个参数
    if (!ParamsUtil.requiredOneParam(params)) {
      throw OrderError("Music order: invalid input");
    }
    MusicParams ir = _musicParams[params.first]!;
    switch (ir) {
      case MusicParams.stop:
        MusicProvider.setPause();
        break;
      case MusicParams.start:
        MusicProvider.setPlay();
        break;
      case MusicParams.add:
        break;
      case MusicParams.remove:
        break;
    }
  }

  @override
  void setParams() {
    super.params.addAll(_musicParams.keys);
  }

  @override
  void setHelp() {}
}

enum MusicParams {
  stop,
  start,
  add,
  remove,
}
