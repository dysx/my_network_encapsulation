import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_network_encapsulation/network/intercept/dio_connectivity_request_retrier%20.dart';

/// 重试拦截器，实现网络变化，继续请求
class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({required this.requestRetrier});

  @override
  Future onError(DioError err,ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      print('网络错误可以重连');
      try {
        return requestRetrier.scheduleRequestRetry(err.requestOptions,handler);
      } catch (e) {
        return e;
      }
    }
    print('网络错误不可以重连');
    return err;
  }

  bool _shouldRetry(DioError err) {
    print(
        '是否可以重试：${err.type == DioErrorType.other && err.error != null && err.error is SocketException}');
    String errorType = '';
    if(err.message.length>=15){
      String errorType = err.message.substring(0, 15);
    }
    /// 网络错误
    bool canRetry = err.type == DioErrorType.other &&
            err.error != null &&
            errorType == 'SocketException'
        ? true
        : false;
    return canRetry;
    // return err.type == DioErrorType.DEFAULT &&
    //     err.error != null &&
    //     err.error is SocketException;
  }
}
