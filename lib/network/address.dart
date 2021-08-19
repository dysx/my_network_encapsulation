
/// @describe: api地址
/// @author: qds
/// @date:
class Address {

  static setBaseUrl(String baseUrl) {
    baseHttp = baseUrl;
  }

  ///基础地址
  static late String baseHttp;

  ///获取我的内容推荐列表
  static final String getRecommends =
      baseHttp + "services/app/SearchService/GetRecommends";

  ///手机密码登陆
  static final String login = baseHttp + "TokenAuth/AuthenticateByPhonePwd";

  static final String addFriend =
      baseHttp + "services/app/NoticeService/AddFriend";

  static final String comment =
      baseHttp + 'services/app/CommentService/CommentWebArticle';
}
