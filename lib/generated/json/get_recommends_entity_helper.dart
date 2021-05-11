import 'package:my_network_encapsulation/network/model/get_recommends_entity.dart';

getRecommendsEntityFromJson(GetRecommendsEntity data, Map<String, dynamic> json) {
	if (json['result'] != null) {
		data.result = new List<GetRecommandsResult>();
		(json['result'] as List).forEach((v) {
			data.result.add(new GetRecommandsResult().fromJson(v));
		});
	}
	if (json['targetUrl'] != null) {
		data.targetUrl = json['targetUrl'];
	}
	if (json['success'] != null) {
		data.success = json['success'];
	}
	if (json['error'] != null) {
		data.error = json['error'];
	}
	if (json['unAuthorizedRequest'] != null) {
		data.unAuthorizedRequest = json['unAuthorizedRequest'];
	}
	if (json['__abp'] != null) {
		data.bAbp = json['__abp'];
	}
	return data;
}

Map<String, dynamic> getRecommendsEntityToJson(GetRecommendsEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.result != null) {
		data['result'] =  entity.result.map((v) => v.toJson()).toList();
	}
	data['targetUrl'] = entity.targetUrl;
	data['success'] = entity.success;
	data['error'] = entity.error;
	data['unAuthorizedRequest'] = entity.unAuthorizedRequest;
	data['__abp'] = entity.bAbp;
	return data;
}

getRecommandsResultFromJson(GetRecommandsResult data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if (json['userId'] != null) {
		data.userId = json['userId']?.toInt();
	}
	if (json['nickName'] != null) {
		data.nickName = json['nickName']?.toString();
	}
	if (json['avatarUrl'] != null) {
		data.avatarUrl = json['avatarUrl']?.toString();
	}
	if (json['date'] != null) {
		data.date = json['date']?.toString();
	}
	if (json['images'] != null) {
		data.images = json['images']?.map((v) => v?.toString())?.toList()?.cast<String>();
	}
	if (json['visitNum'] != null) {
		data.visitNum = json['visitNum']?.toInt();
	}
	if (json['likeNum'] != null) {
		data.likeNum = json['likeNum']?.toInt();
	}
	if (json['commentNum'] != null) {
		data.commentNum = json['commentNum']?.toInt();
	}
	if (json['isLike'] != null) {
		data.isLike = json['isLike'];
	}
	if (json['isFollow'] != null) {
		data.isFollow = json['isFollow'];
	}
	if (json['contentType'] != null) {
		data.contentType = json['contentType']?.toInt();
	}
	if (json['isMyself'] != null) {
		data.isMyself = json['isMyself'];
	}
	if (json['duration'] != null) {
		data.duration = json['duration']?.toInt();
	}
	return data;
}

Map<String, dynamic> getRecommandsResultToJson(GetRecommandsResult entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['title'] = entity.title;
	data['userId'] = entity.userId;
	data['nickName'] = entity.nickName;
	data['avatarUrl'] = entity.avatarUrl;
	data['date'] = entity.date;
	data['images'] = entity.images;
	data['visitNum'] = entity.visitNum;
	data['likeNum'] = entity.likeNum;
	data['commentNum'] = entity.commentNum;
	data['isLike'] = entity.isLike;
	data['isFollow'] = entity.isFollow;
	data['contentType'] = entity.contentType;
	data['isMyself'] = entity.isMyself;
	data['duration'] = entity.duration;
	return data;
}