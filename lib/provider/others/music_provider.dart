import 'package:provider/provider.dart';
import 'package:terminal/controller/music_controller.dart';
import 'package:terminal/main.dart';
import 'package:terminal/resource/music_resource.dart';

class MusicProvider {
  static late MusicController? _musicController;

  static void excute() async {
    init();
    _musicController!.isPlay ? play() : pause();
  }

  static void play() async {
    init();
    _musicController!.isPlay = true;

    await _musicController!.audioplayer.setSourceUrl(
        _musicController!.playId, music[_musicController!.playId]!);
    await _musicController!.audioplayer
        .seek(_musicController!.playId, const Duration(seconds: 0));
    await _musicController!.audioplayer
        .setVolume(_musicController!.playId, _musicController!.playVolumn);
    await _musicController!.audioplayer.resume(_musicController!.playId);
  }

  static void pause() async {
    init();
    await _musicController!.audioplayer.pause(_musicController!.playId);
  }

  static void setId(String id) async {
    init();
    _musicController!.playId = id;
  }

  static void init() {
    _musicController = Provider.of<MusicController>(
      navigatorKey.currentState!.overlay!.context,
      listen: false,
    );
  }

  static void setPause() {
    init();
    _musicController!.isPlay = false;
  }

  static void setPlay() {
    init();
    _musicController!.isPlay = true;
  }
}
