import 'package:my_network_encapsulation/base/my_base_widget.dart';


/// 这个管理类，只是标记 当前 按照顺序放入和移除栈名称，并不是页面跳转后退 的功能，
/// 只是方便 推算、表示生命周期方法，一般不需要修改
class NavigatorManger {
  List<String> _activityStack = [];

  NavigatorManger._internal();

  static NavigatorManger _singleton = new NavigatorManger._internal();

  //工厂模式
  factory NavigatorManger() => _singleton;
  void addWidget(MyBaseWidgetState widgetName) {
    _activityStack.add(widgetName.getClassName());
  }

  void removeWidget(MyBaseWidgetState widgetName) {
    _activityStack.remove(widgetName.getClassName());
  }

  bool isTopPage(MyBaseWidgetState widgetName) {
    if (_activityStack == null) {
      return false;
    }
    try {
      return widgetName.getClassName() ==
          _activityStack[_activityStack.length - 1];
    } catch (exception) {
      return false;
    }
  }

  bool isSecondTop(MyBaseWidgetState widgetName) {
    if (_activityStack == null) {
      return false;
    }
    try {
      return widgetName.getClassName() ==
          _activityStack[_activityStack.length - 2];
    } catch (exception) {
      return false;
    }
  }
}
