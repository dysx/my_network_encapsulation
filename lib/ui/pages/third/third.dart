import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/base/base_inner_widget.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';

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
      child: Column(
        children: [
          ordinaryButton(
              text: '购物车状态',
              backgroundColor: MyColors.blue_91ff,
              onPressed: (){
                MyNavigator.pushNamed(RouteName.goodsList);
              }
          ),
          ordinaryButton(
              text: '列表',
              backgroundColor: MyColors.blue_91ff,
              onPressed: (){
                MyNavigator.pushNamed(RouteName.mockPage);
              }
          )
        ],
      ),
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
