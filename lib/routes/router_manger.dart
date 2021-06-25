import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_network_encapsulation/res/my_commons.dart';
import 'package:my_network_encapsulation/ui/Third/third.dart';
import 'package:my_network_encapsulation/ui/base/not_found_page.dart';
import 'package:my_network_encapsulation/ui/home.dart';
import 'file:///E:/study_project/my_network_encapsulation/lib/ui/index/home_page.dart';
import 'package:my_network_encapsulation/ui/login/login.dart';
import 'package:my_network_encapsulation/ui/mine/mine.dart';
import 'package:my_network_encapsulation/ui/second/second.dart';
import 'file:///E:/study_project/my_network_encapsulation/lib/routes/page_route_anim.dart';
import 'package:my_network_encapsulation/util/local_storage.dart';

/// 路由名
class RouteName {
  static const String login = 'login';
  static const String home = 'home';
  static const String homePage = 'homePage';
  static const String second = 'second';
  static const String third = 'third';
  static const String mine = 'mine';
}

/// 路由初始化
/// [arguments]: 参数为Object类型，根据需求自定义；接受页面请定义
class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    String routeName;
    routeName = routeBeforeHook(settings);
    switch (routeName) {
      case RouteName.login:
        return SlideBottomRouteBuilder(Login());
      case RouteName.home:
        return SizeRoute(Home());
      case RouteName.homePage:
        return NoAnimRouteBuilder(HomePage());
      case RouteName.second:
        return NoAnimRouteBuilder(Second());
      case RouteName.third:
        return NoAnimRouteBuilder(Third());
      case RouteName.mine:
        return NoAnimRouteBuilder(Mine());
      default:
        return FadeRouteBuilder(NotFoundPage());
    }
  }

  // 指定哪些页面需要登录权限
  static List<String> powerPage = [
    'mine'
  ];

  /*登陆拦截*/
  // 此处做登陆权限拦截
  static String routeBeforeHook(RouteSettings settings) {
    String route;
    for (String item in powerPage) {
      // 如果此路由需登陆权限
      if (item == settings.name) {
        // 获取本地存储的token
        final token = LocalStorage.get(MyCommons.TOKEN) ?? '';
        if (token != '') {
          if(settings.name == 'login'){
            route = 'login';
          } else {
            route = settings.name;
          }
        } else {
          route = 'login';
        }
      } else {
        route = settings.name;
      }
    }
    return route;
  }
}

/// Pop路由
class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
