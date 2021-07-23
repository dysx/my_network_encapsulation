import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/base/base_inner_widget.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/generated/l10n.dart';
import 'package:my_network_encapsulation/network/request_util.dart';
import 'package:my_network_encapsulation/res/my_colors.dart';
import 'package:my_network_encapsulation/res/my_commons.dart';
import 'package:my_network_encapsulation/routes/my_navigator.dart';
import 'package:my_network_encapsulation/routes/router_manger.dart';
import 'package:my_network_encapsulation/util/local_storage.dart';
import 'package:my_network_encapsulation/util/size_util.dart';
import 'package:my_network_encapsulation/util/toast.dart';
import 'package:my_network_encapsulation/view_model/locale_model.dart';
import 'package:my_network_encapsulation/view_model/theme_data_model.dart';
import 'package:provider/provider.dart';

/// @name：
/// @author qds
// ignore: must_be_immutable
class HomePage extends BaseInnerWidget {
  @override
  BaseInnerWidgetState<BaseInnerWidget> getState() => HomePageState();

  @override
  int setIndex() => 0;
}

class HomePageState extends BaseInnerWidgetState<HomePage> {
  int aaa = 0;

  @override
  Widget buildWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Wrap(
            spacing: 20,
            children: [
              ordinaryButton(
                  onPressed: () {
                    aaa += 1;
                    setState(() {});
                  },
                  text: '$aaa'),
              ordinaryButton(
                  onPressed: () {
                    LocalStorage.save(MyCommons.TOKEN, '123');
                    print("${LocalStorage.get(MyCommons.TOKEN)}");
                    RequestUtil.login('15015802692', 'qds123123',
                            cancelTag: 'HomePage')
                        .then((value) {
                      LocalStorage.save(MyCommons.TOKEN, value.accessToken);
                    });
                  },
                  text: '登陆'),
              ordinaryButton(
                  onPressed: () {
                    // RequestUtil.getRecommends(1, 20).then((value) {
                    //
                    // });
                    // RequestUtil.subscribeKey().then((value) {
                    //   print("结果值:${value}");
                    // });
                  },
                  text: '获取列表'),
              ordinaryButton(
                  onPressed: () {
                    RequestUtil.getTime();
                  },
                  text: '获取时间'),
              ordinaryButton(
                  onPressed: () {
                    RequestUtil.getTime().then((value) {
                      print('请求结束,打印结果: ${value.sysTime2}');
                    });
                  },
                  text: S.of(context).interfaceTest),
              ordinaryButton(
                onPressed: () {
                  Provider.of<LocaleModel>(context, listen: false)
                      .switchLocale(1);
                },
                text: '设置中文',
              ),
              ordinaryButton(
                onPressed: () {
                  Provider.of<LocaleModel>(context, listen: false)
                      .switchLocale(2);
                },
                text: '设置英文',
              ),
              ordinaryButton(
                onPressed: () {
                  Provider.of<LocaleModel>(context, listen: false)
                      .switchLocale(0);
                },
                text: '跟随系统',
              ),
              ordinaryButton(
                onPressed: () {
                  // print(Provider.of<ThemeDataModel>(context).myThemeData);
                  Provider.of<ThemeDataModel>(context, listen: false)
                      .switchTheme(0);
                },
                text: '亮色主题',
              ),
              ordinaryButton(
                onPressed: () {
                  Provider.of<ThemeDataModel>(context, listen: false)
                      .switchTheme(1);
                },
                text: '护眼模式主题',
              ),
              ordinaryButton(
                onPressed: () {
                  LocalStorage.save(MyCommons.TOKEN, '123');
                },
                text: "存储token",
              ),
              ordinaryButton(
                onPressed: () {
                  Toast.showMsg(LocalStorage.get(MyCommons.TOKEN));
                  // Toast.showWidget(widget);
                },
                text: "打印token",
              ),
              ordinaryButton(
                onPressed: () {
                  LocalStorage.remove(MyCommons.TOKEN);
                },
                text: "清除token",
              ),
              ordinaryButton(
                onPressed: () {
                  MyNavigator.pushNamed(RouteName.testA);
                },
                text: "测试popUntil路由",
              ),
              ordinaryButton(
                  onPressed: () {
                    MyNavigator.pushNamed(RouteName.scrollToIndex);
                  },
                  text: "滑动到指定位置",
                  sideColor: MyColors.black_3333),
              ordinaryButton(
                  onPressed: () async {
                    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
                    Map<String, dynamic> _deviceData = Map<String, dynamic>();
                    _deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
                    print(_deviceData);
                  },
                  text: "获取设备信息",
                  sideColor: MyColors.black_3333),
              Container(
                width: 375.w,
                height: 100,
                color: Colors.red,
              ),
              Container(
                width: 375.w,
                height: 100,
                color: Colors.red,
              ),
              Container(
                width: 375.w,
                height: 100,
                color: Colors.red,
              ),
              Container(
                width: 375.w,
                height: 100,
                color: Colors.red,
              ),
              Container(
                width: 375.w,
                height: 100,
                color: Colors.red,
              ),
              Container(
                width: 375.w,
                height: 100,
                color: Colors.red,
              ),
              Container(
                width: 375.w,
                height: 100,
                color: Colors.red,
              ),
              Text('000')
            ],
          ),
        ],
      ),
    );
  }

  @override
  void onCreate() {
    setTopBarVisible(true);
    setTopBarStyle(false);
    // setTopBarColor(Colors.red);
    setAppBarVisible(false);
  }

  @override
  void onPause() {}

  @override
  void onResume() {
    print('homepage继续');
  }

  @override
  double getVerticalMargin() => 0;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }
}
