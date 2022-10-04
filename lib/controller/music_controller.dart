import 'package:audioplayers_web/audioplayers_web.dart';
import 'package:flutter/foundation.dart';

class MusicController extends ChangeNotifier {
  final AudioplayersPlugin audioplayer = AudioplayersPlugin();

  late String playId = "4";

  final double playVolumn = 0.3;

  late bool isPlay = true;
}
