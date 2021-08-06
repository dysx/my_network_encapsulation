
///@describe: 打包环境
class EnvConfig {
  
  ///flutter build apk --dart-define=ANDROID_VERSION=1.1.0 --dart-define=ANDROID_CHANNEL=yingyongbao
  ///多渠道打包
  static const CHANNEL = String.fromEnvironment('ANDROID_CHANNEL',defaultValue: 'other');
  ///版本
  static const VERSION = String.fromEnvironment('ANDROID_VERSION',defaultValue: '1.0.0');
  ///开发环境   测试环境test  正式环境production  本地环境local
  static const API_ENVIRONMENT = String.fromEnvironment('ANDROID_API_ENVIRONMENT',defaultValue: 'test');

}