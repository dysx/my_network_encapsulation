import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

/// @describe: 网络错误重连
/// @author: qds
/// @date:
class DioConnectivityRequestRetry {
  final Dio dio;
  final Connectivity connectivity;

  DioConnectivityRequestRetry({
    required this.dio,
    required this.connectivity,
  });

  Future<Response> scheduleRequestRetry(
      RequestOptions requestOptions, ErrorInterceptorHandler handler) {
    late StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        streamSubscription.cancel();
        print('检查网络是否连接');
      } else if (connectivityResult != ConnectivityResult.none) {
        streamSubscription.cancel();
        responseCompleter.complete(dio.request(
          requestOptions.path,
          cancelToken: requestOptions.cancelToken,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
          onReceiveProgress: requestOptions.onReceiveProgress,
          onSendProgress: requestOptions.onSendProgress,
          // options: requestOptions
        ));
      }
    });

    print(responseCompleter.future);
    return responseCompleter.future;
  }
}
