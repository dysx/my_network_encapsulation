import 'dart:async';
import 'dart:convert';

import 'package:my_network_encapsulation/generated/json/base/json_convert_content.dart';

/// 数据解析
class ApiFullTransform<T> {
  Completer<T> publishSubject;

  void add(T data) {
    publishSubject.complete(data);
  }

}
