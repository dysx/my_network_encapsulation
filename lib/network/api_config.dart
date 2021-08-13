import 'package:my_network_encapsulation/config/appConfig.dart';

/// @description: api域名配置
/// @author: qds
/// @date:
abstract class Config {
  String getBaseUrl();
}

class TestConfig extends Config {
  //测试环境
  static const BASE_URL = "https://app.lh.test.medheadline.com/api/";

  @override
  String getBaseUrl() {
    return BASE_URL;
  }
}

class ProductionConfig extends Config {
  //生产环境
  static const BASE_URL = "https://app.lightencancer.cn/api/";

  @override
  String getBaseUrl() {
    return BASE_URL;
  }
}

class LocalConfig extends Config {
  //本地环境
  static const BASE_URL = "http://192.168.168.253:30080/api/";

  @override
  String getBaseUrl() {
    return BASE_URL;
  }
}

class ApiConfig extends Config {
  factory ApiConfig() => _getInstance()!;

  static ApiConfig? _instance = ApiConfig._internal();

  ApiConfig._internal() {
    //初始化
    if (AppConfig.isDebug) {
      baseUrl = TestConfig.BASE_URL;
    } else {
      baseUrl = ProductionConfig.BASE_URL;
    }
  }

  static ApiConfig? _getInstance() {
    if (_instance == null) {
      _instance = new ApiConfig._internal();
    }
    return _instance;
  }

  static String baseUrl = '';

  String getBaseUrl() {
    return baseUrl;
  }
}
