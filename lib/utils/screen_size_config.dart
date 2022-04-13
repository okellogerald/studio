import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../manager/video_page/video_controls_actions_handler.dart';
import '../source.dart';

class ScreenSizeConfig {
  static Size _designSize = const Size(0, 0);
  static Size _screenSize = const Size(0, 0);

  static void init(Size designSize, Size screenSize, WidgetRef ref,
      Orientation orientation) {
    _designSize = designSize;
    _screenSize = screenSize;
    initOrientationMode(ref, orientation);
  }

  //s for screen
  //d for design
  static final sWidth = _screenSize.width;
  static final dWidth = _designSize.width;
  static final sHeight = _screenSize.height;
  static final dHeight = _designSize.height;

  static double get getFullWidth => _screenSize.width;
  static double get getFullHeight => _screenSize.height;

  static double getDoubleWidth(num width) => ((width * sWidth) / dWidth);
  static double getDoubleHeight(num height) => ((height * sHeight) / dHeight);
}

extension SizeExtension on num {
  // ignore: unused_element
  double get dw => ScreenSizeConfig.getDoubleWidth(this);
  double get dh => ScreenSizeConfig.getDoubleHeight(this);
}
