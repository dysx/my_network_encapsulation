
import 'package:flutter/cupertino.dart';
import 'package:my_network_encapsulation/base/my_base_widget.dart';

/// @name：
/// @author qds
/// @date 2020/10/23
class BaseTest extends MyBaseWidget {

  @override
  MyBaseWidgetState<MyBaseWidget> getState() => new BaseTestState();
}

class BaseTestState extends MyBaseWidgetState<BaseTest> {
  ///api

  @override
  Widget buildWidget(BuildContext context) {
    return Center(
      child: Text('123'),
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
