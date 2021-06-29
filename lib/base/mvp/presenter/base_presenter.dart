import 'package:dio/dio.dart';
import 'package:my_network_encapsulation/base/mvp/presenter/i_presenter.dart';
import 'package:my_network_encapsulation/base/mvp/view/i_base_view.dart';
import 'package:my_network_encapsulation/network/request_util.dart';

class BasePresenter<V extends IBaseView> extends IPresenter {
  V view;

  //取消网络请求
  CancelToken _cancelToken;

  BasePresenter() {
    _cancelToken = CancelToken();
  }

  @override
  void deactivate() {}

  @override
  void didChangeDependencies() {}

  @override
  void didUpdateWidget<W>(W oldWidget) {}

  @override
  void dispose() {
    if(_cancelToken.isCancelled){
      _cancelToken.cancel();
    }
  }

  @override
  void initState() {}

  Future requestDataFromNetwork<T>() async {
    // await RequestUtil.
  }

}
