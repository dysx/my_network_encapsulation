import 'package:flutter/cupertino.dart';

/// app配置文件
class Application {

  /// 全局key
  static final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  /// 是否有网
  static bool haveNetWork;

}