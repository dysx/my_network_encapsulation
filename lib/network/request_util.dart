import 'package:dio/dio.dart';
import 'package:my_network_encapsulation/model/article.dart';
import 'package:my_network_encapsulation/model/user.dart';
import 'package:my_network_encapsulation/network/http/http.dart';

import 'address.dart';

// json转model
// return response.data['result']
// .map<Article>((item) => Article.fromJson(item))
// .toList();
// return Article.fromJson(response.data);

/// @describe: 请求管理
/// @author: qds
/// @date:
class RequestUtil {
  ///获取我的内容推荐列表
  static Future getRecommends(int pageIndex, int pageSize,
      {required String cancelTag}) async {
    CancelToken _cancelToken = CancelToken();
    var response = await Http().get(Address.getRecommends,
        params: {
          "PageIndex": pageIndex,
          "PageSize": pageSize,
        },
        cancelTag: cancelTag,
        cancelToken: _cancelToken,
        refresh: false);
    return response.data['result']
        .map<Article>((item) => Article.fromJson(item))
        .toList();
  }

  ///登陆
  static Future login(String phoneNumber, String password,
      {required String cancelTag}) async {
    var response = await Http().post(Address.login,
        data: {
          "phoneNumber": phoneNumber,
          "password": password,
        },
        cancelTag: cancelTag);
    return User.fromJson(response.data['result']);
  }
}
