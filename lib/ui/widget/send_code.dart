import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/res/app_colors.dart';

/// @describe: 发送验证码组件
/// @author: qds
/// @date:
class SendCode extends StatefulWidget {
  SendCode({
    required this.phone,
  });

  final String phone;

  @override
  _SendCodeState createState() => _SendCodeState();
}

class _SendCodeState extends State<SendCode> {
  /// 按钮状态  是否可点击
  bool isButtonEnable = true;

  /// 初始文本
  String buttonText = '发送验证码';

  /// 初始倒计时时间
  int count = 60;

  /// 倒计时的计时器
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ordinaryButton(
            radius: 18,
            padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 15.w),
            text: isButtonEnable ? buttonText : "已发送${count}s",
            textStyle: AppTextStyles.fourteenWhite,
            onPressed: () => isButtonEnable ? _getSmsCode() : null,
            backgroundColor:
                !isButtonEnable ? AppColors.grey_9999 : AppColors.blue_91ff)
      ],
    );
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  /// 发送验证码按钮点击
  void _buttonClickListen() {
    if (isButtonEnable) {
      //当按钮可点击时
      setState(() {
        isButtonEnable = false; //按钮状态标记
      });
      _initTimer();
    }
  }

  /// 进行倒计或者重置
  void _initTimer() {
    timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      count--;
      setState(() {
        if (count == 0) {
          timer.cancel(); //倒计时结束取消定时器
          isButtonEnable = true; //按钮可点击
          count = 60; //重置时间
        }
      });
    });
  }

  /// 请求手机验证码
  void _getSmsCode() async {
    //发送验证码接口
    // print(widget.phoneNumber);
    // await RequestUtil.getSmsCode(widget.baseIntercept, widget.phone).then((res) {
    //   _buttonClickListen();
    // });
    _buttonClickListen();
  }
}
