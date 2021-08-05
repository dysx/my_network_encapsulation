

import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/routes/my_navigator.dart';

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
      child: ordinaryButton(
        onPressed: (){
          MyNavigator.pushNamedAndRemoveUntil(RouteName.home);
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
