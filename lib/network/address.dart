
/// 接口
class Address {

  static const String BASE_HTTP = "https://app.lightencancer.cn/api/";

  ///获取我的内容推荐列表
  static const String GET_RECOMMENDS = BASE_HTTP + "services/app/SearchService/GetRecommends";

  ///手机密码登陆
  static const String login = BASE_HTTP + "TokenAuth/AuthenticateByPhonePwd";

  static const String addFriend = BASE_HTTP + "services/app/NoticeService/AddFriend";


}