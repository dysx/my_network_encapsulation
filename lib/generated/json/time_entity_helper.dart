import 'package:my_network_encapsulation/network/model/time_entity.dart';

timeEntityFromJson(TimeEntity data, Map<String, dynamic> json) {
	if (json['sysTime2'] != null) {
		data.sysTime2 = json['sysTime2']?.toString();
	}
	if (json['sysTime1'] != null) {
		data.sysTime1 = json['sysTime1']?.toString();
	}
	return data;
}

Map<String, dynamic> timeEntityToJson(TimeEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['sysTime2'] = entity.sysTime2;
	data['sysTime1'] = entity.sysTime1;
	return data;
}