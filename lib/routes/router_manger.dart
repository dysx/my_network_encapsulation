import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/res/my_commons.dart';
import 'package:my_network_encapsulation/routes/page_route_anim.dart';
import 'package:my_network_encapsulation/ui/pages/Third/third.dart';
import 'package:my_network_encapsulation/ui/pages/cartTest/goods_list.dart';
import 'package:my_network_encapsulation/ui/pages/cartTest/my_cart.dart';
import 'package:my_network_encapsulation/ui/pages/home.dart';
import 'package:my_network_encapsulation/ui/pages/index/home_page.dart';
import 'package:my_network_encapsulation/ui/pages/launch/lead_page.dart';
import 'package:my_network_encapsulation/ui/pages/launch/privacy_tips_page.dart';
import 'package:my_network_encapsulation/ui/pages/launch/startup_page.dart';
import 'package:my_network_encapsulation/ui/pages/mine/mine.dart';
import 'package:my_network_encapsulation/ui/pages/second/second.dart';
import 'package:my_network_encapsulation/ui/pages/test/base_test.dart';
import 'package:my_network_encapsulation/ui/pages/test/scroll_to_index.dart';
import 'package:my_network_encapsulation/ui/pages/test/testA.dart';
import 'package:my_network_encapsulation/ui/pages/test/testB.dart';
import 'package:my_network_encapsulation/ui/pages/test/testC.dart';
import 'package:my_network_encapsulation/ui/pages/test/testD.dart';
import 'package:my_network_encapsulation/ui/pages/third/favourite_page.dart';
import 'package:my_network_encapsulation/ui/pages/third/mock_page.dart';
import 'package:my_network_encapsulation/ui/public/login/login.dart';
import 'package:my_network_encapsulation/ui/widget/multipleImage/my_photo_view.dart';
import 'package:my_network_encapsulation/ui/widget/not_found_page.dart';
import 'package:my_network_encapsulation/util/local_storage.dart';

/// 路由名
class RouteName {
  static const String privacyTipsPage = 'privacyTipsPage';
  static const String startupPage = 'startupPage';
  static const String lead = 'lead';
  static const String myPhotoView = 'myPhotoView';
  static const String login = 'login';
  static const String home = 'home';
  static const String homePage = 'homePage';
  static const String second = 'second';
  static const String third = 'third';
  static const String goodsList = 'goodsList';
  static const String favouritePage = 'favouritePage';
  static const String mockPage = 'mockPage';
  static const String myCart = 'myCart';
  static const String mine = 'mine';
  static const String baseTest = 'baseTest';
  static const String testA = 'testA';
  static const String testB = 'testB';
  static const String testC = 'testC';
  static const String testD = 'testD';
  static const String scrollToIndex = 'scrollToIndex';
}

/// 路由初始化
/// [arguments]: 参数为Object类型，根据需求自定义；接受页面请定义
class MyRouter {
  static Route generateRoute<T extends Object>(RouteSettings settings) {
    String routeName;
    routeName = routeBeforeHook(settings);
    switch (routeName) {
      case RouteName.privacyTipsPage:
        return NoAnimRouteBuilder(PrivacyTipsPage(), routeName);
      case RouteName.startupPage:
        return NoAnimRouteBuilder(StartupPage(), routeName);
      case RouteName.lead:
        return FadeRouteBuilder(LeadPage(), routeName);
      // case RouteName.photoView:
      //   return FadeRouteBuilder(
      //       PhotoView(
      //         photoList: settings.arguments!['photoList'],
      //         localPhotos: settings.arguments!['localPhotos'],
      //       ),
      //       routeName);
      case RouteName.login:
        return SlideBottomRouteBuilder(Login(), routeName);
      case RouteName.home:
        return SizeRoute(Home(), routeName);
      case RouteName.homePage:
        return NoAnimRouteBuilder(HomePage(), routeName);
      case RouteName.second:
        return NoAnimRouteBuilder(Second(), routeName);
      case RouteName.third:
        return NoAnimRouteBuilder(Third(), routeName);
      case RouteName.goodsList:
        return NoAnimRouteBuilder(GoodsList(), routeName);
      case RouteName.favouritePage:
        return SizeRoute(FavouritePage(), routeName);
      case RouteName.mockPage:
        return SizeRoute(MockPage(), routeName);
      case RouteName.myCart:
        return NoAnimRouteBuilder(MyCart(), routeName);
      case RouteName.mine:
        return NoAnimRouteBuilder(Mine(), routeName);
      case RouteName.baseTest:
        return NoAnimRouteBuilder(BaseTest(), routeName);
      case RouteName.testA:
        return FadeRouteBuilder(TestA(), routeName);
      case RouteName.testB:
        return NoAnimRouteBuilder(TestB(), routeName);
      case RouteName.testC:
        return NoAnimRouteBuilder(TestC(), routeName);
      case RouteName.testD:
        return NoAnimRouteBuilder(TestD(), routeName);
      case RouteName.scrollToIndex:
        return NoAnimRouteBuilder(ScrollToIndexDemoPage2(), routeName);
      default:
        return FadeRouteBuilder(NotFoundPage(), routeName);
    }
  }

  // 指定哪些页面需要登录权限
  static List<String> powerPage = ['mine'];

  /*登陆拦截*/
  // 此处做登陆权限拦截
  static String routeBeforeHook(RouteSettings settings) {
    late String route;
    for (String item in powerPage) {
      // 如果此路由需登陆权限
      if (item == settings.name) {
        // 获取本地存储的token
        final token = LocalStorage.get(MyCommons.TOKEN) ?? '';
        if (token != '') {
          if (settings.name == 'login') {
            route = 'login';
          } else {
            route = settings.name!;
          }
        } else {
          route = 'login';
        }
      } else {
        route = settings.name!;
      }
    }
    return route;
  }
}

/// Pop路由
class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget? child;

  PopRoute({@required this.child});

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child!;
  }

  @override
  Duration get transitionDuration => _duration;
}
