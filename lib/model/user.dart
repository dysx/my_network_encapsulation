/// @describe: 用户model
/// @author: qds
/// @date:
class User {
  String? nickName;
  String? avatarUrl;

  User(this.nickName, this.avatarUrl);

  User.fromJsonMap(Map<String, dynamic> map)
      : nickName = map["nickName"],
        avatarUrl = map["avatarUrl"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickName'] = nickName;
    data['avatarUrl'] = avatarUrl;
    return data;
  }
}
