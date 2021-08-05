import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/base/base_inner_widget.dart';

class Third extends BaseInnerWidget {
  @override
  BaseInnerWidgetState<BaseInnerWidget> getState() => ThirdState();

  @override
  int setIndex() => 2;
}

class ThirdState extends BaseInnerWidgetState<Third> {
  @override
  Widget buildWidget(BuildContext context) {
    return Center(
      child: Text('这是第三个页面'),
    );
  }

  @override
  double getVerticalMargin() => 0;

  @override
  void onCreate() {
    setTopBarVisible(true);
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
