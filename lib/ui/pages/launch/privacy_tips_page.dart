import 'dart:async';

import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/ui/pages/launch/widget/privacy_dialog.dart';

/// @describe: 隐私政策提示页
/// @author: qds
/// @date:
class PrivacyTipsPage extends BaseWidget {
  @override
  BaseWidgetState<BaseWidget> getState() => PrivacyTipsPageState();
}

class PrivacyTipsPageState extends BaseWidgetState<PrivacyTipsPage> {
  @override
  Widget buildWidget(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _showDialog();
      },
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: LocalImageSelector.getImgByPhysicalSize("startup_page"),
      ),
    );

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

    _showDialog();
  }

  @override
  void onPause() {
    // TODO: implement onPause
  }

  @override
  void onResume() {
    // TODO: implement onResume
  }

  ///隐私政策弹框
  _showDialog() {
    Future.delayed(Duration(seconds: 1), () {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return PrivacyDialog();
          });
      // Alert.showAlert(
      //   title: '服务条款和隐私政策提示',
      //   message: '欢迎使用...！',
      //     showCancel: true,
      // );
    });
  }

  void _gotoHome() {
    MyNavigator.pushNamedAndRemoveUntil(RouteName.home);
  }
}
