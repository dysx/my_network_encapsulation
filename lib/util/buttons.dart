import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/res/my_colors.dart';
import 'package:my_network_encapsulation/util/local_image_selector.dart';
import 'package:my_network_encapsulation/util/size_util.dart';

/// @name：app基本按钮

/// 不带图标文本按钮
Widget ordinaryButton(
        {VoidCallback? onPressed,
        String? text,
        TextStyle? textStyle,
        //点击波纹颜色
        Color? overlayColor,
        //背景色
        Color? backgroundColor,
        //内距
        EdgeInsets? padding,
        //圆角
        double? radius,
        //边界颜色
        Color? sideColor,
        //边界宽度
        double? sideWidth,
        //最小size
        Size? minimumSize}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(text!,
          style: textStyle ?? TextStyle(color: MyColors.black_3333)),
      style: ButtonStyle(
          padding: MaterialStateProperty.all(
              padding ?? EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
          // shape: MaterialStateProperty.all(StadiumBorder()),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 7))),
          overlayColor: MaterialStateProperty.all(overlayColor),
          backgroundColor: MaterialStateProperty.all(
              backgroundColor ?? null),
          minimumSize: MaterialStateProperty.all(minimumSize),
          side: sideColor != null
              ? MaterialStateProperty.all(
                  BorderSide(color: sideColor, width: sideWidth ?? 1))
              : null),
    );

/// 带图标文本按钮
Widget iconButton(
        {VoidCallback? onPressed,
        String? text,
        TextStyle? textStyle,
        String? icon,
        double? iconWidth,
        double? iconHeight,
        Color? backgroundColor,
        Color? overlayColor,
        Size? size,
        EdgeInsets? padding,
        double? radius,
        Color? borderColor}) =>
    OutlinedButton(
        onPressed: onPressed,
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            LocalImageSelector.getSingleImage(icon!,
                imageWidth: iconWidth ?? 10.w, imageHeight: iconHeight ?? 10.w),
            SizedBox(width: 10.w),
            Text(text!, style: textStyle)
          ],
        ),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(backgroundColor ?? MyColors.white),
            overlayColor:
                MaterialStateProperty.all(overlayColor ?? MyColors.background),
            //使用padding时须设置minimumSize为（0,0）
            minimumSize: MaterialStateProperty.all(size ?? Size(0, 0)),
            padding: MaterialStateProperty.all(padding ??
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.w)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                side: BorderSide(
                    color: borderColor ?? MyColors.background, width: 1),
                borderRadius: BorderRadius.circular(radius ?? 4)))));
