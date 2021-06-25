
import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/alert/alert.dart';
import 'package:my_network_encapsulation/config/application.dart';
import 'package:my_network_encapsulation/generated/l10n.dart';
import 'package:my_network_encapsulation/network/request_util.dart';
import 'package:my_network_encapsulation/provider/locale_model.dart';
import 'package:my_network_encapsulation/provider/theme_data_model.dart';
import 'package:my_network_encapsulation/res/my_commons.dart';
import 'package:my_network_encapsulation/routes/router_manger.dart';
import 'package:my_network_encapsulation/ui/common/button/outlined_button.dart';
import 'package:my_network_encapsulation/util/local_storage.dart';
import 'package:my_network_encapsulation/util/size_util.dart';
import 'package:my_network_encapsulation/util/toast.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

/// @name：
/// @author qds

class HomePage extends StatefulWidget {

  HomePage({Key key}) : super(key: key);

  @override
  State createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Container(
          // color: Colors.red,
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Wrap(
                  spacing: 20,
                  children: [
                    MyOutlinedButton(
                        onPressed: () {

                          // bool b = true;
                          // bool a = b == true;
                          // print("a的值: $a");
                          // print("b的值: $b");

                          RequestUtil.getTime().then((value) {
                            print('请求结束,打印结果: ${value.sysTime2}');
                          });

                          // Alert.showLoading();

                          // RequestUtil.getRecommends(1, 20).then((res){
                          //   print("返回结果：$res");
                          //   print("${res.result[0].userId}");
                          // });
                          //
                          // RequestUtil.getRecommends(2, 20).then((res){
                          //   print("返回结果：$res");
                          //   print("${res.result[0].userId}");
                          // });

                          // print(MySpUtil().getJSON('https://app.lightencancer.cn/api/services/app/SearchService/GetRecommends?PageIndex=1&PageSize=20'));

                          // print("${NetCacheInterceptor().cache['https://app.lightencancer.cn/api/services/app/SearchService/GetRecommends?PageIndex=1&PageSize=20'].response}");

                          // /// 清空所有缓存
                          // NetCacheInterceptor().cache.clear();

                          // RequestUtil.login('15015802692', 'qds12345').then((res){
                          //   print("返回结果：$res");
                          // });

                          // RequestUtil.addFriend(22504).then((res){
                          //   print("返回结果：$res");
                          // });

                        },
                        text: S.of(context).interfaceTest
                    ),
                    MyOutlinedButton(
                      onPressed: (){
                        Alert.hide();
                      },
                      text: "Connection Status: $_connectionStatus",
                    ),
                    MyOutlinedButton(
                      onPressed: (){
                        Provider.of<LocaleModel>(context ,listen: false).switchLocale(1);
                      },
                      text: '设置中文',
                    ),
                    MyOutlinedButton(
                      onPressed: (){
                        Provider.of<LocaleModel>(context ,listen: false).switchLocale(2);
                      },
                      text: '设置英文',
                    ),
                    MyOutlinedButton(
                      onPressed: (){
                        Provider.of<LocaleModel>(context ,listen: false).switchLocale(0);
                      },
                      text: '跟随系统',
                    ),
                    MyOutlinedButton(
                      onPressed: (){
                        // print(Provider.of<ThemeDataModel>(context).myThemeData);
                        Provider.of<ThemeDataModel>(context,listen: false).switchTheme(0);
                      },
                      text: '亮色主题',
                    ),
                    MyOutlinedButton(
                      onPressed: (){
                        Provider.of<ThemeDataModel>(context,listen: false).switchTheme(1);
                      },
                      text: '护眼模式主题',
                    ),
                    MyOutlinedButton(
                      onPressed: (){
                        LocalStorage.save(MyCommons.TOKEN, '123');
                      },
                      text: "存储token",
                    ),
                    MyOutlinedButton(
                      onPressed: (){
                        Toast.showMsg(LocalStorage.get(MyCommons.TOKEN));
                        // Toast.showWidget(widget);
                      },
                      text: "打印token",
                    ),
                    MyOutlinedButton(
                      onPressed: (){
                        LocalStorage.remove(MyCommons.TOKEN);
                      },
                      text: "清除token",
                    )
                  ],
                ),
                Container(
                  color: Colors.red,
                  width: 50,
                  height: 50,
                ),
                Container(
                  color: Colors.blue,
                  width: 375,
                  height: 200.h,
                ),
                // BackdropFilter(
                //   filter: ImageFilter.blur(
                //     sigmaX: 1.0,
                //     sigmaY: 1.0
                //   ),
                //   child: Center(
                //     child: Image.network('https://up.enterdesk.com/edpic_source/29/30/5c/29305cdb4125ea2c813bac60326e5e13.jpg'),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          if(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile){
            Application.haveNetWork = true;
            debugPrint('网络可用：${Application.haveNetWork}');
          }else{
            Application.haveNetWork = false;
            debugPrint('网络不可用：${Application.haveNetWork}');
          }
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // //平台消息是异步的，所以我们用异步方法初始化。
  // Future<Null> initConnectivity() async {
  //   String connectionStatus;
  //   //平台消息可能会失败，因此我们使用Try/Catch PlatformException。
  //   try {
  //     connectionStatus = (await _connectivity.checkConnectivity()).toString();
  //   }  catch (e) {
  //     print(e.toString());
  //     connectionStatus = 'Failed to get connectivity.';
  //   }
  //
  //   // 如果在异步平台消息运行时从树中删除了该小部件，
  //   // 那么我们希望放弃回复，而不是调用setstate来更新我们不存在的外观。
  //   if (!mounted) {
  //     return;
  //   }
  //
  //   setState(() {
  //     _connectionStatus = connectionStatus;
  //   });
  // }
}