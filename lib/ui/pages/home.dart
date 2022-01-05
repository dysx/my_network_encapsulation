import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/base/base_widget.dart';
import 'package:my_network_encapsulation/res/keys.dart';
import 'package:my_network_encapsulation/ui/data/ui_data.dart';
import 'package:my_network_encapsulation/ui/widget/bottom_bar.dart';
import 'package:my_network_encapsulation/util/local_storage.dart';

/// @describe: home
/// @author: qds
class Home extends BaseWidget {
  @override
  BaseWidgetState<BaseWidget> getState() => HomeState();
}

class HomeState extends BaseWidgetState<Home> {
  int currentIndex = 0;
  bool needToLogin = false;
  PageController _pageController = PageController();

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
    return MyBottomBar(
        items: bottomNavItems,
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
  }

  @override
  void onCreate() {
    setTopBarVisible(false);
    setAppBarVisible(false);
    setBackIconHide();
  }

  @override
  void onPause() {}

  @override
  void onResume() {}

  /*登陆权限拦截*/
  Future<void> _checkPower() async {
    // 获取本地存储的token
    final token = LocalStorage.get(Keys.token) ?? '';
    if (currentIndex == 3) {
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
}
