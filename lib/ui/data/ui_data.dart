import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/ui/widget/bottom_bar.dart';
import 'package:my_network_encapsulation/ui/pages/index/home_page.dart';
import 'package:my_network_encapsulation/ui/pages/mine/mine.dart';
import 'package:my_network_encapsulation/ui/pages/second/second.dart';
import 'package:my_network_encapsulation/ui/pages/third/third.dart';

/// 底部导航栏数据
final List<BottomNavyBarItem> bottomNavItems = [
  BottomNavyBarItem(
    icon: Icon(Icons.apps),
    title: '首页',
    activeColor: Colors.green,
    inactiveColor: AppColors.black_3333,
  ),
  BottomNavyBarItem(
    icon: Icon(Icons.apps),
    title: '社区',
    activeColor: Colors.green,
    inactiveColor: AppColors.black_3333,
  ),
  BottomNavyBarItem(
    icon: Icon(Icons.apps),
    title: '消息',
    activeColor: Colors.green,
    inactiveColor: AppColors.black_3333,
  ),
  BottomNavyBarItem(
    icon: Icon(Icons.apps),
    title: '我的',
    activeColor: Colors.green,
    inactiveColor: AppColors.black_3333,
  ),
];

final List<Widget> pages = [HomePage(), Second(), Third(), Mine()];

/// 当用户没有登录的时候显示的路由页面
final List<Widget> noTokenPages = [HomePage(), Second(), Third(), Mine()];
