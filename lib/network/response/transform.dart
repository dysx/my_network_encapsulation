import 'dart:async';

import 'package:dio/dio.dart';
import 'package:my_network_encapsulation/generated/json/base/json_convert_content.dart';

/// @describe: 数据解析
/// @author: qds
/// @date:
class TransformJson<T> {
  Future<T> jsonConvert<T>(Response response) async {
    return JsonConvert.fromJsonAsT<T>(response.data);
  }

  Future<T> jsonConvertResult<T>(Response response) async {
    return JsonConvert.fromJsonAsT<T>(response.data['result']);
  }
}
