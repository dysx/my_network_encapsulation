import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/base/base_inner_widget.dart';
import 'package:my_network_encapsulation/generated/l10n.dart';
import 'package:my_network_encapsulation/network/request_util.dart';
import 'package:my_network_encapsulation/res/my_commons.dart';
import 'package:my_network_encapsulation/routes/navigater.dart';
import 'package:my_network_encapsulation/routes/router_manger.dart';
import 'package:my_network_encapsulation/ui/common/button/outlined_button.dart';
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
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 0,
      // ),
      body: Container(
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
                        aaa += 1;
                        setState(() {

                        });
                      },
                      text: '$aaa'),
                  MyOutlinedButton(
                      onPressed: () {
                        print("${LocalStorage.get(MyCommons.TOKEN)}");
                        RequestUtil.login('15015802692', 'qds123123')
                            .then((value) {
                          LocalStorage.save(
                              MyCommons.TOKEN, value.accessToken);
                        });
                      },
                      text: '登陆'),
                  MyOutlinedButton(
                      onPressed: () {
                        RequestUtil.getRecommends(1, 20).then((value) {

                        });
                        // RequestUtil.subscribeKey().then((value) {
                        //   print("结果值:${value}");
                        // });
                      },
                      text: '获取列表'),
                  MyOutlinedButton(
                      onPressed: () {
                        RequestUtil.getTime();
                      },
                      text: '获取时间'),
                  MyOutlinedButton(
                      onPressed: () {
                        RequestUtil.getTime().then((value) {
                          print('请求结束,打印结果: ${value.sysTime2}');
                        });
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
                      LocalStorage.save(MyCommons.TOKEN, '123');
                    },
                    text: "存储token",
                  ),
                  MyOutlinedButton(
                    onPressed: () {
                      Toast.showMsg(LocalStorage.get(MyCommons.TOKEN));
                      // Toast.showWidget(widget);
                    },
                    text: "打印token",
                  ),
                  MyOutlinedButton(
                    onPressed: () {
                      LocalStorage.remove(MyCommons.TOKEN);
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
            ],
          ),
        ),
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
    // TODO: implement onResume
  }

  @override
  double getVerticalMargin() => 0;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
