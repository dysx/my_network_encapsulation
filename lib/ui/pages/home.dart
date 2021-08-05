
import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/base/base_widget.dart';
import 'package:my_network_encapsulation/res/my_commons.dart';
import 'package:my_network_encapsulation/ui/pages/index/home_page.dart';
import 'package:my_network_encapsulation/ui/pages/mine/mine.dart';
import 'package:my_network_encapsulation/ui/pages/second/second.dart';
import 'package:my_network_encapsulation/ui/pages/third/third.dart';
import 'package:my_network_encapsulation/ui/public/login/goto_login.dart';
import 'package:my_network_encapsulation/ui/widget/bottom_bar.dart';
import 'package:my_network_encapsulation/util/local_storage.dart';

/// @name：
/// @author qds
class Home extends BaseWidget {
  @override
  BaseWidgetState<BaseWidget> getState() => HomeState();
}

class HomeState extends BaseWidgetState<Home> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  int currentIndex = 0;
  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '首页',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.message),
      label: '消息',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: '购物车',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: '个人中心',
    ),
  ];
  List<Widget> pages = [HomePage(), Second(), Third(), Mine()];
  List<Widget> noTokenPages = [HomePage(), Second(), Third(), GoToLogin()];
  bool needToLogin = false;

  PageController _pageController = new PageController();

  @override
  Widget buildWidget(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: needToLogin ? noTokenPages : pages,
    );
  }

  @override
  Widget getBottomWidget() {
    // TODO: implement getBottomWidget
    return MyBottomBar(items: [
      BottomNavyBarItem(
        icon: Icon(Icons.apps),
        title: '首页',
        activeColor: Colors.green,
        inactiveColor: MyColors.black_3333,
      ),
      BottomNavyBarItem(
        icon: Icon(Icons.apps),
        title: '社区',
        activeColor: Colors.green,
        inactiveColor: MyColors.black_3333,
      ),
      BottomNavyBarItem(
        icon: Icon(Icons.apps),
        title: '消息',
        activeColor: Colors.green,
        inactiveColor: MyColors.black_3333,
      ),
      BottomNavyBarItem(
        icon: Icon(Icons.apps),
        title: '我的',
        activeColor: Colors.green,
        inactiveColor: MyColors.black_3333,
      ),
    ],
        iconSize: 23.w,
        containerHeight: 52.w,
        showElevation: false,
        selectedIndex: currentIndex,
        onItemSelected: (index) async {
      setState(() {
        currentIndex = index;
      });
      await _checkPower();
      _pageController.jumpToPage(index);
    });

    return CupertinoTabBar(
      backgroundColor: MyColors.white,
      currentIndex: currentIndex,
      onTap: (index) async {
        setState(() {
          currentIndex = index;
        });
        await _checkPower();
        _pageController.jumpToPage(index);
      },
      items: bottomNavItems,
      activeColor: Colors.blue,
      border: null,
    );
  }

  @override
  void onCreate() {
    setTopBarVisible(false);
    setAppBarVisible(false);
    setBackIconHinde();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          if(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile){
            debugPrint('网络可用');
          }else{
            debugPrint('网络不可用');
          }
        });
  }

  @override
  void onPause() {
    _connectivitySubscription.cancel();
  }

  @override
  void onResume() {}

  /*登陆权限拦截*/
  Future<void> _checkPower() async {
    // 获取本地存储的token
    final token = LocalStorage.get(MyCommons.TOKEN) ?? '';
    if(currentIndex == 3){
      if (token == '') {
        setState(() {
          needToLogin = true;
        });
      } else {
        setState(() {
          needToLogin = false;
        });
      }
    }
  }

// //平台消息是异步的，所以我们用异步方法初始化。
// Future<Null> initConnectivity() async {
//   String connectionStatus;
//   //平台消息可能会失败，因此我们使用Try/Catch PlatformException。
//   try {
//     connectionStatus = (await _connectivity.checkConnectivity()).toString();
//   }  catch (e) {
//     print(e.toString());
//     connectionStatus = 'Failed to get connectivity.';
//   }
//
//   // 如果在异步平台消息运行时从树中删除了该小部件，
//   // 那么我们希望放弃回复，而不是调用setstate来更新我们不存在的外观。
//   if (!mounted) {
//     return;
//   }
//
//   setState(() {
//     _connectionStatus = connectionStatus;
//   });
// }

}