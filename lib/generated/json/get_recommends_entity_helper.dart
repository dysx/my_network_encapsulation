import 'package:my_network_encapsulation/network/model/get_recommends_entity.dart';

getRecommendsEntityFromJson(GetRecommendsEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'];
	}
	if (json['title'] != null) {
		data.title = json['title'];
	}
	if (json['userId'] != null) {
		data.userId = json['userId'];
	}
	if (json['nickName'] != null) {
		data.nickName = json['nickName'];
	}
	if (json['avatarUrl'] != null) {
		data.avatarUrl = json['avatarUrl'];
	}
	if (json['date'] != null) {
		data.date = json['date'];
	}
	if (json['images'] != null) {
		data.images = (json['images'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['visitNum'] != null) {
		data.visitNum = json['visitNum'];
	}
	if (json['likeNum'] != null) {
		data.likeNum = json['likeNum'];
	}
	if (json['commentNum'] != null) {
		data.commentNum = json['commentNum'];
	}
	if (json['isLike'] != null) {
		data.isLike = json['isLike'];
	}
	if (json['isFollow'] != null) {
		data.isFollow = json['isFollow'];
	}
	if (json['contentType'] != null) {
		data.contentType = json['contentType'];
	}
	if (json['isMyself'] != null) {
		data.isMyself = json['isMyself'];
	}
	if (json['duration'] != null) {
		data.duration = json['duration'];
	}
	return data;
}

Map<String, dynamic> getRecommendsEntityToJson(GetRecommendsEntity entity) {
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