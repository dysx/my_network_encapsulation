
/// @describe: 开发环境

enum Domain {
  Product,
  Development,
  Local
}

class DomainConfig {
  static late Domain env;

  static String getBaseUrl(Domain domain) {
    switch (domain) {
      case Domain.Product:
        return 'https://app.lightencancer.cn/api/';
      case Domain.Development:
        return 'https://app.lh.test.medheadline.com/api/';
      case Domain.Local:
        return 'http://192.168.168.253:30080/api/';
      default: return 'http://192.168.168.253:30080/api/';
    }
  }
}