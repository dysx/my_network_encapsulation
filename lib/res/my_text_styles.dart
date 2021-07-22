import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/res/dimens.dart';

import 'my_colors.dart';

/// 字体样式
class MyTextStyles {
  static TextStyle fourteenWhite =
      TextStyle(fontSize: Dimens.fontSp14, color: Colors.white);
  static TextStyle fourteenBlack3333 =
      TextStyle(fontSize: Dimens.fontSp14, color: MyColors.black_3333);
  static TextStyle sixteenBlue91FF =
      TextStyle(fontSize: Dimens.fontSp16, color: MyColors.blue_91ff);
  static TextStyle fourteenBlue91FF =
  TextStyle(fontSize: Dimens.fontSp14, color: MyColors.blue_91ff);
  static TextStyle sixteenBlack3333 =
      TextStyle(fontSize: Dimens.fontSp16, color: MyColors.black_3333);
  static TextStyle sixteenWhite =
  TextStyle(fontSize: Dimens.fontSp16, color: MyColors.white);
  static TextStyle fourteenGrey3333 =
  TextStyle(fontSize: Dimens.fontSp14, color: MyColors.grey_9999);
  static TextStyle sixteenBlack3333Bold = TextStyle(
      fontSize: Dimens.fontSp16,
      color: MyColors.black_3333,
      fontWeight: FontWeight.bold);
}

class Styles {

  ///appbar阴影
  static const BoxShadow appbarShadow = BoxShadow(
    color: MyColors.appbar_bottom,
    offset: Offset(0, 2.0),
    blurRadius: 6.0,
  );

}
