import 'package:my_network_encapsulation/network/request_util.dart';
import 'package:my_network_encapsulation/provider/view_state.dart';
import 'package:my_network_encapsulation/provider/view_state_refresh_list_model.dart';

/// 文章
class ArticleModel extends ViewStateRefreshListModel {
  final String? cancelTag;

  ArticleModel({this.cancelTag});

  @override
  void onError(ViewStateError viewStateError) {
    if (viewStateError.isUnauthorized) {
      // loginModel.logout();
    }
    super.onError(viewStateError);
  }

  @override
  Future<List> loadData({int? pageIndex, int? pageSize}) async {
    return await RequestUtil.getRecommends(pageIndex!, pageSize!,
        cancelTag: cancelTag!);
  }
}
