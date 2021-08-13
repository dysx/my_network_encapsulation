import 'package:dio/dio.dart';
import 'package:my_network_encapsulation/network/http/http.dart';
import 'package:my_network_encapsulation/network/model/login_entity.dart';
import 'package:my_network_encapsulation/network/model/time_entity.dart';

import 'address.dart';
import 'model/get_recommends_entity.dart';

/// @describe: 请求管理
/// @author: qds
/// @date:
class RequestUtil {
  static Future subscribeKey({required String cancelTag}) {
    return Http().post(Address.comment,
        data: {
          "id": 255,
          "commentId": 0,
          "commentType": 0,
          "content": "123456"
        },
        cancelTag: cancelTag);
  }

  ///获取我的内容推荐列表
  static Future<List<GetRecommendsEntity>> getRecommends(
      int pageIndex, int pageSize,
      {required String cancelTag}) {
    CancelToken _cancelToken = CancelToken();
    return Http().get(Address.getRecommends,
        params: {
          "PageIndex": pageIndex,
          "PageSize": pageSize,
        },
        cancelTag: cancelTag,
        cancelToken: _cancelToken,
        refresh: false);
  }

  static Future<TimeEntity> getTime() {
    return Http().get('https://quan.suning.com/getSysTime.do',
        // noCache: true,
        refresh: false,
        cancelTag: '');
  }

  ///登陆
  static Future<LoginEntity> login(String phoneNumber, String password,
      {required String cancelTag}) {
    return Http().post(Address.login,
        data: {
          "phoneNumber": phoneNumber,
          "password": password,
        },
        cancelTag: cancelTag);
  }

  static Future addFriend(int userId, {required String cancelTag}) {
    return Http().post(
      Address.addFriend,
      data: {"userId": userId},
      cancelTag: cancelTag,
    );
  }
}
