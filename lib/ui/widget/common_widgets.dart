import 'package:flutter/material.dart';

class CommonWidgets {
  static AppBar appBar({String title: '', bool centerTitle: false, Widget? backIcon, List<Widget>? actions}) {
    return AppBar(
        leading: backIcon == null ? null : backIcon,
        centerTitle: centerTitle,
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: actions != null ? actions : null);
  }
}
