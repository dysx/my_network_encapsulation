
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_network_encapsulation/config/application.dart';
import 'package:my_network_encapsulation/config/global.dart';
import 'package:my_network_encapsulation/alert/alert.dart';
import 'package:my_network_encapsulation/network/app_exception.dart';
import 'package:my_network_encapsulation/routes/router_manger.dart';

/// 请求拦截
class RequestInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    // HttpUtils.setHeaders({
    //   "Authorization": "Bearer ${Global.accessToken}",
    //   "Access-Token": "${Global.accessToken}"
    // });
    options.headers.addAll({
      "Authorization": "Bearer ${Global.accessToken}",
      "Access-Token": "${Global.accessToken}"
    });

    debugPrint('===========================\n*** 请求拦截器onRequest ***');
    debugPrint('请求method:${options.method}');
    debugPrint('请求data:${options.data.toString()}');
    debugPrint('请求query:${options.queryParameters}');
    debugPrint('请求path:${options.path}');
    debugPrint('请求header:${options.headers}');

    print('网络是否可用：${Application.haveNetWork}');

    Alert.showLoading();
    debugPrint('===========================\n');
    return super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    debugPrint('+++++++++++++++++++++++++++\n*** 请求返回onResponse ***');
    // debugPrint('响应Data:${response.data.toString()}');
    debugPrint('+++++++++++++++++++++++++++\n');
    Alert.hide();

    return super.onResponse(response, handler);
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    debugPrint('###########################\n*** 错误处理onError ***');
    debugPrint('err:$err');
    debugPrint('###########################\n');
    if ((err.type == DioErrorType.other &&
        err.error != null &&
        err.message.substring(0, 15) == 'SocketException')) {
      // 网络错误类型  关闭loading框
      Alert.hide();
      err.error = BadAppException(-1, "网络错误");
    }
    // 登陆失效处理 统一跳回登陆页
    // if (true) {
    //   Application.globalKey.currentState.pushNamed(RouteName.login);
    // }
    // else if (err.response.data != null) {
    //   print('==================');
    //   print(err.response.data);
    //   print(err.response.statusCode);
    //   print(err.response.statusMessage);
    //   Alert.hide();
    //   print('展示后台定义的错误message');
    //   /// 展示后台定义的错误message
    //   Alert.showAlert(
    //       message: err.response.data['error']['message'] ?? '未知错误',
    //       showCancel: false);
    // }
    else{
      // [RequestException] 自定义的异常
      AppException requestException = AppException.create(err);
      err.error = requestException;
    }
    print("错误信息: ${err.message}");
    Alert.hide();
    Alert.showAlert(message: err.message ?? '未知错误',showCancel: false);
    return super.onError(err, handler);
  }
}
