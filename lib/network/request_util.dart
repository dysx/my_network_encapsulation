import 'package:dio/dio.dart';
import 'package:my_network_encapsulation/network/http/http_util.dart';
import 'package:my_network_encapsulation/network/model/time_entity.dart';

import 'address.dart';
import 'model/get_recommends_entity.dart';

/// 请求管理
class RequestUtil {
  ///获取我的内容推荐列表
  static Future<GetRecommendsEntity> getRecommends(
      int pageIndex, int pageSize) {
    return HttpUtils.get(Address.GET_RECOMMENDS,
        params: {
          "PageIndex": pageIndex,
          "PageSize": pageSize,
        },
        refresh: false,);
  }

  static Future<TimeEntity> getTime() {
    return HttpUtils.get('https://quan.suning.com/getSysTime.do',
        // noCache: true,
        refresh: false
    );
  }

  ///获取我的内容推荐列表
  static Future login(String phoneNumber, String password) {
    return HttpUtils.post(Address.login, data: {
      "phoneNumber": phoneNumber,
      "password": password,
    });
  }

  static Future addFriend(int userId) {
    return HttpUtils.post(Address.addFriend, data: {"userId": userId});
  }
}
