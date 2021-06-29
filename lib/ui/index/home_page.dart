
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/config/global.dart';
import 'package:my_network_encapsulation/generated/l10n.dart';
import 'package:my_network_encapsulation/network/request_util.dart';
import 'package:my_network_encapsulation/provider/locale_model.dart';
import 'package:my_network_encapsulation/provider/theme_data_model.dart';
import 'package:my_network_encapsulation/routes/navigater.dart';
import 'package:my_network_encapsulation/routes/router_manger.dart';
import 'package:my_network_encapsulation/ui/common/button/outlined_button.dart';
import 'package:my_network_encapsulation/util/local_image_selector.dart';
import 'package:my_network_encapsulation/util/local_storage.dart';
import 'package:my_network_encapsulation/util/size_util.dart';
import 'package:my_network_encapsulation/util/toast.dart';
import 'package:provider/provider.dart';

/// @name：
/// @author qds

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {

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
                          RequestUtil.login('15015802692', 'qds123456')
                              .then((value) {
                            // print(value.result.nickName);
                            LocalStorage.save(
                                Global.accessToken, value.result.accessToken);
                          });
                        },
                        text: '登陆'),
                    MyOutlinedButton(
                        onPressed: () {
                          RequestUtil.getRecommends(1, 20).then((value) {
                            // print(value.result);
                          });
                        },
                        text: '获取列表'),
                    MyOutlinedButton(
                        onPressed: () {
                          RequestUtil.getTime();
                        },
                        text: '获取时间'),
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
                        text: S.of(context).interfaceTest),
                    MyOutlinedButton(
                      onPressed: () {
                        Provider.of<LocaleModel>(context, listen: false)
                            .switchLocale(1);
                      },
                      text: '设置中文',
                    ),
                    MyOutlinedButton(
                      onPressed: () {
                        Provider.of<LocaleModel>(context, listen: false)
                            .switchLocale(2);
                      },
                      text: '设置英文',
                    ),
                    MyOutlinedButton(
                      onPressed: () {
                        Provider.of<LocaleModel>(context, listen: false)
                            .switchLocale(0);
                      },
                      text: '跟随系统',
                    ),
                    MyOutlinedButton(
                      onPressed: () {
                        // print(Provider.of<ThemeDataModel>(context).myThemeData);
                        Provider.of<ThemeDataModel>(context, listen: false)
                            .switchTheme(0);
                      },
                      text: '亮色主题',
                    ),
                    MyOutlinedButton(
                      onPressed: () {
                        Provider.of<ThemeDataModel>(context, listen: false)
                            .switchTheme(1);
                      },
                      text: '护眼模式主题',
                    ),
                    MyOutlinedButton(
                      onPressed: () {
                        LocalStorage.save(Global.accessToken, '123');
                      },
                      text: "存储token",
                    ),
                    MyOutlinedButton(
                      onPressed: () {
                        Toast.showMsg(LocalStorage.get(Global.accessToken));
                        // Toast.showWidget(widget);
                      },
                      text: "打印token",
                    ),
                    MyOutlinedButton(
                      onPressed: () {
                        LocalStorage.remove(Global.accessToken);
                      },
                      text: "清除token",
                    ),
                    MyOutlinedButton(
                      onPressed: () {
                        Navigater.pushNamed(RouteName.testA);
                      },
                      text: "测试popUntil路由",
                    )
                  ],
                ),
                Container(
                  color: Colors.red,
                  width: 50.w,
                  height: 50.w,
                ),
                Container(
                  color: Colors.blue,
                  width: 360.w,
                  height: 200.h,
                ),
                LocalImageSelector.getImage('add_add',
                    imageWidth: 30.w, imageHeight: 30.w),
                LocalImageSelector.getSingleImage('setting', type: '.png')
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
  }

  @override
  void dispose() {
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
