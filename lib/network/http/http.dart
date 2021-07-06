import 'dart:async';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:my_network_encapsulation/config/cache.dart';
import 'package:my_network_encapsulation/config/proxy.dart';
import 'package:my_network_encapsulation/network/intercept/request_interceptor.dart';
import 'package:my_network_encapsulation/network/response/transform.dart';
import 'package:my_network_encapsulation/res/my_commons.dart';
import 'package:my_network_encapsulation/util/local_storage.dart';
import 'package:my_network_encapsulation/util/log_utils.dart';

/// http请求
class Http {
  /// 超时时间 毫秒
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 5000;

  Dio dio;
  CancelToken _cancelToken = CancelToken();

  /// 单例模式
  /// 单例公开访问点
  factory Http() => _instance;

  /// 静态私有成员
  static Http _instance = Http._internal();

  /// 私有构造函数
  /// 具体初始化
  Http._internal() {
    if (dio == null) {
      // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
      BaseOptions options = new BaseOptions(
          connectTimeout: CONNECT_TIMEOUT,
          // 响应流上 前后两次接受到数据的间隔，单位为毫秒
          receiveTimeout: RECEIVE_TIMEOUT,
          // Http请求头
          headers: {});

      dio = new Dio(options);

      // 添加请求拦截器
      dio.interceptors.add(RequestInterceptor());

      // 添加内存缓存
      // dio.interceptors.add(NetCacheInterceptor());

      // if(Global.retryEnable){
      //   // 加网络监听拦截器
      //   dio.interceptors.add(
      //     RetryOnConnectionChangeInterceptor(
      //       requestRetrier: DioConnectivityRequestRetrier(
      //         dio: dio,
      //         connectivity: Connectivity()
      //       )
      //     )
      //   );
      // }

      // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
      if (PROXY_ENABLE) {
        (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
            (client) {
          // client.findProxy = (uri) {
          //   // return "PROXY $PROXY_IP:$PROXY_PORT";
          //   return "PROXY 192.168.168.254:8888";
          // };
          // 代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
        };
      }
    }
  }

  /// 初始化公共属性
  ///
  /// [baseUrl] 地址前缀
  /// [connectTimeOut] 连接超时时间
  /// [receiveTimeOut] 接收超时时间
  void init(
      {String baseUrl,
      int connectTimeOut,
      int receiveTimeOut,
      List<Interceptor> interceptors}) {
    dio.options = dio.options.copyWith(
        baseUrl: baseUrl,
        connectTimeout: connectTimeOut,
        receiveTimeout: receiveTimeOut);
    if (interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }
  }

  /// 设置headers
  void setHeaders(Map<String, dynamic> map) {
    dio.options.headers.addAll(map);
  }

  /*
  * 取消请求
  *
  * 同一个cancel token 可用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
  * 所以参数可选
  */
  void cancelRequests({CancelToken cancelToken}) {
    // Log.d("${_cancelToken.hashCode}");
    // Log.d("取消网络请求");
    // cancelToken ?? _cancelToken.cancel("用户取消了");
  }

  /// 读取本地配置  设置token
  Map<String, dynamic> getAuthorizationHeader() {
    var headers;
    String accessToken = LocalStorage.get(MyCommons.TOKEN) ?? null;
    if (accessToken != null) {
      headers = {
        "Authorization": 'Bearer $accessToken',
        "Access-Token": '$accessToken'
      };
    }
    return headers;
  }

  /// ----------------------- restful -------------------------
  /*
     [params]       get 请求参数
     [data]         post请求参数
     [options]      requestOptions
     [cancelToken]  取消请求cancelToken
     // 缓存
     [refresh]      refresh标记是否是"下拉刷新"
     [noCache]      是否缓存
     [cacheKey]     缓存key
     [cacheDisk]    是否是磁盘缓存
  */
  Future<T> get<T>(
    String path, {
    Map<String, dynamic> params,
    Options options,
    CancelToken cancelToken,
    bool refresh = false,
    bool noCache = !CACHE_ENABLE,
    String cacheKey,
    bool cacheDisk = false,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(extra: {
      "refresh": refresh,
      "noCache": noCache,
      "cacheKey": cacheKey,
      "cacheDisk": cacheDisk,
    });
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }

    Future future;
    Completer<T> completer = Completer();

    try {
      future = dio.get(path,
          queryParameters: params,
          options: requestOptions,
          cancelToken: cancelToken ?? _cancelToken);
    } on DioError catch (e) {
      Log.e('------- dio catchError --------');
      completer.completeError(e);
    }
    future.then((data){
      completer.complete(TransformJson().jsonConvertResult(data));
    }).catchError((err){
      Log.e("------- future catchError --------");
      completer.completeError(err);
    });

    return completer.future;
  }

  /// restful post 操作
  Future<T> post<T>(
    String path, {
    data,
    Options options,
    CancelToken cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }

    Future future;
    Completer<T> completer = Completer();

    try {
      future = dio.post(path,
          data: data,
          options: requestOptions,
          cancelToken: cancelToken ?? _cancelToken);
    } on DioError catch (e) {
      Log.e('------- dio catchError --------');
      completer.completeError(e);
    }
    future.then((data){
      completer.complete(TransformJson().jsonConvertResult(data));
    }).catchError((err){
      Log.e("------- future catchError --------");
      completer.completeError(err);
    });

    return completer.future;
  }

  /// restful put 操作
  Future<T> put<T>(
    String path, {
    data,
    Map<String, dynamic> params,
    Options options,
    CancelToken cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }

    Future future;
    Completer<T> completer = Completer();

    try {
      future = dio.put(path,
          queryParameters: params,
          options: requestOptions,
          cancelToken: cancelToken ?? _cancelToken);
    } on DioError catch (e) {
      Log.e('------- dio catchError --------');
      completer.completeError(e);
    }
    future.then((data){
      completer.complete(TransformJson().jsonConvertResult(data));
    }).catchError((err){
      Log.e("------- future catchError --------");
      completer.completeError(err);
    });

    return completer.future;
  }

  /// restful patch 操作
  Future<T> patch<T>(
    String path, {
    data,
    Map<String, dynamic> params,
    Options options,
    CancelToken cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }

    Future future;
    Completer<T> completer = Completer();

    try {
      future = dio.patch(path,
          queryParameters: params,
          options: requestOptions,
          cancelToken: cancelToken ?? _cancelToken);
    } on DioError catch (e) {
      Log.e('------- dio catchError --------');
      completer.completeError(e);
    }
    future.then((data){
      completer.complete(TransformJson().jsonConvertResult(data));
    }).catchError((err){
      Log.e("------- future catchError --------");
      completer.completeError(err);
    });

    return completer.future;
  }

  /// restful delete 操作
  Future<T> delete<T>(
    String path, {
    data,
    Map<String, dynamic> params,
    Options options,
    CancelToken cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }

    Future future;
    Completer<T> completer = Completer();

    try {
      future = dio.delete(path,
          data: data,
          queryParameters: params,
          options: requestOptions,
          cancelToken: cancelToken ?? _cancelToken);
    } on DioError catch (e) {
      Log.e('------- dio catchError --------');
      completer.completeError(e);
    }
    future.then((data){
      completer.complete(TransformJson().jsonConvertResult(data));
    }).catchError((err){
      Log.e("------- future catchError --------");
      completer.completeError(err);
    });

    return completer.future;
  }

  /// restful post form 表单提交操作
  Future<T> postForm<T>(
    String path, {
    Map<String, dynamic> params,
    Options options,
    CancelToken cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var data = FormData.fromMap(params);
    Log.d('${data.length}');

    Future future;
    Completer<T> completer = Completer();

    try {
      future = dio.post(path,
          data: data,
          options: requestOptions,
          cancelToken: cancelToken ?? _cancelToken);
    } on DioError catch (e) {
      Log.e('------- dio catchError --------');
      completer.completeError(e);
    }
    future.then((data){
      completer.complete(TransformJson().jsonConvertResult(data));
    }).catchError((err){
      Log.e("------- future catchError --------");
      completer.completeError(err);
    });

    return completer.future;
  }
}
