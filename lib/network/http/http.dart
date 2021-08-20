import 'dart:async';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:my_network_encapsulation/config/appConfig.dart';
import 'package:my_network_encapsulation/network/intercept/request_interceptor.dart';
import 'package:my_network_encapsulation/res/keys.dart';
import 'package:my_network_encapsulation/util/local_storage.dart';

/// @describe: http请求
/// @author: qds
/// @date:
class Http {
  /// 超时时间 毫秒
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 5000;

  late Dio dio;
  static Map<String, CancelToken> _cancelTokens = Map<String, CancelToken>();

  /// 单例模式
  /// 单例公开访问点
  factory Http() => _instance;

  /// 静态私有成员
  static Http _instance = Http._internal();

  /// 私有构造函数
  /// 具体初始化
  Http._internal() {
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
    if (AppConfig.PROXY_ENABLE) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY ${AppConfig.PROXY_IP}:${AppConfig.PROXY_PORT}";
        };
        // 代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  /// 初始化公共属性
  ///
  /// [baseUrl] 地址前缀
  /// [connectTimeOut] 连接超时时间
  /// [receiveTimeOut] 接收超时时间
  void init(
      {String? baseUrl,
      int? connectTimeOut,
      int? receiveTimeOut,
      List<Interceptor>? interceptors}) {
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

  /// 取消请求
  ///
  /// 同一个cancel token 可用于多个请求，当一个cancel token取消时
  /// 所有使用该cancel token的请求都会被取消。
  ///
  /// 传入页面名，关闭页面，取消所有当前页面的请求
  static void cancelHttp(String tag) {
    print("$tag页面取消网络请求");
    if (_cancelTokens.containsKey(tag)) {
      if (!_cancelTokens[tag]!.isCancelled) {
        _cancelTokens[tag]!.cancel();
      }
      _cancelTokens.remove(tag);
      print('+++++++++++++');
    }
  }

  /// 读取本地配置  设置token
  Map<String, dynamic> getAuthorizationHeader() {
    var headers;
    String accessToken = LocalStorage.get(Keys.token) ?? '';
    headers = {
      "Authorization": 'Bearer $accessToken',
      "Access-Token": '$accessToken'
    };
    return headers;
  }

  /// ----------------------- restful -------------------------
  /// [params]       get 请求参数
  /// [data]         post请求参数
  /// [options]      requestOptions
  /// [cancelTag]    取消请求页面名
  /// [cancelToken]  取消请求cancelToken
  /// 缓存
  /// [refresh]      refresh标记是否是"下拉刷新"
  /// [noCache]      是否缓存
  /// [cacheKey]     缓存key
  /// [cacheDisk]    是否是磁盘缓存
  Future get(String path,
      {Map<String, dynamic>? params,
      Options? options,
      required String cancelTag,
      CancelToken? cancelToken,
      bool refresh = false,
      bool noCache = !AppConfig.CACHE_ENABLE,
      String? cacheKey,
      bool cacheDisk = false}) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(extra: {
      "refresh": refresh,
      "noCache": noCache,
      "cacheKey": cacheKey,
      "cacheDisk": cacheDisk,
    });

    Map<String, dynamic> _authorization = getAuthorizationHeader();
    requestOptions = requestOptions.copyWith(headers: _authorization);

    CancelToken cancelToken;
    cancelToken = (_cancelTokens[cancelTag] == null
        ? CancelToken()
        : _cancelTokens[cancelTag])!;
    _cancelTokens[cancelTag] = cancelToken;

    print('89889889$cancelTag');
    return await dio.get(path,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken);
  }

  /// restful post 操作
  Future post(
    String path, {
    data,
    Options? options,
    required String cancelTag,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    requestOptions = requestOptions.copyWith(headers: _authorization);

    CancelToken cancelToken;
    cancelToken = (_cancelTokens[cancelTag] == null
        ? CancelToken()
        : _cancelTokens[cancelTag])!;
    _cancelTokens[cancelTag] = cancelToken;

    return await dio.post(path,
        data: data, options: requestOptions, cancelToken: cancelToken);
  }

  /// restful put 操作
  Future put(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    required String cancelTag,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    requestOptions = requestOptions.copyWith(headers: _authorization);

    CancelToken cancelToken;
    cancelToken = (_cancelTokens[cancelTag] == null
        ? CancelToken()
        : _cancelTokens[cancelTag])!;
    _cancelTokens[cancelTag] = cancelToken;

    return await dio.put(path,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken);
  }

  /// restful patch 操作
  Future patch(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    required String cancelTag,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    requestOptions = requestOptions.copyWith(headers: _authorization);

    CancelToken cancelToken;
    cancelToken = (_cancelTokens[cancelTag] == null
        ? CancelToken()
        : _cancelTokens[cancelTag])!;
    _cancelTokens[cancelTag] = cancelToken;

    return await dio.patch(path,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken);
  }

  /// restful delete 操作
  Future delete(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    required String cancelTag,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    requestOptions = requestOptions.copyWith(headers: _authorization);

    CancelToken cancelToken;
    cancelToken = (_cancelTokens[cancelTag] == null
        ? CancelToken()
        : _cancelTokens[cancelTag])!;
    _cancelTokens[cancelTag] = cancelToken;

    return await dio.delete(path,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken);
  }

  /// restful post form 表单提交操作
  Future postForm(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    required String cancelTag,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    requestOptions = requestOptions.copyWith(headers: _authorization);

    var data = FormData.fromMap(params!);

    CancelToken cancelToken;
    cancelToken = (_cancelTokens[cancelTag] == null
        ? CancelToken()
        : _cancelTokens[cancelTag])!;
    _cancelTokens[cancelTag] = cancelToken;

    return await dio.post(path,
        data: data, options: requestOptions, cancelToken: cancelToken);
  }
}
