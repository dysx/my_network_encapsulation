import 'package:my_network_encapsulation/base/a_base_widget.dart';
import 'package:my_network_encapsulation/base/base_widget.dart';

/// @describe: 这个管理类，只是标记 当前 按照顺序放入和移除栈名称，并不是页面跳转后退 的功能，
/// 只是方便 推算、表示生命周期方法，一般不需要修改
///
/// @author: qds
/// @date:
class NavigatorManger {
  static List<String> activityStack = [];

  NavigatorManger._internal();

  static NavigatorManger _singleton = new NavigatorManger._internal();

  //工厂模式
  factory NavigatorManger() => _singleton;

  static void addWidget(String widgetName) {
    activityStack.add(widgetName);
  }

  static void removeWidget(String widgetName) {
    activityStack.remove(widgetName);
  }

  static bool isTopPage(String widgetName) {
    print('isTopPage111: $widgetName');
    print('isTopPage222: ${activityStack[activityStack.length - 1]}');
    if (activityStack.isEmpty) {
      return false;
    }
    try {
      return widgetName == activityStack[activityStack.length - 1];
    } catch (exception) {
      return false;
    }
  }

  static bool isSecondTop(String widgetName) {
    if (activityStack.isEmpty) {
      return false;
    }
    try {
      return widgetName ==
          activityStack[activityStack.length - 2];
    } catch (exception) {
      return false;
    }
  }
}
