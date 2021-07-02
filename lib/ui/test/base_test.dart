
import 'package:flutter/cupertino.dart';
import 'package:my_network_encapsulation/base/base_widget.dart';
import 'package:my_network_encapsulation/routes/navigater.dart';
import 'package:my_network_encapsulation/routes/router_manger.dart';
import 'package:my_network_encapsulation/ui/common/button/outlined_button.dart';

/// @name：
/// @author qds
/// @date 2020/10/23
class BaseTest extends BaseWidget {

  @override
  BaseWidgetState<BaseWidget> getState() => new BaseTestState();
}

class BaseTestState extends BaseWidgetState<BaseTest> {
  ///api

  @override
  Widget buildWidget(BuildContext context) {
    return Center(
      child: MyOutlinedButton(
        onPressed: (){
          Navigater.pushNamedAndRemoveUntil(RouteName.home);
        },
        text: "测试路由",
      ),
    );
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
    setAppBarTitle('base测试');
    setTopBarVisible(false);
  }

  @override
  void onPause() {
    // TODO: implement onPause
  }

  @override
  void onResume() {
    // TODO: implement onResume
  }

}
