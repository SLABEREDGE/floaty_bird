import 'package:flutter/material.dart';

extension ScreenSize on double {
  double get h => DeviceManager.instance.setHeight(this);

  double get w => DeviceManager.instance.setWidth(this);

  double get sp => DeviceManager.instance.setSp(this);
}

class DeviceManager {
  static DeviceManager? _instance;

  DeviceManager._internal();

  static DeviceManager get instance {
    _instance ??= DeviceManager._internal();

    return _instance!;
  }

  double width = 380.0;
  double height = 800.0;
  bool allowFontScaling = true;

  static MediaQueryData? _mediaQueryData;
  static double? _screenWidth;
  static double? _screenHeight;
  static double? _pixelRatio;
  static double? _statusBarHeight;

  static double? _bottomBarHeight;

  static double? _textScaleFactor;

  void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _mediaQueryData = mediaQuery;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = _mediaQueryData!.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  static MediaQueryData get mediaQueryData => _mediaQueryData!;

  static double get textScaleFactory => _textScaleFactor!;

  static double get pixelRatio => _pixelRatio!;

  static double get screenWidthDp => _screenWidth!;

  static double get screenHeightDp => _screenHeight!;

  static double get screenWidth => _screenWidth! * _pixelRatio!;

  static double get screenHeight => _screenHeight! * _pixelRatio!;

  static double get statusBarHeight => _statusBarHeight! * _pixelRatio!;

  static double get bottomBarHeight => _bottomBarHeight! * _pixelRatio!;

  get scaleWidth => _screenWidth! / instance.width;

  get scaleHeight => _screenHeight! / instance.height;

  setWidth(double width) => width * scaleWidth;

  setHeight(double height) => height * scaleHeight;

  setSp(double fontSize) => allowFontScaling
      ? setWidth(fontSize)
      : setWidth(fontSize) / _textScaleFactor;
}
