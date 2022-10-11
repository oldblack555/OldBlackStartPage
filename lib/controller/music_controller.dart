import 'package:audioplayers_web/audioplayers_web.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:terminal/resource/music_resource.dart';

class MusicController extends ChangeNotifier {
  final AudioplayersPlugin audioplayer = AudioplayersPlugin();

  String? playId;

  final double playVolumn = 0.3;

  bool isPlay = true;

  bool isInit = false;

  final List<String> musicList = [];

  Future<void> load() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    musicList.addAll(preferences.getStringList("music") ?? musics);
  }

  void save() async {
    musicList.removeWhere((element) => musics.contains(element));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList("music", musicList);
  }
}
