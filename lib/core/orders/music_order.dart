import 'dart:math';

import 'package:terminal/core/base_order.dart';
import 'package:terminal/provider/others/music_provider.dart';
import 'package:terminal/resource/music_resource.dart';

/// music指令: 播放音乐
class MusicOrder extends BaseOrder {
  static final Map<String, MusicParams> _musicParams = {
    "-stop": MusicParams.stop,
    "-start": MusicParams.start,
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
      int id = Random().nextInt(music.length) + 1;
      MusicProvider.setId(id.toString());
      MusicProvider.setPlay();
    }
    for (int i = 0; i < params.length; i = i + 2) {
      MusicParams ir = _musicParams[params[i]]!;
      switch (ir) {
        case MusicParams.stop:
          MusicProvider.setPause();
          break;
        case MusicParams.start:
          MusicProvider.setPlay();
          break;
      }
    }
  }

  @override
  void setParams() {
    super.params.addAll(_musicParams.keys);
  }

  @override
  void setHelp() {}
}

enum MusicParams { stop, start }
