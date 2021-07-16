import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/ui/common/button/outlined_button.dart';
import 'package:my_network_encapsulation/util/size_util.dart';

/// @name：textButton
/// @author qds
class MyTextButton extends StatelessWidget {
  MyTextButton(
      {this.onPressed, this.text, this.backgroundColor, this.overlayColor,this.style,this.buttonSize});

  /// 按下事件
  final MyFunction? onPressed;
  /// 按钮文字
  final String? text;
  /// 文字样式
  final TextStyle? style;
  /// 叠加颜色
  final Color? overlayColor;
  /// 背景颜色
  final Color? backgroundColor;
  /// 按钮尺寸
  final Size? buttonSize;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text!,style: style ?? null,),
      style: ButtonStyle(
        // padding: padding ?? MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10)),
        // shape: MaterialStateProperty.all(StadiumBorder()),
        overlayColor: overlayColor != null ? MaterialStateProperty.all(overlayColor) : null,
        backgroundColor: backgroundColor != null ? MaterialStateProperty.all(backgroundColor) : null,
        minimumSize: buttonSize != null ? MaterialStateProperty.all(buttonSize) : null,
        // shape: MaterialStateProperty.all(RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(7.0),
        //     side: BorderSide(
        //       color: Colors.yellow,
        //       width: 1,
        //     ))),
        // backgroundColor: MaterialStateProperty.resolveWith((states) {
        //   if (states.contains(MaterialState.pressed)) {
        //     return backgroundColor.withOpacity(0.5);
        //   }
        //   return backgroundColor;
        // })
      ),
    );
  }
}
