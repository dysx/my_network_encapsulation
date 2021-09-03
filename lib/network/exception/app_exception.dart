import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

/// @describe: 自定义异常
/// @author: qds
/// @date:
class AppException implements Exception {
  final String? _message;
  final int? _code;

  AppException([this._code, this._message]);

  String toString() {
    return "$_message";
    // return "$_message($_code)";
  }

  factory AppException.create(DioError error) {
    int errCode = error.response!.statusCode!;
    debugPrint('===============AppException===============');
    if (error.response!.data['unAuthorizedRequest']) {
      return UnauthorisedException(
          errCode, error.response!.data['error']['message']);
    } else {
      switch (error.type) {
        case DioErrorType.cancel:
          return BadAppException(-1, "请求取消");
        case DioErrorType.connectTimeout:
          return BadAppException(-1, "连接超时");
        case DioErrorType.sendTimeout:
          return BadAppException(-1, "请求超时");
        case DioErrorType.receiveTimeout:
          return BadAppException(-1, "响应超时");
        case DioErrorType.response:
          try {
            int errCode = error.response!.statusCode!;
            switch (errCode) {
              case 400:
                {
                  return BadAppException(errCode, "请求语法错误");
                }
              case 401:
                {
                  return UnauthorisedException(
                      errCode, error.response!.data['error']['message']);
                }
              default:
                {
                  return AppException(errCode, error.response!.statusMessage);
                }
            }
          } on Exception catch (_) {
            return AppException(-1, "未知错误");
          }
          break;
        default:
          return AppException(-1, error.message);
      }
    }
  }
}

/// 请求错误
class BadAppException extends AppException {
  BadAppException([int? code, String? message]) : super(code, message);
}

/// 未认证异常
class UnauthorisedException extends AppException {
  UnauthorisedException([int? code, String? message]) : super(code, message);
}

/// 接口的success没有返回true的异常
class NotSuccessException extends AppException {
  NotSuccessException([int? code, String? message]) : super(code, message);
}
