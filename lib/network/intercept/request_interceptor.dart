
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_network_encapsulation/config/application.dart';
import 'package:my_network_encapsulation/config/global.dart';
import 'package:my_network_encapsulation/alert/alert.dart';
import 'package:my_network_encapsulation/generated/json/base/json_convert_content.dart';
import 'package:my_network_encapsulation/network/exception/app_exception.dart';
import 'package:my_network_encapsulation/network/http/error_entity.dart';
import 'package:my_network_encapsulation/routes/router_manger.dart';
import 'package:my_network_encapsulation/util/log_utils.dart';

/// 请求拦截
class RequestInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    Log.d("*** 请求拦截器onRequest ***\n"
        "请求method:${options.method}\n"
        "请求data:${options.data.toString()}\n"
        "请求query:${options.queryParameters}\n"
        "请求path:${options.path}\n"
        "请求header:${options.headers}\n"
    );
    // Alert.showLoading();
    return super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    Log.d("*** 请求返回onResponse (这里暂不打印)***");
    // Log.d("*** 请求返回onResponse ***\n"
    //     "response:${response.data.toString()}");

    // Alert.hide();
    return super.onResponse(response, handler);
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    Log.e("*** 错误处理onError ***\n"
        "response:${err.response}");

    // Alert.hide();
    /// 网络错误
    if ((err.type == DioErrorType.other &&
        err.error != null &&
        err.message.substring(0, 15) == 'SocketException')) {
      err.error = BadAppException(-1, "网络错误");
      Alert.showAlert(message: err.message ?? '未知错误',showCancel: false);
      return super.onError(err, handler);
    }
    /// 登陆失效处理 统一跳回登陆页
    if (err.response.data['unAuthorizedRequest']) {
      Application.globalKey.currentState.pushNamed(RouteName.login, arguments: {'havePop': true});
      return super.onError(err, handler);
    }
    /// 展示后台定义的错误message
    if (err.response.data['error'] != null) {
      Alert.showAlert(
          message: err.response.data['error']['message'] ?? '未知错误',
          showCancel: false);
      return super.onError(err, handler);
    }
    /// [RequestException] 自定义的异常
    else{
      AppException requestException = AppException.create(err);
      err.error = requestException;
      Alert.showAlert(message: err.message ?? '未知错误',showCancel: false);
      return super.onError(err, handler);
    }
  }
}
