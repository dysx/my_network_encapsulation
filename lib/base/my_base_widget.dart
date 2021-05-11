
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_network_encapsulation/base/my_base_function.dart';
import 'package:my_network_encapsulation/base/navigator_manger.dart';

/// 基类
abstract class MyBaseWidget extends StatefulWidget {

  MyBaseWidget({Key key}) : super(key: key);

  MyBaseWidgetState myBaseWidgettState;

  MyBaseWidgetState createState() {
    myBaseWidgettState = getState();
    return myBaseWidgettState;
  }

  MyBaseWidgetState getState();

}

abstract class MyBaseWidgetState<T extends MyBaseWidget> extends State<T> with WidgetsBindingObserver,MyBaseFunction{

  MyBaseFunction getBaseFunction() {
    return this;
  }

  bool _onResumed = false;  // 页面展示标记
  bool _onPause = false;    // 页面暂停标记

  @override
  void initState() {
    initBaseCommon(this, context);
    NavigatorManger().addWidget(this);
    WidgetsBinding.instance.addObserver(this);
    onCreate();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    // 说明被覆盖了
    if(NavigatorManger().isSecondTop(this)){
      if(!_onPause) {
        onPause();
      }else{
        onResume();
        _onPause = false;
      }
    }else if(NavigatorManger().isTopPage(this)) {
      if(!_onPause){
        onPause();
      }
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    if(!_onResumed){
      // 初次加载
      if (NavigatorManger().isTopPage(this)) {
        _onResumed = true;
        onResume();
      }
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: getTopBarStyle() ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        child: WillPopScope(
          onWillPop: () => getBackEvent(context),
          child: Scaffold(
            drawer: getDrawer(),
            body: getBaseView(context),
          ),
        )
    );
  }

}