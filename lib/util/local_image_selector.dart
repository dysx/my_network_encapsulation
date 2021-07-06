import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

///预设图片选择工具，用于判断当前平台和当前手机屏幕密度获取适应的图片资源
class LocalImageSelector {
  static double dpi = MediaQueryData.fromWindow(window).devicePixelRatio; //屏幕密度
  static int platform = Platform.isAndroid ? 1 : 2;
  static String basePath;
  static String postfix = ".png";

  static const Local_Icon_prefix = "assets/images/";

  static init() {
    print("初始化LocalImageSelector当前的屏幕密度:$dpi");
    basePath = Local_Icon_prefix;
    return basePath;
  }

  static Image getImage(String imageName,
      {double imageWidth,
      double imageHeight,
      String type: ".png",
      BoxFit bFitFill,
      Key key,
      Color imageColor}) {
    String basicPath;
    if (platform == 1) {
      postfix = type;
      if (dpi < 1) {
        basicPath = Local_Icon_prefix + "android/mdpi/";
      } else if (dpi < 1.5) {
        basicPath = Local_Icon_prefix + "android/hdpi/";
      } else if (dpi < 2) {
        basicPath = Local_Icon_prefix + "android/xhdpi/";
      } else if (dpi < 3) {
        basicPath = Local_Icon_prefix + "android/xxhdpi/";
      } else {
        basicPath = Local_Icon_prefix + "android/xxxhdpi/";
      }
    } else {
      basePath = Local_Icon_prefix + "ios/";
      if (dpi < 2.5) {
        postfix = "@2x" + type;
      } else {
        postfix = "@3x" + type;
      }
    }
    String path = basicPath + imageName + postfix;
    return Image.asset(path,
        key: key,
        width: imageWidth,
        height: imageHeight,
        color: imageColor,
        fit: bFitFill ?? BoxFit.scaleDown);
  }

  /// 没有区分分辨率的图标
  static Image getSingleImage(String imageName,
      {double imageWidth,
      double imageHeight,
      String type: ".png",
      BoxFit bFitFill,
      Key key,
      Color imageColor}) {
    String path = basePath + imageName + type;
    return Image.asset(path,
        key: key,
        width: imageWidth,
        height: imageHeight,
        color: imageColor,
        fit: bFitFill ?? BoxFit.scaleDown);
  }
}
