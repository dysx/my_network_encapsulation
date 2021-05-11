import 'dart:io';

/// 系统标记类
class BuildConfig {

  /// 是否为开发环境
  static bool get isDebug => !bool.fromEnvironment("dart.vm.product");

}
