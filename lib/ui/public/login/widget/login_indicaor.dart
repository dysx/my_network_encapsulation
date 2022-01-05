import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/res/app_styles.dart';
import 'package:my_network_encapsulation/util/size_util.dart';

/// @describe: 登陆指示器
/// @author: qds
/// @date:
class LoginIndicator extends StatefulWidget {
  /// PageController
  final PageController pageController;

  LoginIndicator({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginIndicatorState();
}

class _LoginIndicatorState extends State<LoginIndicator> {
  StreamController<double> _streamController = StreamController<double>();

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(() {
      _streamController.sink.add(widget.pageController.page!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      height: 50.h,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 300.w,
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Color(0x552B2B2B)),
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => _toPage(0),
                      child: Center(
                        child: Text('登录',
                            style: AppTextStyles.sixteenBlack3333W500),
                      ),
                    )),
                    Expanded(
                        child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => _toPage(1),
                      child: Center(
                        child: Text('注册',
                            style: AppTextStyles.sixteenBlack3333W500),
                      ),
                    )),
                  ],
                ),
              )),
          Positioned(
            /// StreamBuilder刷新
            child: StreamBuilder<double>(
                stream: _streamController.stream,
                initialData: 0,
                builder: (context, snapshot) {
                  return Container(
                    width: 150.w,
                    height: 50.h,
                    margin: EdgeInsets.only(
                      left: left(snapshot.data!),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(snapshot.data! < 0.5 ? '登录' : '注册',
                          style: AppTextStyles.sixteenBlack3333W500),
                    ),
                  );
                }),
            left: 0,
          )
        ],
      ),
    );
  }

  double left(double page) {
    return 150.w * page;
  }

  void _toPage(int pageIndex) {
    widget.pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 200), curve: Curves.linear);
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }
}
