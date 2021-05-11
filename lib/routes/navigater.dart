
import 'package:flutter/cupertino.dart';
import 'package:my_network_encapsulation/config/application.dart';

/// 路由工具
class Navigater {

  static void pop() {
    Navigator.of(Application.globalKey.currentState.overlay.context).pop();
  }

}