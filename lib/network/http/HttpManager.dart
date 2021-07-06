// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:dio/adapter.dart';
// import 'package:dio/dio.dart';
// import 'package:lte_router/base/base_widget/BasePage.dart';
// import 'package:lte_router/generated/get_dhcp_info_entity.dart';
// import 'package:lte_router/generated/get_network_info_entity.dart';
// import 'package:lte_router/generated/json/base/json_convert_content.dart';
// import 'package:lte_router/http/Intercept.dart';
//
// class HttpManager {
//
//   static const CONTENT_TYPE_JSON = "application/json";
//   static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
//   static final Dio _dio = Dio();
//   static final int CONNECR_TIME_OUT = 30000;
//   static final int RECIVE_TIME_OUT = 5000;
//
//   HttpManager._internal() {
//     initDio();
//   }
//
//   static HttpManager _httpManager = HttpManager._internal();
//
//   factory HttpManager() {
//     return _httpManager;
//   }
//
//   void initDio() {
//     _dio.options.baseUrl = "";
//     _dio.options.connectTimeout = CONNECR_TIME_OUT;
//
//     // _dio.options.contentType = "application/json";
//     // 添加拦截器
//     _dio.interceptors.add(Intercept());
//
//
//     (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//        (client) {
//          // 设置代理 config the http client
//          // client.findProxy = (uri) {
//          //   return "PROXY 192.168.31.23:8888";
//          // };
//
//          // client.badCertificateCallback =
//          //     (X509Certificate cert, String host, int port) {
//          //   return true; //返回 true 表明 忽略 证书校验
//          // };
//        };
//   }
//
//
//
//   Future<T> request<T>(RequestType type, String url, {Map queryParameters,
//     FormData formData, BasePageState basePageState,
//     Function onSendProgress
//   }){
//
//     Future future;
//     Completer<T> completer = new Completer();
//
//     if(basePageState != null){
//       basePageState.doLoading();
//     }
//
//     try {
//
//       switch(type){
//         case RequestType.GET:
//           future = _dio.get(url, queryParameters: queryParameters);
//           break;
//         case RequestType.POST:
//           future = _dio.post(url, data: queryParameters);
//           break;
//         case RequestType.UPLOAD:
//           future = _dio.post(url, data: formData, onSendProgress: onSendProgress);
//       }
//
//     } on DioError catch (e) {
//       print('--------- catch DioError ---------');
//       print("发生错误：$e");
//       print('请求url: ' + url);
//       if (queryParameters != null) {
//         print('请求参数: ' + queryParameters.toString());
//       }
//       _errorHandle(e, completer);
//       if(basePageState != null){
//         basePageState.cancelLoading();
//       }
//     }
//
//     future.then((data) {
//       // FlutterJsonBeanFactory工具，将请求回来的json转为map后转为传入的数据类型T
//       completer.complete(JsonConvert.fromJsonAsT<T>(json.decode(data.toString())));
//
//       print('请求成功: ');
//       print('返回结果: $data');
//
//       if(basePageState != null){
//         basePageState.cancelLoading();
//       }
//
//     }).catchError((err) {
//
//       print('------- future catchError --------');
//       print('输出error: $err');
//       print('请求url: ' + url);
//       if (queryParameters != null) {
//         print('请求参数: ' + queryParameters.toString());
//       }
//       if(basePageState != null){
//         basePageState.cancelLoading();
//       }
//       _errorHandle(err, completer);
//
//
//     });
//
//     return completer.future;
//   }
//
//
//   void _errorHandle(DioError err, Completer completer) {
//
//     if (err.type == DioErrorType.cancel) {
//       print("---请求取消---");
//
//     } else if (err.type == DioErrorType.connectTimeout ||
//         err.type == DioErrorType.receiveTimeout) {
//
//       completer.completeError(MyError(400, '连接超时'));
//
//     } else if (err.type == DioErrorType.other) {
//
//       print('http doError 中获取到DioErrorType.other 类型错误: $err');
//       completer.completeError(MyError(0, '$err'));
//
//     } else if (err.type == DioErrorType.response) {
//
//       int errorCode = err.response.statusCode; //返回错误码
//       if(errorCode == 401) {
//
//         completer.completeError(MyError(401, '没有权限'));
//
//       } else if(errorCode == 403) {
//
//         completer.completeError(MyError(401, err.toString()));
//
//       } else if (errorCode == 404) {
//
//         completer.completeError(MyError(401, "找不到网络资源"));
//
//       } else if (errorCode == 500) {
//
//         completer.completeError(MyError(500, err.toString()));
//
//       } else {
//         completer.completeError(MyError(errorCode, err.toString()));
//       }
//     }
//
//
//
//   }
// }
//
// class MyError {
//   int errorCode;
//   String desc;
//   MyError(this.errorCode, this.desc);
// }
//
// enum RequestType {
//   GET,
//   POST,
//   UPLOAD
// }