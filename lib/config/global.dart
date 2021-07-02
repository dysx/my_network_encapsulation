import 'dart:io';

/// 全局配置
class Global {

  /// dio请求，网络出错是否可继续请求
  static bool retryEnable = false;

  /// 安卓平台
  static bool isAndroid = Platform.isAndroid;

  /// ios平台
  static bool isIos = Platform.isIOS;

}