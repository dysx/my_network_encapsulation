import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/base/a_base_life_state.dart';
import 'package:my_network_encapsulation/network/http/http.dart';

import 'navigator_manger.dart';

/// @describe: view基类
/// @author: qds
abstract class ABaseWidget extends StatefulWidget {
  ABaseWidget({Key? key, required this.pageName}) : super(key: key);

  final String pageName;

  @override
  ABaseWidgetState createState() => getState();

  ABaseWidgetState getState();
}

abstract class ABaseWidgetState<T extends ABaseWidget> extends State<T>
    with WidgetsBindingObserver, ABaseLifeState {
  /// 页面展示标记
  bool _onResumed = false;

  /// 页面暂停标记
  bool _onPause = false;

  @override
  void initState() {
    super.initState();
    setPageName(widget.pageName);
    NavigatorManger.addWidget(pageName);
    WidgetsBinding.instance!.addObserver(this);
    onCreate();
  }

  // 当initState() 调用结束后，这个函数会被调用
  @override
  void didChangeDependencies() {
    debugPrint('$pageName --- build --- didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("$pageName --- build --- build");
    if (!_onResumed) {
      // 说明是 初次加载
      if (NavigatorManger.isTopPage(pageName)) {
        _onResumed = true;
        onResume();
      }
    }
    return buildWidget(context);
  }

  Widget buildWidget(BuildContext context);

  // 当 State 被暂时从视图树中移除时，会调用这个函数
  @override
  void deactivate() {
    debugPrint("$pageName --- build --- deactivate");
    // 说明是被覆盖了
    if (NavigatorManger.isSecondTop(pageName)) {
      // 让上一个页面 执行 onResume
      if (!_onPause) {
        onPause();
        _onPause = true;
      } else {
        onResume();
        _onPause = false;
      }
    } else if (NavigatorManger.isTopPage(pageName)) {
      if (!_onPause) {
        onPause();
      }
    }
    print('路由管理: ${NavigatorManger.activityStack}');
    super.deactivate();
  }

  @override
  void dispose() {
    onDestroy();
    WidgetsBinding.instance!.removeObserver(this);
    _onResumed = false;
    _onPause = false;

    // 把该页面 从 页面列表中 去除
    NavigatorManger.removeWidget(pageName);
    // 取消网络请求
    Http.cancelHttp(pageName);
    super.dispose();
  }

  // 当app后台时会进入
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("$pageName --- build --- didChangeAppLifecycleState");
    // 此处可以拓展 是不是从前台回到后台
    if (state == AppLifecycleState.resumed) {
      // on resume
      if (NavigatorManger.isTopPage(pageName)) {
        onForeground();
        onResume();
      }
    } else if (state == AppLifecycleState.paused) {
      // on pause
      if (NavigatorManger.isTopPage(pageName)) {
        onBackground();
        onPause();
      }
    }
    super.didChangeAppLifecycleState(state);
  }
}
