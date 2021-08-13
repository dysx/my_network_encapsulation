import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

/// @describe: 预设图片选择工具，用于判断当前平台和当前手机屏幕密度获取适应的图片资源
/// @author: qds
/// @date:
class LocalImageSelector {
  /// 设备像素
  static double dpi = MediaQueryData.fromWindow(window).devicePixelRatio;

  /// 设备分辨率
  static Size physicalSize = window.physicalSize;

  /// 设备分辨率比值（height/width）
  static double physicalRatio = 0;
  static int platform = Platform.isAndroid ? 1 : 2;
  static late String basePath;
  static String postfix = ".png";

  static const Local_Icon_prefix = "assets/images/";

  static init() {
    basePath = Local_Icon_prefix;
    physicalRatio = (physicalSize.height) / (physicalSize.width);
    print("当前的屏幕像素比:$dpi");
    print("当前的屏幕分辨率:$physicalSize");
    print("当前的屏幕高宽比为:$physicalRatio");
    return basePath;
  }

  /// 根据设备分辨率适配图片
  /// 用于全屏图
  /// 启动页、引导页
  static Image getImgByPhysicalSize(
    String imageName, {
    double? imageWidth,
    double? imageHeight,
    String type: ".png",
    BoxFit? bFitFill,
    Key? key,
    Color? imageColor,
  }) {
    String basicPath;
    postfix = ".png";
    if (physicalRatio <= 1.5) {
      basicPath = Local_Icon_prefix + "physicalH/";
    } else if (physicalRatio <= 1.67) {
      basicPath = Local_Icon_prefix + "physicalM/";
    } else if (physicalRatio <= 1.78) {
      basicPath = Local_Icon_prefix + "physicalXH/";
    } else if (physicalRatio <= 2.17) {
      basicPath = Local_Icon_prefix + "physicalXXH/";
    } else {
      basicPath = Local_Icon_prefix + "physicalXH/";
    }

    String path = basicPath + imageName + postfix;
    return Image.asset(path,
        key: key,
        width: imageWidth,
        height: imageHeight,
        color: imageColor,
        fit: bFitFill ?? BoxFit.cover);
  }

  /// 根据像素获取不同像素的图片
  static Image getImage(String imageName,
      {double? imageWidth,
      double? imageHeight,
      String type: ".png",
      BoxFit? bFitFill,
      Key? key,
      Color? imageColor}) {
    late String basicPath;
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

  /// 没有区分像素的图片
  static Image getSingleImage(String imageName,
      {double? imageWidth,
      double? imageHeight,
      String type: ".png",
      BoxFit? bFitFill,
      Key? key,
      Color? imageColor}) {
    String path = basePath + imageName + type;
    return Image.asset(path,
        key: key,
        width: imageWidth,
        height: imageHeight,
        color: imageColor,
        fit: bFitFill ?? BoxFit.scaleDown);
  }
}
