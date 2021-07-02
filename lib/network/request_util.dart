import 'package:my_network_encapsulation/network/http/http_util.dart';
import 'package:my_network_encapsulation/network/model/login_entity.dart';
import 'package:my_network_encapsulation/network/model/time_entity.dart';

import 'address.dart';
import 'model/get_recommends_entity.dart';

/// 请求管理
class RequestUtil {

  static Future subscribeKey() {
    return HttpUtils.post(Address.comment,
      data: {
        "id": 255,
        "commentId": 0,
        "commentType": 0,
        "content": "123456"
      });
  }

  ///获取我的内容推荐列表
  static Future<List<GetRecommendsEntity>> getRecommends(
      int pageIndex, int pageSize) {
    return HttpUtils.get(Address.GET_RECOMMENDS,
        params: {
          "PageIndex": pageIndex,
          "PageSize": pageSize,
        },
        refresh: false);
  }

  static Future<TimeEntity> getTime() {
    return HttpUtils.get('https://quan.suning.com/getSysTime.do',
        // noCache: true,
        refresh: false
    );
  }

  ///登陆
  static Future<LoginEntity> login(String phoneNumber, String password) {
    return HttpUtils.post(Address.login, data: {
      "phoneNumber": phoneNumber,
      "password": password,
    });
  }

  static Future addFriend(int userId) {
    return HttpUtils.post(Address.addFriend, data: {"userId": userId});
  }
}
