import 'dart:convert';

import 'package:my_network_encapsulation/generated/json/base/json_convert_content.dart';

/// 数据解析
class ApiFullTransform<T> {
  void apply({String, data, bool isShowErrorToast}) {
    JsonConvert.fromJsonAsT<T>(json.decode(data)['result']);
  }
}
