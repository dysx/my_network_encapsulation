import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/base/base_widget.dart';
import 'package:my_network_encapsulation/res/my_colors.dart';
import 'package:my_network_encapsulation/routes/navigater.dart';
import 'package:my_network_encapsulation/routes/router_manger.dart';
import 'package:my_network_encapsulation/ui/common/button/outlined_button.dart';

class TestB extends BaseWidget {
  @override
  BaseWidgetState<BaseWidget> getState() => TestBState();
}

class TestBState extends BaseWidgetState<TestB> {
  @override
  Widget buildWidget(BuildContext context) {
    return Center(
      child: MyOutlinedButton(
        onPressed: () {
          // setErrorWidgetVisible(true);
          Navigater.pushNamed(RouteName.testC);
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
