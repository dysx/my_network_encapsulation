import 'package:my_network_encapsulation/network/model/get_recommends_entity.dart';
import 'package:my_network_encapsulation/network/request_util.dart';
import 'package:my_network_encapsulation/provider/view_state.dart';
import 'package:my_network_encapsulation/provider/view_state_refresh_list_model.dart';

/// 文章
class ArticleModel extends ViewStateRefreshListModel<GetRecommendsEntity> {
  @override
  void onError(ViewStateError viewStateError) {
    print("onError错误: ${viewStateError.errorType}");
    super.onError(viewStateError);
    // if (viewStateError.isUnauthorized) {
    //   loginModel.logout();
    // }
  }

  @override
  Future<List<GetRecommendsEntity>> loadData(
      {int pageIndex, int pageSize}) async {
      return await RequestUtil.getRecommends(pageIndex, pageSize)
          .catchError((e, s) {
            print('异常捕捉');
        setError(e, s);
      });
  }

}
