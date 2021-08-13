import 'package:flutter/cupertino.dart';

/// @describe: 路由动画
/// 加上RouteSettings(name: routeName)，否则popUntil到某个路由会黑屏
/// 原因：找不到指定的路由
///
/// @author: qds
/// @date:

/// 无动画
class NoAnimRouteBuilder extends PageRouteBuilder {
  final Widget page;
  final String routeName;

  NoAnimRouteBuilder(this.page, this.routeName)
      : super(
            opaque: false,
            settings: RouteSettings(name: routeName),
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionDuration: Duration(milliseconds: 0),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) => child);
}

/// 路由渐变
class FadeRouteBuilder extends PageRouteBuilder {
  final Widget page;
  final String routeName;

  FadeRouteBuilder(this.page, this.routeName)
      : super(
            settings: RouteSettings(name: routeName),
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionDuration: Duration(milliseconds: 500),
            transitionsBuilder: (context, animation, secondaryAnimation,
                    child) =>
                FadeTransition(
                  opacity: Tween(begin: 0.1, end: 1.0).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.fastOutSlowIn,
                  )),
                  child: child,
                ));
}

/// 从上往下展开路由
class SlideTopRouteBuilder extends PageRouteBuilder {
  final Widget page;
  final String routeName;

  SlideTopRouteBuilder(this.page, this.routeName)
      : super(
            settings: RouteSettings(name: routeName),
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionDuration: Duration(milliseconds: 800),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
                      position: Tween<Offset>(
                              begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0))
                          .animate(CurvedAnimation(
                              parent: animation, curve: Curves.fastOutSlowIn)),
                      child: child,
                    ));
}

/// 从下往上展开路由
class SlideBottomRouteBuilder extends PageRouteBuilder {
  final Widget page;
  final String routeName;

  SlideBottomRouteBuilder(this.page, this.routeName)
      : super(
            settings: RouteSettings(name: routeName),
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionDuration: Duration(milliseconds: 800),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
                      position: Tween<Offset>(
                              begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                          .animate(CurvedAnimation(
                              parent: animation, curve: Curves.fastOutSlowIn)),
                      child: child,
                    ));
}

/// 从中间展开路由
class SizeRoute extends PageRouteBuilder {
  final Widget page;
  final String routeName;

  SizeRoute(this.page, this.routeName)
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
//                Align(
//                  child: SizeTransition(child: child, sizeFactor: animation),
//                ),
              ScaleTransition(
            scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                parent: animation, curve: Curves.fastOutSlowIn)),
            child: child,
          ),
        );
}
