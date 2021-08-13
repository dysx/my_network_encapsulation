import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_network_encapsulation/config/appConfig.dart';
import 'package:my_network_encapsulation/util/local_storage.dart';
import 'package:my_network_encapsulation/util/log_utils.dart';

/// @describe: 网络缓存拦截器
/// @author: qds
/// @date:
class NetCacheInterceptor extends Interceptor {
  // 为确保迭代器顺序和对象插入时间一直顺序一致，我们使用LinkedHashMap
  var cache = LinkedHashMap<String, CacheObject>();

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    Log.d("缓存拦截器");

    // TODO: implement onRequest
    // 如果不启用缓存，则直接返回
    if (!AppConfig.CACHE_ENABLE) {
      // Alert.hide();
      return super.onRequest(options, handler);
    }

    // [refresh]标记是否刷新缓存
    bool refresh = options.extra['refresh'] == true;

    // 是否磁盘缓存
    bool cacheDisk = options.extra['cacheDisk'] == true;

    // 如果刷新，先删除相关缓存
    if (refresh) {
      debugPrint('刷新，先删除相关缓存');
      // 删除uri相同的内存缓存
      delete(options.uri.toString());

      // 删除磁盘缓存
      if (cacheDisk) {
        await LocalStorage.remove(options.uri.toString());
      }
      // Alert.hide();
      return super.onRequest(options, handler);
    }

    // get 请求，开启缓存
    // [noCache] 如果为true，本次请求禁用缓存，请求结果也不会被缓存。
    if (options.extra['noCache'] != true &&
        options.method.toLowerCase() == 'get') {
      print('get 请求，开启缓存');
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      print(key);
      // 策略 1 内存缓存优先，2 然后才是磁盘缓存

      // 1 内存缓存
      var ob = cache[key];
      if (ob != null) {
        print('内存缓存');
        // 若缓存未过期，则返回缓存内容
        if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) / 1000 <
            AppConfig.CACHE_MAXAGE) {
          debugPrint('若缓存未过期，则返回缓存内容');
          print('缓存当前$key的结果: ${cache[key]!.response}');
          // Alert.hide();
          return handler.resolve(cache[key]!.response);
          // return cache[key].response;
        } else {
          debugPrint('若已过期则删除缓存，继续向服务器请求');
          // 若已过期则删除缓存，继续向服务器请求
          cache.remove(key);
        }
      }

      // 2 磁盘缓存
      if (cacheDisk) {
        print('磁盘缓存');
        var cacheData = LocalStorage.get(key);
        if (cacheData != null) {
          // Alert.hide();
          return handler.resolve(Response(
              statusCode: 200, data: cacheData, requestOptions: options));
        }
      }
    }
    // Alert.hide();
    return super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) async {
    debugPrint('+++++++++++++++++++++++++++\n onResponse缓存结果');
    // debugPrint('onResponse缓存结果data: ${response.data}');
    // debugPrint('000000000000000000000000000');
    // 如果启用缓存，将返回结果保存到缓存
    if (AppConfig.CACHE_ENABLE) {
      await _saveCache(response);
    }

    debugPrint('+++++++++++++++++++++++++++\n');
    return super.onResponse(response, handler);
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) async {
    // 错误状态不缓存
    debugPrint(
        "=========================== 错误状态不缓存 ===========================");
    debugPrint("===========================\n");
  }

  Future<void> _saveCache(Response object) async {
    RequestOptions options = object.requestOptions;

    // 只缓存 get 的请求
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
      // 策略：内存、磁盘都写缓存

      // 缓存key
      String key = options.extra["cacheKey"] ?? options.uri.toString();

      // 磁盘缓存
      if (options.extra["cacheDisk"] == true) {
        await LocalStorage.save(key, object.data);
      }

      // 内存缓存
      // 如果缓存数量超过最大数量限制，则先移除最早的一条记录
      if (cache.length == AppConfig.CACHE_MAXCOUNT) {
        cache.remove(cache[cache.keys.first]);
      }

      cache[key] = CacheObject(object);
    }
  }

  void delete(String key) {
    cache.remove(key);
  }
}

class CacheObject {
  CacheObject(this.response)
      : timeStamp = DateTime.now().millisecondsSinceEpoch;
  Response response;

  /// create cache time
  int timeStamp;

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  /// 将请求uri作为缓存key
  @override
  int get hashCode => response.realUri.hashCode;
}
