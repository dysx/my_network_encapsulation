
import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/base/base_tabBar_widget.dart';
import 'package:my_network_encapsulation/base/base_widget.dart';
import 'package:my_network_encapsulation/res/my_commons.dart';
import 'package:my_network_encapsulation/ui/page/index/home_page.dart';
import 'package:my_network_encapsulation/ui/page/login/goto_login.dart';
import 'package:my_network_encapsulation/ui/page/mine/mine.dart';
import 'package:my_network_encapsulation/ui/page/second/second.dart';
import 'package:my_network_encapsulation/ui/page/third/third.dart';
import 'package:my_network_encapsulation/util/local_storage.dart';

/// @name：
/// @author qds
class Home extends BaseWidget {
  @override
  BaseWidgetState<BaseWidget> getState() => HomeState();
}

class HomeState extends BaseWidgetState<Home> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

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

  PageController _pageController = new PageController();

  @override
  Widget buildWidget(BuildContext context) {
    return BaseTabBarWidget(
      type: 1,
      tabItems: bottomNavItems,
      tabViews: pages,
      pageControl: _pageController,
      indicatorColor: Colors.blue,
      onPageChanged: (value){
        _changePage(value);
      },
    );
    return Scaffold(
        bottomNavigationBar:
        CupertinoTabBar(
          currentIndex: currentIndex,
          onTap: (index) {
            _changePage(index);
          },
          items: bottomNavItems,
          activeColor: Colors.blue,
        ),
        body: pages[currentIndex]
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

  List<Widget> myPages(int index) {
    List<Widget> list = [];
    _changePage(index);
    list = pages;
    return list;
  }

  /*切换页面*/
  Future<void> _changePage(int index) async {
    /*如果点击的导航项不是当前项  切换 */
    if (index != currentIndex) {
      if(index == 3){
        await checkPower();
      }
      setState(() {
        currentIndex = index;
      });
    }
    // _pageController.jumpToPage(currentIndex);
  }

  /*登陆权限拦截*/
  void checkPower() {
    // 获取本地存储的token
    final token = LocalStorage.get(MyCommons.TOKEN) ?? '';
    if (token == '') {
      print('无token值');
      setState(() {
        pages[3] = GoToLogin();
      });
    } else {
      print('有token值');
      setState(() {
        pages[3] = Mine();
      });
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