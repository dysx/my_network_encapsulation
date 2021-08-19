import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_network_encapsulation/generated/l10n.dart';
import 'package:my_network_encapsulation/provider/view_state.dart';
import 'package:my_network_encapsulation/util/log_utils.dart';
import 'package:my_network_encapsulation/util/toast.dart';

/// @describe: model状态基类
/// @author: qds
/// @date:
class ViewStateModel with ChangeNotifier {
  /// 防止页面销毁后，异步任务才完成，导致报错
  bool _disposed = false;

  /// 当前的页面状态，默认为busy，可在viewModel的构造方法中指定
  ViewState _viewState;

  /// 根据状态构造
  /// 子类可以在构造函数指定需要的页面状态
  /// FooModel():super(viewState:ViewState.busy);
  ViewStateModel({ViewState? viewState})
      : _viewState = viewState ?? ViewState.idle {
    // debugPrint('ViewStateModel---constructor--->$runtimeType');
  }

  /// ViewState
  ViewState get viewState => _viewState;

  set viewState(ViewState viewState) {
    _viewStateError = null;
    _viewState = viewState;
    notifyListeners();
  }

  /// ViewStateError
  ViewStateError? _viewStateError;

  ViewStateError? get viewStateError => _viewStateError;

  /// get
  bool get isIdle => viewState == ViewState.idle;

  bool get isBusy => viewState == ViewState.busy;

  bool get isEmpty => viewState == ViewState.empty;

  bool get isError => viewState == ViewState.error;

  /// set
  void setIdle() {
    viewState = ViewState.idle;
  }

  void setBusy() {
    viewState = ViewState.busy;
  }

  void setEmpty() {
    viewState = ViewState.empty;
  }

  /// [e]分类Error和Exception两种
  void setError(e, stackTrace, {String? message}) {
    ViewStateErrorType errorType = ViewStateErrorType.defaultError;
    print('错误详情信息: $e');

    /// 见https://github.com/flutterchina/dio/blob/master/README-ZH.md#dioerrortype
    if (e is DioError) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        errorType = ViewStateErrorType.networkTimeOutError;
        message = e.error;
      } else if (e.type == DioErrorType.response) {
        message = e.error;
      } else if (e.type == DioErrorType.cancel) {
        message = e.error;
      } else {
        if (e.error is SocketException) {
          errorType = ViewStateErrorType.networkTimeOutError;
          message = e.message;
          print(message);
        } else {
          message = e.message;
        }
      }
    }
    print(errorType);
    viewState = ViewState.error;
    _viewStateError = ViewStateError(errorType,
        message: '',
        // message: message,
        errorMessage: e.toString());
    printErrorStack(e, stackTrace);
    onError(viewStateError!);
  }

  void onError(ViewStateError viewStateError) {}

  /// 显示错误消息
  showErrorMessage(context, {String? message}) {
    if (viewStateError != null || message != null) {
      if (viewStateError!.isNetworkTimeOut) {
        message ??= S.of(context).viewStateMessageNetworkError;
      } else {
        message ??= viewStateError!.message;
      }
      Future.microtask(() {
        Toast.showMsg(message!);
      });
    }
  }

  @override
  String toString() {
    return 'BaseModel{_viewState: $viewState, _viewStateError: $_viewStateError}';
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    // debugPrint('view_state_model dispose -->$runtimeType');
    super.dispose();
  }
}

/// [e]为错误类型 :可能为 Error , Exception ,String
/// [s]为堆栈信息
printErrorStack(e, s) {
  debugPrint('''
<-----↓↓↓↓↓↓↓↓↓↓-----erroreee-----↓↓↓↓↓↓↓↓↓↓----->
$e
<-----↑↑↑↑↑↑↑↑↑↑-----error-----↑↑↑↑↑↑↑↑↑↑----->''');
  if (s != null) debugPrint('''
<-----↓↓↓↓↓↓↓↓↓↓-----trace-----↓↓↓↓↓↓↓↓↓↓----->
$s
<-----↑↑↑↑↑↑↑↑↑↑-----trace-----↑↑↑↑↑↑↑↑↑↑----->
    ''');
}
