import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @name：textButton
/// @author qds
class MyTextButton extends StatelessWidget {
  MyTextButton(
      {this.onPressed, this.text, this.backgroundColor, this.overlayColor,this.style});

  final Function onPressed;
  final String text;
  final Color overlayColor;
  final Color backgroundColor;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text,style: style??null,),
      style: ButtonStyle(
        // padding: padding ?? MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10)),
        // shape: MaterialStateProperty.all(StadiumBorder()),
        overlayColor: MaterialStateProperty.all(overlayColor) ?? null,
        backgroundColor: MaterialStateProperty.all(backgroundColor) ?? null,
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
