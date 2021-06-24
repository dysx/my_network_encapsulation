import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @name：OutlinedButton
/// @author qds

class MyOutlinedButton extends StatelessWidget {
  MyOutlinedButton({this.text, this.onPressed,this.borderColor,this.style});

  /// 按下事件
  final Function onPressed;
  /// 按钮文字
  final String text;
  /// 文字样式
  final TextStyle style;
  /// 边界颜色
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(text,style: style??null),
      style: OutlinedButton.styleFrom(
        // shape: StadiumBorder(),
        // side: BorderSide(color: borderColor ?? Colors.yellow, width: 1),
        // padding:  EdgeInsets.symmetric(vertical: 0)
      ),
    );
  }
}
