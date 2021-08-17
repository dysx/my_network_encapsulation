import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/res/app_styles.dart';
import 'package:oktoast/oktoast.dart';

/// @describe: 吐司工具
/// @author: qds
/// @date:
class Toast {
  static showMsg(String msg, {duration = 2000}) {
    showToast(msg, duration: Duration(milliseconds: duration));
  }

  static showWidget(Widget widget, {duration = 2000}) {
    showToastWidget(widget,
        duration: Duration(milliseconds: duration),
        position: ToastPosition.bottom);
  }

  static showMsgExit(String msg, {duration = 2000}) {
    showToast(msg,
        duration: Duration(milliseconds: duration),
        backgroundColor: Colors.transparent,
        textStyle: AppTextStyles.fourteenBlack3333);
  }

  static dismiss() {
    dismissAllToast();
  }
}
