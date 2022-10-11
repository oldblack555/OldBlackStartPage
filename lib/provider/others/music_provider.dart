import 'dart:math';

import 'package:provider/provider.dart';
import 'package:terminal/controller/music_controller.dart';
import 'package:terminal/main.dart';
import 'package:terminal/resource/music_resource.dart';

class MusicProvider {
  static MusicController? _musicController;

  static void excute() async {
    init();
    _musicController!.isPlay ? play() : pause();
  }

  static void play() async {
    init();
    _musicController!.isPlay = true;

    await _musicController!.audioplayer
        .setSourceUrl(_musicController!.playId!, _musicController!.playId!);
    await _musicController!.audioplayer
        .seek(_musicController!.playId!, const Duration(seconds: 0));
    await _musicController!.audioplayer
        .setVolume(_musicController!.playId!, _musicController!.playVolumn);
    await _musicController!.audioplayer.resume(_musicController!.playId!);
  }

  static void pause() async {
    init();
    if (_musicController!.playId != null) {
      await _musicController!.audioplayer.pause(_musicController!.playId!);
    }
  }

  // 设置播放id，同播放源
  static void setId() async {
    init();
    int index = 0;
    if (_musicController!.musicList.isNotEmpty) {
      index = Random().nextInt(_musicController!.musicList.length);
    }
    _musicController!.playId = _musicController!.musicList.isEmpty
        ? musics[index]
        : _musicController!.musicList[index];
  }

  // 初始化播放器
  static void init() async {
    _musicController ??= Provider.of<MusicController>(
      navigatorKey.currentState!.overlay!.context,
      listen: false,
    );
    if (!(_musicController!.isInit)) {
      _musicController!.isInit = true;
      await _musicController!.load();
      _musicController!.audioplayer.completeStream.listen((event) {
        setId();
        play();
      });
    }
  }

  static void setPause() async {
    init();
    _musicController!.isPlay = false;
  }

  static void setPlay() {
    init();
    _musicController!.isPlay = true;
  }
}
