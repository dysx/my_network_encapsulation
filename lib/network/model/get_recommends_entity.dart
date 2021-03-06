import 'package:my_network_encapsulation/generated/json/base/json_convert_content.dart';
import 'package:my_network_encapsulation/generated/json/base/json_field.dart';

class GetRecommendsEntity with JsonConvert<GetRecommendsEntity> {
	int? id;
	String? title;
	int? userId;
	String? nickName;
	String? avatarUrl;
	String? date;
	List<String>? images;
	int? visitNum;
	int? likeNum;
	int? commentNum;
	bool? isLike;
	bool? isFollow;
	int? contentType;
	bool? isMyself;
	int? duration;
	bool collect = false;
}
