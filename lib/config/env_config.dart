/// @describe: 打包环境
class EnvConfig {
  /// flutter build apk -t lib/main.dart --dart-define=ANDROID_VERSION=1.1.0 --dart-define=ANDROID_CHANNEL=yingyongbao
  /// -t lib/main.dart -t lib/main——dev.dart... 选择main文件入口
  /// 多渠道打包
  static const CHANNEL =
      String.fromEnvironment('ANDROID_CHANNEL', defaultValue: 'other');

  ///版本
  static const VERSION =
      String.fromEnvironment('ANDROID_VERSION', defaultValue: '1.0.0');
}
