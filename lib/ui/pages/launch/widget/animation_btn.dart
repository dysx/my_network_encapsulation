import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';

/// @describe: 带动画的字体按钮
/// @author: qds
/// @date:
// ignore: must_be_immutable
class AnimationBtn extends StatefulWidget {
  /// 按钮标题
  final String? title;

  late AnimationController controller;
  Animation<double>? animation;

  /// 开始动画方法
  void startAnimation() {
    if (controller == null) {
      return;
    }
    controller.forward();
  }

  AnimationBtn({Key? key, this.title}) : super(key: key);

  @override
  _AnimationBtnState createState() => new _AnimationBtnState();
}

class _AnimationBtnState extends State<AnimationBtn>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // 初始化动画控制器和动画
    // 配置控制器 动画持续时间
    widget.controller = new AnimationController(
        duration: const Duration(seconds: 2), vsync: this);

    // 动画描述,在持续时间内值的变化
    widget.animation =
        new Tween(begin: 0.0, end: 60.0).animate(widget.controller)
          ..addListener(() {
            //值发生变化后setsatate即可
            setState(() {});
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new OutlinedButton(
      onPressed: intoAppBtnClick,
      style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
      child: Text(
        widget.title!,
        style: new TextStyle(
            color: Color.fromRGBO(100, 10, 10, widget.animation!.value / 60)),
      ),
    );

    /// 动画开始后。在控制器中设定的时间内会不断调用addListener传递的方法
    /// 并且widget.animation.value会在持续时间内按照设定的开始和结束均匀变化,利用这个值设定渐变,位移等即可
  }

  /// 按钮的点击事件
  void intoAppBtnClick() {
    MyNavigator.pushNamedAndRemoveUntil(RouteName.home);
  }

  dispose() {
    // 路由销毁时需要释放动画资源
    widget.controller.dispose();
    super.dispose();
  }
}
