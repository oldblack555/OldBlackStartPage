// ignore_for_file: constant_identifier_names

import 'package:flutter/widgets.dart';

class ImageUtil {
  static const String _httpSvgReg =
      r"^(((http|https)\:\/\/)[\S]+(\.(svg|SVG))[\s\S]*)$";
  static const String _httpImageReg =
      r"^(((http|https)\:\/\/)[\S]+(\.(png|PNG|jpg|JPG|jpeg|JPEG|gif|GIF))[\s\S]*)$";
  static const String _localSvgReg =
      r"^((?!(http|https)\:\/\/)[\s\S]+(\.(svg|SVG)))$";

  static ImageEnum judgeType(dynamic image) {
    ImageEnum res = ImageEnum.ICON_DATA;
    if (image is IconData) {
      res = ImageEnum.ICON_DATA;
    } else if (image is String) {
      RegExp httpSvg = RegExp(_httpSvgReg);
      RegExp httpImage = RegExp(_httpImageReg);
      RegExp localSvg = RegExp(_localSvgReg);
      if (httpSvg.hasMatch(image)) {
        res = ImageEnum.NETWORK_SVG;
      } else if (httpImage.hasMatch(image)) {
        res = ImageEnum.NETWORK_IMAGE;
      } else if (localSvg.hasMatch(image)) {
        res = ImageEnum.LOCAL_SVG;
      } else {
        res = ImageEnum.LOCAL_IMAGE;
      }
    }
    return res;
  }

  static ImageProvider backgroundImage(String image) {
    ImageEnum imageEnum = judgeType(image);
    if (imageEnum == ImageEnum.LOCAL_IMAGE) {
      if (image.startsWith("assets")) {
        return AssetImage(image);
      }
    }
    return NetworkImage(image);
  }
}

enum ImageEnum {
  NETWORK_IMAGE,
  LOCAL_IMAGE,
  NETWORK_SVG,
  LOCAL_SVG,
  ICON_DATA,
}
