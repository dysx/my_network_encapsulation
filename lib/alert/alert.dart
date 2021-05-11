import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/config/application.dart';
import 'package:my_network_encapsulation/network/http/http_util.dart';
import 'package:my_network_encapsulation/routes/navigater.dart';

/// 弹框
typedef IndexCallback = void Function(int index);

class Alert {
  static bool isShowingAlert = false;

  /// 隐藏弹窗
  static hide() {
    if (!isShowingAlert) return;
    Navigater.pop();
    isShowingAlert = false;
  }

  /// 显示loading弹窗
  static showLoading({
    String message,
    bool mask = false,
    bool barrierDismissible = false,
  }) {
    if (isShowingAlert) return;
    isShowingAlert = true;

    showGeneralDialog(
      context: Application.globalKey.currentState.overlay.context,
      barrierDismissible: barrierDismissible,
      barrierLabel: '',
      barrierColor: mask ? Colors.red.withOpacity(0.3) : Colors.transparent,
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return WillPopScope(
          onWillPop: () async {
            hide();
            HttpUtils.cancelRequest();
            return Future.value(true);
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Center(
                child:
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                )
            ),
          ),
        );
      },
    );
  }

  /// 显示对话框
  static showAlert({
    String title,
    String message,
    String cancel,
    String confirm,
    bool showCancel = true,
    bool barrierDismissible = false,
    VoidCallback onCancel,
    VoidCallback onConfirm,
  }) {
    if (isShowingAlert) return;
    isShowingAlert = true;

    var _context = Application.globalKey.currentState.overlay.context;
    bool _isLight = Theme.of(_context).brightness == Brightness.light;

    showDialog(
        context: _context,
        barrierDismissible: barrierDismissible ?? false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              if (barrierDismissible != null && barrierDismissible) hide();
              return Future.value(false);
            },
            child: AlertDialog(
              title: Text(
                title ?? '提示',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF505050),
                  fontSize: 18.0,
                ),
              ),
              content: message != null && message.length > 0
                  ? Text(
                message,
                style: TextStyle(
                  color: Color(0xFF505050),
                  fontSize: 16.0,
                ),
              )
                  : SizedBox.shrink(),
              actions: <Widget>[
                showCancel
                    ? FlatButton(
                  child: Text(
                    cancel ?? '取消',
                    style: TextStyle(
                      color: Color(0xFF505050),
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () {
                    hide();
                    if (onCancel != null) onCancel();
                  },
                )
                    : SizedBox.shrink(),
                FlatButton(
                  child: Text(
                    confirm ?? '确定',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () {
                    hide();
                    if (onConfirm != null) onConfirm();
                  },
                ),
              ],
            ),
          );
        });
  }

  /// 显示进度对话框
  static Map<String, ValueNotifier> showProgressAlert({
    String title,
    String message,
    double progress,
    String cancel,
    String confirm,
    bool showCancel = false,
    bool showConfirm = false,
    bool barrierDismissible = false,
    VoidCallback onCancel,
    VoidCallback onConfirm,
  }) {
    if (isShowingAlert) return null;
    isShowingAlert = true;

    final ValueNotifier<double> _progressNotifier =
        ValueNotifier<double>(progress);
    final ValueNotifier<String> _messageNotifier =
        ValueNotifier<String>(message);

    var _context = Application.globalKey.currentState.overlay.context;
    bool _isLight = Theme.of(_context).brightness == Brightness.light;

    showDialog(
        context: _context,
        barrierDismissible: barrierDismissible ?? false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              if (barrierDismissible != null && barrierDismissible) hide();
              return Future.value(false);
            },
            child: AlertDialog(
              title: Text(
                title ?? '提示',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF505050),
                  fontSize: 18.0,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: ValueListenableBuilder(
                      valueListenable: _progressNotifier,
                      builder:
                          (BuildContext context, double value, Widget child) {
                        return CircularProgressIndicator(value: value);
                      },
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _messageNotifier,
                    builder:
                        (BuildContext context, String value, Widget child) {
                      return value != null && value.length > 0
                          ? Text(
                        value,
                        style: TextStyle(
                          color: Color(0xFF505050),
                          fontSize: 14.0,
                        ),
                      )
                          : SizedBox.shrink();
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                showCancel
                    ? FlatButton(
                  child: Text(
                    cancel ?? '取消',
                    style: TextStyle(
                      color: Color(0xFF505050),
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () {
                    hide();
                    if (onCancel != null) onCancel();
                  },
                )
                    : SizedBox.shrink(),
                showConfirm
                    ? FlatButton(
                  child: Text(
                    confirm ?? '确定',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () {
                    hide();
                    if (onConfirm != null) onConfirm();
                  },
                )
                    : SizedBox.shrink(),
              ],
            ),
          );
        });

    return {
      'progressNotifier': _progressNotifier,
      'messageNotifier': _messageNotifier
    };
  }

  /// 显示多项选择框
  static showSheet({
    String title,
    bool barrierDismissible = true,
    List<String> actions,
    IndexCallback onPressed,
  }) {
    if (isShowingAlert) return;
    isShowingAlert = true;

    var _context = Application.globalKey.currentState.overlay.context;
    bool _isLight = Theme.of(_context).brightness == Brightness.light;

    showDialog<String>(
      context: _context,
      barrierDismissible: barrierDismissible ?? true,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            if (barrierDismissible != null && barrierDismissible) hide();
            return Future.value(false);
          },
          child: SimpleDialog(
            title: Text(
              title ?? '请选择',
              style: TextStyle(
                color: Color(0xFF505050),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: actions != null && actions.length > 0
                ? actions
                .asMap()
                .map(
                  (index, action) => MapEntry(
                index,
                SimpleDialogOption(
                  onPressed: () {
                    hide();
                    if (onPressed != null) onPressed(index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      action,
                      style: TextStyle(
                          color: Color(0xFF505050), fontSize: 16.0),
                    ),
                  ),
                ),
              ),
            )
                .values
                .toList()
                : SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
