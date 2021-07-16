import 'package:my_network_encapsulation/generated/json/base/json_convert_content.dart';
import 'package:my_network_encapsulation/generated/json/base/json_field.dart';

class LoginEntity with JsonConvert<LoginEntity> {
	String? accessToken;
	int? expireInSeconds;
	bool? waitingForActivation;
	String? nickName;
	String? avatarUrl;
	String? easemobUserName;
	String? easemobPassword;
	bool? haveSelectDisease;
	int? diseaseId;
}
