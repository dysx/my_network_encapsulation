import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/base/base_inner_widget.dart';

class Second extends BaseInnerWidget {
  @override
  BaseInnerWidgetState<BaseInnerWidget> getState() => SecondState();

  @override
  int setIndex() => 1;
}

class SecondState extends BaseInnerWidgetState<Second> {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('这是第二个页面'),
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
