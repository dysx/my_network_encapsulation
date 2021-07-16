import 'package:my_network_encapsulation/network/model/login_entity.dart';

loginEntityFromJson(LoginEntity data, Map<String, dynamic> json) {
	if (json['accessToken'] != null) {
		data.accessToken = json['accessToken'];
	}
	if (json['expireInSeconds'] != null) {
		data.expireInSeconds = json['expireInSeconds'];
	}
	if (json['waitingForActivation'] != null) {
		data.waitingForActivation = json['waitingForActivation'];
	}
	if (json['nickName'] != null) {
		data.nickName = json['nickName'];
	}
	if (json['avatarUrl'] != null) {
		data.avatarUrl = json['avatarUrl'];
	}
	if (json['easemobUserName'] != null) {
		data.easemobUserName = json['easemobUserName'];
	}
	if (json['easemobPassword'] != null) {
		data.easemobPassword = json['easemobPassword'];
	}
	if (json['haveSelectDisease'] != null) {
		data.haveSelectDisease = json['haveSelectDisease'];
	}
	if (json['diseaseId'] != null) {
		data.diseaseId = json['diseaseId'];
	}
	return data;
}

Map<String, dynamic> loginEntityToJson(LoginEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['accessToken'] = entity.accessToken;
	data['expireInSeconds'] = entity.expireInSeconds;
	data['waitingForActivation'] = entity.waitingForActivation;
	data['nickName'] = entity.nickName;
	data['avatarUrl'] = entity.avatarUrl;
	data['easemobUserName'] = entity.easemobUserName;
	data['easemobPassword'] = entity.easemobPassword;
	data['haveSelectDisease'] = entity.haveSelectDisease;
	data['diseaseId'] = entity.diseaseId;
	return data;
}