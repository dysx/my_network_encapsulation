import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @name：OutlinedButton
/// @author qds

class MyOutlinedButton extends StatelessWidget {
  MyOutlinedButton({this.text, this.onPressed,this.borderColor,this.style});

  final Function onPressed;
  final String text;
  final Color borderColor;
  final TextStyle style;

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
