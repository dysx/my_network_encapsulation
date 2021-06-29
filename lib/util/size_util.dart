import 'dart:ui';

import 'package:flutter/material.dart';

/// 屏幕适配
class SizeUtil {
  SizeUtil._();

  static MediaQueryData _mediaQueryData;

  /// UI 设计图的宽度(px)
  static const double _defaultWidth = 375;

  /// UI 设计图的高度(px)
  static const double _defaultHeight = 812;

  static num _uiWidthPx;
  static num _uiHeightPx;

  /// 屏幕宽度(dp)
  static double _screenWidth;

  /// 屏幕高度(dp)
  static double _screenHeight;

  /// 设备像素密度
  static double _pixelRatio;

  /// 控制字体是否要根据系统的“字体大小”辅助选项来进行缩放。默认值为false。
  static double _textScaleFactor;

  static bool _allowFontScaling;

  static double _px;

  static double _rpx;

  static void initialize(
      {double standardWidth = _defaultWidth,
        double standardHeight = _defaultHeight,
        bool allowFontScaling = false}) {
    _uiWidthPx = standardWidth;
    _uiHeightPx = standardHeight;

    _mediaQueryData = MediaQueryData.fromWindow(window);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;

    _pixelRatio = _mediaQueryData.devicePixelRatio;

    _textScaleFactor = _mediaQueryData.textScaleFactor;

    _allowFontScaling = allowFontScaling;
    _rpx = _screenWidth / _uiWidthPx;
    _px= _screenHeight / _uiHeightPx * 2;
  }

  /// 每个逻辑像素的字体像素数，字体的缩放比例
  static double get textScaleFactor => _textScaleFactor;

  static double get pixelRatio => _pixelRatio;

  static double get screenWidth => _screenWidth;

  static double get screenHeight => _screenHeight;

  /// 设备宽度 px
  static double get screenWidthPx => _screenWidth * _pixelRatio;

  /// 设备高度 px
  static double get screenHeightPx => _screenHeight * _pixelRatio;

  /// 实际的dp与UI设计px的比例
  static double get scaleWidth => _screenWidth / _uiWidthPx;

  static double get scaleHeight => _screenHeight / _uiHeightPx;

  static double get scaleText => scaleWidth;

  static num setPx(num size) => _rpx * size * 2;//原型图像素为*2，所以这里需要扩大2倍

  static num setRpx(num size) => _px * size;

  static num setWidth(num size) => size * scaleWidth;

  static num setHeight(num size) => size * scaleHeight;

  static num setSp(num size, {bool allowFontScalingSelf}) =>
      allowFontScalingSelf == null
          ? (_allowFontScaling
          ? (size * scaleText)
          : ((size * scaleText) / _textScaleFactor))
          : (allowFontScalingSelf
          ? (size * scaleText)
          : ((size * scaleText) / _textScaleFactor));

  static num setWidthPercent(int percent) => (_screenWidth * percent) / 100;

  static num setHeightPercent(int percent) => (_screenHeight * percent) / 100;
}

/// 对数进行扩展
extension NumExtensions on num {
  num get px => SizeUtil.setPx(this);

  num get rpx => SizeUtil.setRpx(this);

  num get w => SizeUtil.setWidth(this);

  num get h => SizeUtil.setHeight(this);

  num get sp => SizeUtil.setSp(this, allowFontScalingSelf: false);

  num get asp => SizeUtil.setSp(this, allowFontScalingSelf: true);

  num get wp => SizeUtil.setWidthPercent(this);

  num get hp => SizeUtil.setHeightPercent(this);
}
