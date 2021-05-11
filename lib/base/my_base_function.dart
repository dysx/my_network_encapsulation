import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'build_config.dart';

abstract class MyBaseFunction {

  State _stateBaseFunction;
  BuildContext _contextBaseFunction;

  bool _isTopBarShow = true;                        // 状态栏是否显示
  bool _isAppBarShow = true;                        // 导航栏是否显示
  bool _isBackIconShow = true;                      // 返回按钮是否显示
  bool _isAppBarBottomShow = false;                 // 导航栏底部是否显示
  bool _topBarStyle = false;                        // 状态栏主题

  Color _topBarColor = Colors.transparent;          // 状态栏背景
  Color _appBarColor = Colors.white;                // 顶部导航栏背景
  Color _appBarContentColor = Colors.black;         // 导航栏标题颜色
  Color _appBarBottomLineColor = Colors.grey[300];  // 顶部导航栏下的线条颜色

  double _appBarCenterTextSize = 20;                // 中间标题字号
  double _appBarBottomLineHeight = 0.5;             // 顶部导航栏下的线条宽度
  double _appBarRightTextSize = 15.0;               // 右边小标题字号

  String _appBarTitle;                              // 标题
  String _appBarRightTitle;                         // 小标题
  Widget _appBarRightContent;                       // 导航栏右边组件

  Function _backIconClick;                          // 返回事件

  Widget getBaseView(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Column(
        children: <Widget>[
          _getBaseTopBar(),
          _getBaseAppBar(),
          Expanded(
            flex: 1,
            child: Container(
              width: getScreenWidth(),
              color: Colors.white, //背景颜色，可自己变更
              child: buildWidget(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getBaseTopBar() {
    return Offstage(
      offstage: !_isTopBarShow,
      child: getTopBar(),
    );
  }

  Widget _getBaseAppBar() {
    return Offstage(
      offstage: !_isAppBarShow,
      child: getAppBar(),
    );
  }

  /// 设置状态栏，可以自行重写拓展成其他的任何形式
  Widget getTopBar() {
    return Container(
      height: getTopBarHeight(),
      width: double.infinity,
      color: _topBarColor,
    );
  }

  /// 导航栏 appBar 可以重写
  Widget getAppBar() {
    return Container(
      height: getAppBarHeight(),
      width: double.infinity,
      color: _appBarColor,
      child: Stack(
        alignment: FractionalOffset(0, 0.5),
        children: <Widget>[
          Align(
            alignment: FractionalOffset(0.5, 0.5),
            child: getAppBarCenter(),
          ),
          Positioned(
            //左边返回导航 的位置，可以根据需求变更
            left: 15,
            child: Offstage(
              offstage: !_isBackIconShow,
              child: getAppBarLeft(),
            ),
          ),
          Positioned(
            right: 15,
            child: getAppBarRight(),
          ),
          Positioned(
            bottom: 0,
            child: getAppBarBottom(),
          ),
        ],
      ),
    );
  }

  /// 导航栏appBar中间部分 ，不满足可以自行重写
  Widget getAppBarCenter() {
    return Text(
      _appBarTitle,
      style: TextStyle(
        fontSize: _appBarCenterTextSize,
        color: _appBarContentColor,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  /// 导航栏appBar右边部分 ，不满足可以自行重写
  Widget getAppBarRight() {
    return _appBarRightContent ?? Text(
      _appBarRightTitle == null ? "" : _appBarRightTitle,
      style: TextStyle(
        fontSize: _appBarRightTextSize,
        color: _appBarContentColor,
      ),
    );
  }

  /// 导航栏appBar左边部分 ，不满足可以自行重写
  Widget getAppBarLeft() {
    return InkWell(
      onTap: clickAppBarBack,
      child: Icon(
        Icons.arrow_back_ios,
        color: _appBarContentColor,
        size: 20,
      ),
    );
  }

  /// 导航栏appBar底部部分 ，不满足可以自行重写
  Widget getAppBarBottom() {
    return Offstage(
      offstage: !_isAppBarBottomShow,
      child: Container(
        height: _appBarBottomLineHeight,
        width: double.maxFinite,
        color: _appBarBottomLineColor,
      ),
    );
  }

  void clickAppBarBack() async {
    _backIconClick ?? getBackEvent(_contextBaseFunction);
  }

  /// 状态栏主题
  bool getTopBarStyle() {
    return _topBarStyle;
  }

  /// 抽屉， 如需要需重写
  /// 抽屉顶部状态栏灰色解决方法：Drawer() 下的child设置padding为zero。
  Drawer getDrawer() {
    return null;
  }

  /// ======================== 可重写start ========================
  /// 设置状态栏隐藏或者显示
  void setTopBarVisible(bool isVisible) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _isTopBarShow = isVisible;
    });
  }

  /// 默认这个状态栏下，设置颜色
  void setTopBarBackColor(Color color) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _topBarColor = color == null ? _topBarColor : color;
    });
  }

  /// 设置导航栏的字体以及图标颜色
  void setAppBarContentColor(Color contentColor) {
    if (contentColor != null) {
      // ignore: invalid_use_of_protected_member
      _stateBaseFunction.setState(() {
        _appBarContentColor = contentColor;
      });
    }
  }

  /// 设置导航栏隐藏或者显示
  void setAppBarVisible(bool isVisible) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _isAppBarShow = isVisible;
    });
  }

