
import 'package:my_network_encapsulation/network/api_config.dart';

/// 接口
class Address {

  ///基础地址
  static final String baseHttp = ApiConfig().getBaseUrl();

  ///获取我的内容推荐列表
  static final String getRecommends = baseHttp + "services/app/SearchService/GetRecommends";

  ///手机密码登陆
  static final String login = baseHttp + "TokenAuth/AuthenticateByPhonePwd";

  static final String addFriend = baseHttp + "services/app/NoticeService/AddFriend";

  static final String comment = baseHttp + 'services/app/CommentService/CommentWebArticle';

}