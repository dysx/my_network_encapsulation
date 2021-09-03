import 'dart:async';

import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/util/im/tencent_im.dart';

/// @describe: 启动页
/// @author: qds
/// @date:
class StartupPage extends BaseWidget {
  @override
  BaseWidgetState<BaseWidget> getState() => StartupPageState();
}

class StartupPageState extends BaseWidgetState<StartupPage> {
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
    // init();
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
    // 设置启动图生效时间
    Duration _duration = new Duration(seconds: 2);
    return new Timer(_duration, _gotoHome);
  }

  void _gotoHome() {
    MyNavigator.pushNamedAndRemoveUntil(RouteName.home);
  }

  /// 初始化环信im
  void _initIM() async {
    // EMOptions options = EMOptions(appKey: '1100210823200008#demo');
    // EMPushConfig config = EMPushConfig();
    // //配置推送消息
    // config
    //   ..enableAPNs('chatdemoui_dev')
    //   ..enableHWPush()
    //   ..enableFCM('')
    //   ..enableMeiZuPush('', '')
    //   ..enableMiPush('', '');
    // options.pushConfig = config;
    // await EMClient.getInstance.init(options);
    // EMClient.getInstance.addConnectionListener(this);
  }

  init() async {
    await TencentIm.initSDK();
  }

}
