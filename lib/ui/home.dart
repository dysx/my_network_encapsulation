
import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/config/application.dart';
import 'package:my_network_encapsulation/res/my_commons.dart';
import 'package:my_network_encapsulation/res/my_text_styles.dart';
import 'package:my_network_encapsulation/ui/aixin/aixin.dart';
import 'package:my_network_encapsulation/ui/grammar/grammarTest.dart';
import 'package:my_network_encapsulation/ui/home_page.dart';
import 'package:my_network_encapsulation/ui/login/goto_login.dart';
import 'package:my_network_encapsulation/ui/login/login.dart';
import 'package:my_network_encapsulation/ui/paintTest/paint_test.dart';
import 'package:my_network_encapsulation/util/local_storage.dart';

/// @name：
/// @author qds

class Home extends StatefulWidget {

  Home({Key key}) : super(key: key);

  @override
  State createState() => new HomeState();
}

class HomeState extends State<Home> {
  String _connectionStatus = 'Unknown';
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
  final pages = [HomePage(), TikTokVideoGesture(), PaintTest(), GrammarTest()];

  @override
  Widget build(BuildContext context) {
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

      // BottomNavigationBar(
      //   items: bottomNavItems,
      //   currentIndex: currentIndex,
      //   type: BottomNavigationBarType.fixed,
      //   fixedColor: Colors.green,
      //   onTap: (index) {
      //     _changePage(index);
      //   },
      // ),
      body: pages[currentIndex]
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          if(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile){
            Application.haveNetWork = true;
            debugPrint('网络可用：${Application.haveNetWork}');
          }else{
            Application.haveNetWork = false;
            debugPrint('网络不可用：${Application.haveNetWork}');
          }
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _connectivitySubscription.cancel();
    super.dispose();
  }

  /*切换页面*/
  void _changePage(int index) {
    /*如果点击的导航项不是当前项  切换 */
    if (index != currentIndex) {
      if(index == 2){
        checkPower();
      }
      setState(() {
        currentIndex = index;
      });
    }
  }

  /*登陆权限拦截*/
  Future<void> checkPower() async {
    // 获取本地存储的token
    final token = LocalStorage.get(MyCommons.TOKEN) ?? '';
    if (token == '') {
      setState(() {
        pages[2] = GoToLogin();
      });
    } else {
      pages[2] = PaintTest();
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