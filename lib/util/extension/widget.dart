import 'package:my_network_encapsulation/base/base_insert.dart';

/// @author: qds
/// @describe: widget的扩展函数
class WidgetChain {
  // static Widget add

}

extension WidgetExt on Widget {
  Container intoContainer({Color? color}) {
    return Container(
        // width: 50,
        padding: EdgeInsets.symmetric(vertical: 28.w),
        alignment: Alignment.center,
        color: color,
        child: this);
  }
}
