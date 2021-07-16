import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/res/my_colors.dart';
import 'package:my_network_encapsulation/util/local_image_selector.dart';
import 'package:my_network_encapsulation/util/size_util.dart';

typedef MyFunction = void Function();

/// @name：OutlinedButton
/// @author qds
/// 带边界的按钮
class MyOutlinedButton extends StatelessWidget {
  MyOutlinedButton(
      {this.text,
      this.onPressed,
      this.borderColor,
      this.style,
      this.padding,
      this.size,
      this.overlayColor,
      this.backgroundColor,
      this.radius,
      this.icon,
      this.multiplePixel: false,
      this.iconType : '.png',
      this.iconHeight,
      this.iconWidth});

  /// 按下事件
  final MyFunction? onPressed;

  /// 图标
  final String? icon;
  final bool multiplePixel;
  final String iconType;
  final double? iconWidth;
  final double? iconHeight;

  /// 文字
  final String? text;
  final TextStyle? style;

  /// 颜色
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? overlayColor;

  final Size? size;
  final EdgeInsets? padding;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      clipBehavior: Clip.antiAlias,
        onPressed: onPressed!,
        child:
        icon == null
            ? Text(text!, style: style ?? null)
            : Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  !multiplePixel
                      ? LocalImageSelector.getSingleImage(icon!,
                          type: iconType,
                          imageWidth: iconWidth ?? 10.w,
                          imageHeight: iconHeight ?? 10.w)
                      : LocalImageSelector.getImage(icon!,
                          type: iconType,
                          imageWidth: iconWidth ?? 10.w,
                          imageHeight: iconHeight ?? 10.w),
                  SizedBox(width: 10.w),
                  Text(text!, style: style)
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
  }
}
