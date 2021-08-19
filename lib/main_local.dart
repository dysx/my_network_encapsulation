import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_network_encapsulation/app.dart';
import 'package:my_network_encapsulation/config/domain_config.dart';
import 'package:my_network_encapsulation/network/address.dart';
import 'package:my_network_encapsulation/util/image/local_image_selector.dart';
import 'package:my_network_encapsulation/util/local_storage.dart';
import 'package:my_network_encapsulation/util/size_util.dart';

void main() async {
  /// 确保初始化
  WidgetsFlutterBinding.ensureInitialized();

  /// 存储初始化
  await LocalStorage.getInstance();

  /// 适配初始化
  SizeUtil.initialize();

  /// 静态图片初始化
  LocalImageSelector.init();

  /// 设置头部导航栏的透明
  SystemUiOverlayStyle systemUiOverlayStyle =
  SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  Address.setBaseUrl(DomainConfig.getBaseUrl(Domain.Local));

  runApp(MyApp());
}
