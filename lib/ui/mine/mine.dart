import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/base/base_inner_widget.dart';

class Mine extends BaseInnerWidget {
  @override
  BaseInnerWidgetState<BaseInnerWidget> getState() => MineState();

  @override
  int setIndex() => 3;
}

class MineState extends BaseInnerWidgetState<Mine> {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('我的页面'),
        ),
      ),
    );
  }

  @override
  double getVerticalMargin() => 0;

  @override
  void onCreate() {
    setTopBarVisible(false);
    setAppBarVisible(false);
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
