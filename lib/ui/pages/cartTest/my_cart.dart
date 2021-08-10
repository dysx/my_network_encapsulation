import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/base/base_widget.dart';
import 'package:my_network_encapsulation/routes/my_navigator.dart';
import 'package:my_network_encapsulation/routes/router_manger.dart';
import 'package:my_network_encapsulation/util/buttons.dart';

class MyCart extends BaseWidget {
  @override
  BaseWidgetState<BaseWidget> getState() => _MyCartState();
}

class _MyCartState extends BaseWidgetState<MyCart> {
  @override
  Widget buildWidget(BuildContext context) {
    return Center(
      child: ordinaryButton(
        onPressed: () {
          // setErrorWidgetVisible(true);
          MyNavigator.pushNamed(RouteName.testC);
        },
        text: "跳到c",
      ),
    );
  }

  @override
  void onCreate() {
    setAppBarTitle('testA');
    // TODO: implement onCreate
    // setTopBarBackColor(MyColors.background);
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
