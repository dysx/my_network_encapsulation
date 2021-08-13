import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/generated/l10n.dart';
import 'package:my_network_encapsulation/res/my_colors.dart';
import 'package:my_network_encapsulation/res/my_text_styles.dart';
import 'package:my_network_encapsulation/util/image/local_image_selector.dart';
import 'package:my_network_encapsulation/util/log_utils.dart';
import 'package:my_network_encapsulation/util/size_util.dart';
import 'package:my_network_encapsulation/util/toast.dart';

/// @describe: base 类 常用的一些工具类 ， 放在这里就可以了
/// get方法均可以重写，set方法可直接调用设置
///
/// @author: qds
/// @date:
abstract class BaseFunction {
  late State _stateBaseFunction;
  late BuildContext _contextBaseFunction;

  GlobalKey<ScaffoldState> baseScaffoldKey = new GlobalKey();

  /// 状态栏是否显示 默认显示
  bool _isTopBarShow = true;

  /// 导航栏是否显示 默认显示
  bool _isAppBarShow = true;

  /// 导航栏底部是否显示 默认不显示
  bool _isAppBarBottomShow = false;

  /// 背景色 默认白
  Color _backgroundColor = Colors.white;

  /// 状态栏背景色
  Color _topBarColor = MyColors.background;

  /// 导航栏背景色
  Color _appBarColor = MyColors.background;

  /// 导航栏内容颜色
  Color _appBarContentColor = MyColors.black_3333;
  Color _appBarBottomLineColor = MyColors.background;

  /// 导航栏右边组件
  Widget? _appBarRightContent;

  /// 底部组件
  Widget? _bottomWidget;

  /// 设置状态栏字体黑白 true: 白色，false: 黑色
  bool _topBarStyle = false;

  /// 导航栏返回按钮事件
  Function? _backIconClick;

  /// 标题字体大小
  double _appBarCenterTextSize = 18.sp;

  /// 标题
  String _appBarTitle = '';

  /// 右边小标题信息
  String? _appBarRightTitle;
  double _appBarRightTextSize = 15.sp;
  double _appBarBottomLineheight = 2;

  /// 是否显示左边返回按钮
  bool _isBackIconShow = true;

  /// 作为内部页面距离底部的高度
  double bottomVertical = 0;

  bool _isBottomInset = false;

  bool get isBottomInset => _isBottomInset;

  bool _asFrame = false;

  bool get isAsFrame => _asFrame;

  /// 有需要的话就重写以下的方法
  ///-----------------------------
  void initBaseCommon(State state, BuildContext context) {
    _stateBaseFunction = state;
    _contextBaseFunction = context;
  }

  BuildContext get contextBase {
    return _contextBaseFunction;
  }

  Widget getBaseView(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: _backgroundColor,
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                bottom: _isAppBarBottomShow ? _appBarBottomLineheight : 0),
            decoration: _isAppBarBottomShow
                ? BoxDecoration(
                    color: _appBarColor, boxShadow: [Styles.appbarShadow])
                : BoxDecoration(),
            child: Column(
              children: <Widget>[
                _getBaseTopBar(),
                _getBaseAppBar(),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: getScreenWidth(),
              child: Stack(
                children: <Widget>[
                  buildWidget(context),
                ],
              ),
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

  /// 状态栏主题
  bool getTopBarStyle() {
    return _topBarStyle;
  }

  /// 设置状态栏主题
  void setTopBarStyle(bool topBarStyle) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _topBarStyle = topBarStyle;
    });
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
            left: 0,
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

