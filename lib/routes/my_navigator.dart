import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/config/appConfig.dart';

/// @describe: 路由工具
/// @author: qds
/// @date:
class MyNavigator {
  /// 打开新页面
  static Future pushNamed(String routeName, {Map<String, dynamic>? arguments}) {
    return AppConfig.globalKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  /// 打开新页面替代旧页面
  static Future pushReplacementNamed(String routeName,
      {Map<String, dynamic>? arguments}) {
    return AppConfig.globalKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  /// 关闭所有页面并打开新页面
  static Future pushNamedAndRemoveUntil(String routeName,
      {Map<String, dynamic>? arguments}) {
    return AppConfig.globalKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  /// 回退到某个路由页面
  /// A->B->C->D   回退到A页面
  static popUntil(String routeName) {
    return Navigator.popUntil(
        AppConfig.globalKey.currentState!.overlay!.context,
        ModalRoute.withName(routeName));
  }

  /// 关闭当前页面
  /// msg: 回传数据给上一个页面
  static pop({dynamic msg}) {
    msg == null
        ? Navigator.of(AppConfig.globalKey.currentState!.overlay!.context).pop()
        : Navigator.of(AppConfig.globalKey.currentState!.overlay!.context)
            .pop(msg);
  }
}
