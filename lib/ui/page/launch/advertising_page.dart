import 'dart:async';

import 'package:my_network_encapsulation/base/base_insert.dart';

///@name: 广告页
class AdvertisingPage extends BaseWidget {

  @override
  BaseWidgetState<BaseWidget> getState() => AdvertisingPageState();

}

class AdvertisingPageState extends BaseWidgetState<AdvertisingPage> {

  @override
  Widget buildWidget(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: LocalImageSelector.getImgByPhysicalSize("startup_page"),
    );
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
    setTopBarVisible(false);
    setAppBarVisible(false);

    startTime();
  }

  @override
  void onPause() {
    // TODO: implement onPause
  }

  @override
  void onResume() {
    // TODO: implement onResume
  }

  startTime() async {
    //设置启动图生效时间
    Duration _duration = new Duration(seconds: 2);
    return new Timer(_duration, _gotoHome);
  }

  void _gotoHome() {
    MyNavigator.pushNamedAndRemoveUntil(RouteName.home);
  }
}