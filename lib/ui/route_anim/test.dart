
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/base/my_base_widget.dart';

class RouteAnim extends MyBaseWidget {

  RouteAnim({Key key,this.arguments}):super(key: key);

  Object arguments;

  @override
  MyBaseWidgetState<MyBaseWidget> getState() => new _RouteAnimState();
}

class _RouteAnimState extends MyBaseWidgetState<RouteAnim> {

  @override
  Widget buildWidget(BuildContext context) {
    return Container();
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
    setAppBarTitle('');
    setTopBarBackColor(Colors.yellow);
    Map<String,dynamic> map = Map<String,dynamic>();
    map = widget.arguments;
    print(widget.arguments);
    print(map['id']);
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