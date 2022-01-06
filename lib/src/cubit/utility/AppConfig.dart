import 'package:flutter/widgets.dart';

class AppConfig {
  static AppConfig? _instance;

  MediaQueryData? _mediaQueryData;
  late double _screenWidth;
  late double _screenHeight;
  late double _blockSizeHorizontal;
  late double _blockSizeVertical;
  late double safeBlockHorizontal;
  late double safeBlockVertical;

  factory AppConfig.of(BuildContext context) {
    if (_instance == null) _instance = AppConfig(context);
    return _instance!;
  }

  AppConfig(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData!.size.width;
    _screenHeight = _mediaQueryData!.size.height;
    _blockSizeHorizontal = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;
  }

  double appHeight(double v) {
    return _blockSizeVertical * v;
  }

  double appWidth(double v) {
    return _blockSizeHorizontal * v;
  }
}
