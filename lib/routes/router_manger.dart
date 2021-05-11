import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_network_encapsulation/ui/flutter_html_test.dart';
import 'package:my_network_encapsulation/ui/grammar/grammarTest.dart';
import 'package:my_network_encapsulation/ui/home_page.dart';
import 'package:my_network_encapsulation/ui/paint/alarmPage.dart';
import 'package:my_network_encapsulation/ui/route_anim/test.dart';
import 'file:///E:/study_project/my_network_encapsulation/lib/routes/page_route_anim.dart';
import 'package:my_network_encapsulation/ui/test.dart';
import 'package:my_network_encapsulation/ui/webview/webView_test.dart';

/// 路由名
class RouteName {
  static const String homePage = 'homePage';
  static const String routeAnim = 'routeAnim';
  static const String test = 'test';
  static const String htmlText = 'htmlTest';
  static const String webViewText = 'webViewTest';
  static const String alarmPage = 'alarmPage';
  static const String grammarTest = 'grammarTest';
}

/// 路由初始化
/// [arguments]: 参数为Object类型，根据需求自定义；接受页面请定义
class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.routeAnim:
        return SizeRoute(RouteAnim(arguments: settings.arguments));
      case RouteName.homePage:
        return NoAnimRouteBuilder(HomePage());
      case RouteName.test:
        return FadeRouteBuilder(Test());
      case RouteName.htmlText:
        return FadeRouteBuilder(FlutterHtmlTest());
      case RouteName.webViewText:
        return FadeRouteBuilder(WebViewTest());
      case RouteName.alarmPage:
        return FadeRouteBuilder(AlarmPage());
      case RouteName.grammarTest:
        return FadeRouteBuilder(GrammarTest());
      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('没有找到${settings.name}页面'),
                  ),
                ));
    }
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
