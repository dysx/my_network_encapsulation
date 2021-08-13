import 'dart:io';

import 'package:flutter/cupertino.dart';

/// @describe: app配置文件
/// @author: qds
/// @date:
class AppConfig {
  /// 全局key
  static final GlobalKey<NavigatorState> globalKey =
      GlobalKey<NavigatorState>();

  /// 是否为开发环境
  static bool get isDebug => !bool.fromEnvironment("dart.vm.product");

  /// dio请求，网络出错是否可继续请求
  static bool retryEnable = false;

  /// 安卓平台
  static bool isAndroid = Platform.isAndroid;

  /// ios平台
  static bool isIos = Platform.isIOS;

  /// 是否启用代理
  static const PROXY_ENABLE = false;

  /// 代理服务IP
  static const PROXY_IP = '192.168.168.254';

  /// 代理服务端口
  static const PROXY_PORT = 8888;

  /// 是否启用缓存
  static const CACHE_ENABLE = false;

  /// 缓存的最长时间，单位（秒）
  static const CACHE_MAXAGE = 1000;

  /// 最大缓存数
  static const CACHE_MAXCOUNT = 100;
}
