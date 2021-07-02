
/// 页面状态类型
enum ViewState {
  idle,
  busy,   //加载中
  empty,  //无数据
  error,  //加载失败
}

/// 错误类型
enum ViewStateErrorType {
  defaultError,
  networkTimeOutError,  //网络错误
  unauthorizedError     //未授权（一般是没有登录）
}

class ViewStateError {
  ViewStateErrorType _errorType;
  String message;
  String errorMessage;

  ViewStateError(this._errorType, {this.message, this.errorMessage}) {
    _errorType ??= ViewStateErrorType.defaultError;
    message ??= errorMessage;
  }

  ViewStateErrorType get errorType => _errorType;

  get isDefaultError => _errorType == ViewStateErrorType.defaultError;
  get isNetworkTimeOut => _errorType == ViewStateErrorType.networkTimeOutError;
  get isUnauthorized => _errorType == ViewStateErrorType.unauthorizedError;
}