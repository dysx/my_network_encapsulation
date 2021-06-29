import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/config/application.dart';

///@name: 路由工具
class Navigater {
  ///打开新页面
  static Future pushNamed(String routeName, {Map<String, dynamic> arguments}) {
    return Application.globalKey.currentState
        .pushNamed(routeName, arguments: arguments);
  }

  ///打开新页面替代旧页面
  static Future pushReplacementNamed(String routeName,
      {Map<String, dynamic> arguments}) {
    return Application.globalKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  ///关闭所有页面并打开新页面
  static Future pushNamedAndRemoveUntil(String routeName,
      {Map<String, dynamic> arguments}) {
    return Application.globalKey.currentState.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  ///回退到某个路由页面
  ///A->B->C->D   回退到A页面
  static popUntil(String routeName) {
    return Navigator.popUntil(
        Application.globalKey.currentState.overlay.context,
        ModalRoute.withName(routeName));
  }

  ///关闭当前页面
  ///mag: 回传数据给上一个页面
  static pop({dynamic msg}) {
    msg == null
        ? Navigator.of(Application.globalKey.currentState.overlay.context).pop()
        : Navigator.of(Application.globalKey.currentState.overlay.context)
            .pop(msg);
  }
}
