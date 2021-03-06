import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/ui/pages/launch/widget/animation_btn.dart';
import 'package:my_network_encapsulation/util/image/local_image_selector.dart';

/// @describe: 带有动画按钮的页面
/// @author: qds
/// @date:

// ignore: must_be_immutable
class AnimationPage extends StatefulWidget {
//设置一个标题
  AnimationBtn btn = new AnimationBtn(
    title: '开启新版',
  );

  @override
  _AnimationPageState createState() => new _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      // 中心对齐
      alignment: Alignment.center,
      children: <Widget>[
        new ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: LocalImageSelector.getImgByPhysicalSize('guide_page3'),
        ),
        Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment(0, 0.9),
              child: widget.btn,
            ))
      ],
    );
  }
}
