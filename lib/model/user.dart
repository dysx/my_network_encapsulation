class User {
  int id;
  String nickname;
  String password;

  User(this.id,this.nickname,this.password);

  User.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        nickname = map["nickname"],
        password = map["password"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['nickname'] = nickname;
    data['password'] = password;
    return data;
  }
}
