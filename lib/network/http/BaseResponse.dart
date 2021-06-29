
import 'package:my_network_encapsulation/network/http/constant.dart';

///@name: 数据解析的基础类
class BaseResponse <T> {

  T result;
  String targetUrl;
  bool success;
  var error;
  bool unAuthorizedRequest;
  bool abp;

  BaseResponse(this.result, this.targetUrl, this.success, this.error, this.unAuthorizedRequest, this.abp);

  BaseResponse.fromJson(Map<String, dynamic> json) {
    result = json[Constant.result];
    targetUrl = json[Constant.targetUrl];
    success = json[Constant.success];
    error = json[Constant.error];
    unAuthorizedRequest = json[Constant.unAuthorizedRequest];
    abp = json[Constant.abp];
  }

}