  /// 默认这个导航栏下，设置颜色
  void setAppBarBackColor(Color color) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _appBarColor = color == null ? _appBarColor : color;
    });
  }

  void setAppBarTitle(String title) {
    if (title != null) {
      // ignore: invalid_use_of_protected_member
      _stateBaseFunction.setState(() {
        _appBarTitle = title;
      });
    }
  }

  void setAppBarRightTitle(String title) {
    if (title != null) {
      // ignore: invalid_use_of_protected_member
      _stateBaseFunction.setState(() {
        _appBarRightTitle = title;
      });
    }
  }

  /// 设置了这个设置的右边title将无效
  void setAppBarRightContent(Widget widget) {
    if (widget != null) {
      // ignore: invalid_use_of_protected_member
      _stateBaseFunction.setState(() {
        _appBarRightContent = widget;
      });
    }
  }

  /// 设置底部线是否显示
  void setAppBarBottomShow(bool isShow, {Color bottomColor, double height}) {
    if (isShow != null) {
      // ignore: invalid_use_of_protected_member
      _stateBaseFunction.setState(() {
        _isAppBarBottomShow = isShow;
        if (bottomColor != null) {
          _appBarBottomLineColor = bottomColor;
        }
        if (height != null) {
          _appBarBottomLineHeight = height;
        }
      });

    }

  }

  /// ======================== 重写end ========================

  void initBaseCommon(State state, BuildContext context) {
    _stateBaseFunction = state;
    _contextBaseFunction = context;
    if (BuildConfig.isDebug) {
      _appBarTitle = "";
      _appBarRightTitle = "";
    }
  }

  BuildContext get contextBase {
    return _contextBaseFunction;
  }

  /// 初始化一些变量 相当于 onCreate ， 放一下 初始化数据操作
  void onCreate();

  ///相当于onResume, 只要页面来到栈顶， 都会调用此方法，网络请求可以放在这个方法
  void onResume();

  ///页面被覆盖,暂停
  void onPause();

  /// 返回事件
  Future getBackEvent(BuildContext context) async {
    if (Navigator.canPop(_contextBaseFunction)) {
      Navigator.of(_contextBaseFunction).pop();
    } else {
      // 关闭最后一个 flutter 页面 ， 如果是原生跳过来的则回到原生，否则关闭app
      exit(0);
    }
  }

  /// 返回UI控件 相当于setContentView()
  Widget buildWidget(BuildContext context);

  /// app切回到后台
  void onBackground() {
    log("回到后台");
  }

  /// app切回到前台
  void onForeground() {
    log("回到前台");
  }

  String getClassName() {
    if (_contextBaseFunction == null) {
      return "";
    }
    String className = _contextBaseFunction.toString();
    if (className == null) {
      return "";
    }

    if (BuildConfig.isDebug) {
      try {
        className = className.substring(0, className.indexOf("("));
      } catch (err) {
        className = "";
      }
      return className;
    }

    return className;
  }

  /// ------------------------- 获取高度或宽度 ---------------------------
  /// 返回屏幕高度
  double getScreenHeight() {
    return MediaQuery.of(_contextBaseFunction).size.height;
  }

  /// 返回状态栏高度
  double getTopBarHeight() {
    return MediaQuery.of(_contextBaseFunction).padding.top;
  }

  /// 返回appbar高度，也就是导航栏高度
  double getAppBarHeight() {
    return kToolbarHeight;
  }

  /// 返回屏幕宽度
  double getScreenWidth() {
    return MediaQuery.of(_contextBaseFunction).size.width;
  }

}