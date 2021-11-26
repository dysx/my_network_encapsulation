// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:my_network_encapsulation/network/model/time_entity.dart';
import 'package:my_network_encapsulation/generated/json/time_entity_helper.dart';
import 'package:my_network_encapsulation/network/model/get_recommends_entity.dart';
import 'package:my_network_encapsulation/generated/json/get_recommends_entity_helper.dart';
import 'package:my_network_encapsulation/network/model/login_entity.dart';
import 'package:my_network_encapsulation/generated/json/login_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {
			case TimeEntity:
				return timeEntityFromJson(data as TimeEntity, json) as T;
			case GetRecommendsEntity:
				return getRecommendsEntityFromJson(data as GetRecommendsEntity, json) as T;
			case LoginEntity:
				return loginEntityFromJson(data as LoginEntity, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case TimeEntity:
				return timeEntityToJson(data as TimeEntity);
			case GetRecommendsEntity:
				return getRecommendsEntityToJson(data as GetRecommendsEntity);
			case LoginEntity:
				return loginEntityToJson(data as LoginEntity);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (TimeEntity).toString()){
			return TimeEntity().fromJson(json);
		}	else if(type == (GetRecommendsEntity).toString()){
			return GetRecommendsEntity().fromJson(json);
		}	else if(type == (LoginEntity).toString()){
			return LoginEntity().fromJson(json);
		}	
		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(<TimeEntity>[] is M){
			return data.map<TimeEntity>((e) => TimeEntity().fromJson(e)).toList() as M;
		}	else if(<GetRecommendsEntity>[] is M){
			return data.map<GetRecommendsEntity>((e) => GetRecommendsEntity().fromJson(e)).toList() as M;
		}	else if(<LoginEntity>[] is M){
			return data.map<LoginEntity>((e) => LoginEntity().fromJson(e)).toList() as M;
		}
		throw Exception("not fond");
	}

  static M fromJsonAsT<M>(json) {
    if (json is List) {
      return _getListChildType<M>(json);
    } else {
      return _fromJsonSingle<M>(json) as M;
    }
  }
}