  /// ----------------暴露的错误页面方法，可以自己重写定制--------------------
  /// 导航栏appBar中间部分 ，不满足可以自行重写
  Widget getAppBarCenter() {
    return Text(
      _appBarTitle,
      style: TextStyle(
        fontSize: _appBarCenterTextSize.toDouble(),
        color: _appBarContentColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// 导航栏appBar右边部分 ，不满足可以自行重写
  Widget getAppBarRight() {
    return _appBarRightContent ??
        Text(
          (_appBarRightTitle == null ? "" : _appBarRightTitle)!,
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
      child: Container(
        padding: EdgeInsets.only(left: 15.w),
        width: 50.w,
        height: 35.w,
        // color: Colors.amber,
        color: Colors.transparent,
        alignment: Alignment.centerLeft,
        child: LocalImageSelector.getSingleImage("icon_back",
            type: ".png", imageHeight: 15.w, imageColor: _appBarContentColor),
      ),
    );
  }

  /// 导航栏appBar底部部分 ，不满足可以自行重写
  Widget getAppBarBottom() {
    return Container(
      height: _isAppBarBottomShow ? _appBarBottomLineheight : 0,
    );
  }

  /// 导航栏appBar底部部分 ，不满足可以自行重写
  Widget getBottomWidget() {
    return _bottomWidget ?? SizedBox.shrink();
  }

  void clickAppBarBack() async {
    _backIconClick ?? getBackEvent(_contextBaseFunction);
  }

  int backTime = 0;

  /// 返回事件
  Future<bool> getBackEvent(BuildContext context) async {
    if (Navigator.canPop(_contextBaseFunction)) {
      Navigator.of(_contextBaseFunction).pop();
      return Future.value(false);
    } else {
      if (backTime != 0 &&
          DateTime.now().millisecondsSinceEpoch - backTime < 2000) {
        finishDartPageOrApp();
        return Future.value(false);
      } else if (backTime != 0 &&
          DateTime.now().millisecondsSinceEpoch - backTime > 2000) {
        backTime = DateTime.now().millisecondsSinceEpoch;
        Toast.showMsg(S.of(context).click_again_to_exit);
        return Future.value(false);
      } else {
        backTime = DateTime.now().millisecondsSinceEpoch;
        Toast.showMsg(S.of(context).click_again_to_exit);
        return Future.value(false);
      }
    }
  }

  /// 返回中间可绘制区域，也就是 我们子类 buildWidget 可利用的空间高度
  double getMainWidgetHeight() {
    double screenHeight = getScreenHeight() - bottomVertical;

    if (_isTopBarShow) {
      screenHeight = screenHeight - getTopBarHeight();
    }
    if (_isAppBarShow) {
      screenHeight = screenHeight - getAppBarHeight();
    }

    return screenHeight;
  }

  /// 返回屏幕高度
  double getScreenHeight() {
    return MediaQuery.of(_contextBaseFunction).size.height;
  }

  /// 返回状态栏高度
  double getTopBarHeight() {
    return MediaQuery.of(_contextBaseFunction).padding.top;
  }

  /// 返回底部safeArea高度
  double getBottomSafeAreaHeight() {
    return MediaQuery.of(_contextBaseFunction).padding.bottom;
  }

  /// 返回appbar高度，也就是导航栏高度
  double getAppBarHeight() {
    return kToolbarHeight + (_isAppBarBottomShow ? _appBarBottomLineheight : 0);
  }

  /// 返回屏幕宽度
  double getScreenWidth() {
    return MediaQuery.of(_contextBaseFunction).size.width;
  }

  /// 抽屉， 如需要需重写
  /// 抽屉顶部状态栏灰色解决方法：Drawer() 下的child设置padding为zero。
  Drawer? getDrawer() {
    return null;
  }

  /// 右侧抽屉， 如需要需重写
  /// 右侧抽屉顶部状态栏灰色解决方法：Drawer() 下的child设置padding为zero。
  Drawer? getEndDrawer() {
    return null;
  }

  /// 打开抽屉，需要主动关闭抽屉调用Navigator.pop(context)即可
  void openDrawer() {
    baseScaffoldKey.currentState!.openDrawer();
  }

  /// 打开右侧抽屉
  void openEndDrawer() {
    baseScaffoldKey.currentState!.openEndDrawer();
  }

  /// 关闭最后一个 flutter 页面 ， 如果是原生跳过来的则回到原生，否则关闭app
  void finishDartPageOrApp() {
    exit(0);
  }

  /// 是否为无需默认脚手架页面
  void setIsAsFrame(bool asFrame) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _asFrame = asFrame;
    });
  }

  /// 设置背景色
  void setBackground(Color? color) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _backgroundColor = color ?? _backgroundColor;
    });
  }

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
      _topBarColor = color;
    });
  }

  /// 设置导航栏的字体以及图标颜色
  void setAppBarContentColor(Color contentColor) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _appBarContentColor = contentColor;
    });
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
      _appBarColor = color;
    });
  }

  void setAppBarTitle(String title) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _appBarTitle = title;
    });
  }

  void setAppBarColor(Color color) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _appBarColor = color;
    });
  }

  void setTopBarColor(Color color) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _topBarColor = color;
    });
  }

  void setAppBarRightTitle(String title) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _appBarRightTitle = title;
    });
  }

  /// 设置了这个设置的右边title将无效
  void setAppBarRightContent(Widget widget) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _appBarRightContent = widget;
    });
  }

  /// 设置固定底部Widget
  void setBottomWidget(Widget widget) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _bottomWidget = widget;
    });
  }

  /// 设置底部线是否显示
  void setAppBarBottomShow(bool isShow, {Color? bottomColor, double? height}) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _isAppBarBottomShow = isShow;
      if (bottomColor != null) {
        _appBarBottomLineColor = bottomColor;
      }
      if (height != null) {
        _appBarBottomLineheight = height;
      }
    });
  }

  /// 设置返回事件
  void setAppBarBackEvent(Function backFunc) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _backIconClick = backFunc;
    });
  }

  void setBackIconHinde({bool isHiinde = true}) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _isBackIconShow = !isHiinde;
    });
  }

  void setBottomInset({bool isBottomInset = false}) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _isBottomInset = isBottomInset;
    });
  }

  /// 初始化一些变量 相当于 onCreate ， 放一下 初始化数据操作
  void onCreate();

  /// 相当于onResume, 只要页面来到栈顶， 都会调用此方法，网络请求可以放在这个方法
  void onResume() {
    log("${getClassName()}页面onResume");
  }

  /// 页面被覆盖,暂停
  void onPause() {
    log("页面被覆盖,暂停");
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

  /// 页面注销方法
  void onDestroy() {
    log("destroy");
  }

  /// 输入日志
  void log(String content) {
    Log.d(getClassName() + "------:" + content);
  }

  String getClassName() {
    String className = _contextBaseFunction.widget.toStringShort();
    return className;
  }
}
