class User {
  String? accessToken;
  int? expireInSeconds;
  bool? waitingForActivation;
  String? nickName;
  String? avatarUrl;
  String? easemobUserName;
  String? easemobPassword;
  bool? haveSelectDisease;
  int? diseaseId;

  User(
      {this.accessToken,
        this.expireInSeconds,
        this.waitingForActivation,
        this.nickName,
        this.avatarUrl,
        this.easemobUserName,
        this.easemobPassword,
        this.haveSelectDisease,
        this.diseaseId});

  User.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    expireInSeconds = json['expireInSeconds'];
    waitingForActivation = json['waitingForActivation'];
    nickName = json['nickName'];
    avatarUrl = json['avatarUrl'];
    easemobUserName = json['easemobUserName'];
    easemobPassword = json['easemobPassword'];
    haveSelectDisease = json['haveSelectDisease'];
    diseaseId = json['diseaseId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['expireInSeconds'] = this.expireInSeconds;
    data['waitingForActivation'] = this.waitingForActivation;
    data['nickName'] = this.nickName;
    data['avatarUrl'] = this.avatarUrl;
    data['easemobUserName'] = this.easemobUserName;
    data['easemobPassword'] = this.easemobPassword;
    data['haveSelectDisease'] = this.haveSelectDisease;
    data['diseaseId'] = this.diseaseId;
    return data;
  }
}
