import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/res/dimens.dart';

import 'app_colors.dart';

/// @describe: 字体样式
/// @author: qds
/// @date:
class AppTextStyles {
  static TextStyle tenBlack3333 =
      TextStyle(fontSize: Dimens.fontSp10, color: AppColors.black_3333);

  static TextStyle tenYellow =
      TextStyle(fontSize: Dimens.fontSp10, color: AppColors.yellow_ab00);

  static TextStyle fourteenWhite =
      TextStyle(fontSize: Dimens.fontSp14, color: Colors.white);

  static TextStyle fourteenBlack3333 =
      TextStyle(fontSize: Dimens.fontSp14, color: AppColors.black_3333);

  static TextStyle sixteenBlue91FF =
      TextStyle(fontSize: Dimens.fontSp16, color: AppColors.blue_91ff);

  static TextStyle fourteenBlue91FF =
      TextStyle(fontSize: Dimens.fontSp14, color: AppColors.blue_91ff);

  static TextStyle sixteenBlack3333 =
      TextStyle(fontSize: Dimens.fontSp16, color: AppColors.black_3333);

  static TextStyle sixteenWhite =
      TextStyle(fontSize: Dimens.fontSp16, color: AppColors.white);

  static TextStyle fourteenGrey3333 =
      TextStyle(fontSize: Dimens.fontSp14, color: AppColors.grey_9999);

  static TextStyle sixteenBlack3333Bold = TextStyle(
      fontSize: Dimens.fontSp16,
      color: AppColors.black_3333,
      fontWeight: FontWeight.bold);

  static TextStyle sixteenBlack3333W500 = TextStyle(
      fontSize: Dimens.fontSp16,
      color: AppColors.black_3333,
      fontWeight: FontWeight.w500);

  static TextStyle sixteenFF66 =
      TextStyle(fontSize: Dimens.fontSp16, color: AppColors.grey_ff66);
}

class AppShadow {
  ///appbar阴影
  static const BoxShadow appbarShadow = BoxShadow(
    color: AppColors.appbar_bottom,
    offset: Offset(0, 2.0),
    blurRadius: 6.0,
  );
}
