
import 'package:dio/dio.dart';
import 'package:my_network_encapsulation/config/appconfig.dart';
import 'package:my_network_encapsulation/network/http/http.dart';


/// http请求工具
class HttpUtils {

  static void init(
      {String? baseUrl,
      int? connectTimeout,
      int? receiveTimeout,
      List<Interceptor>? interceptors}) {
    Http().init(
      baseUrl: baseUrl,
      connectTimeOut: connectTimeout,
      receiveTimeOut: receiveTimeout,
      interceptors: interceptors
    );
  }

  static void setHeaders(Map<String,dynamic> map){
    Http().setHeaders(map);
  }

  static void cancelRequest({CancelToken? cancelToken}){
    Http().cancelRequests(cancelToken: cancelToken);
  }

  static Future<T> get<T>(
      String path, {
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
        bool refresh = false,
        bool noCache = !AppConfig.CACHE_ENABLE,
        String? cacheKey,
        bool cacheDisk = false,
      }) async {
    return await Http().get(
      path,
      params: params,
      options: options,
      cancelToken: cancelToken,
      refresh: refresh,
      noCache: noCache,
      cacheKey: cacheKey,
    );
  }

  static Future<T> post<T>(
      String path, {
        data,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    return await Http().post(
      path,
      data: data,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future<T> put<T>(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    return await Http().put(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future<T> patch<T>(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    return await Http().patch(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future<T> delete<T>(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    return await Http().delete(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future<T> postForm<T>(
      String path, {
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    return await Http().postForm(
      path,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }


}
