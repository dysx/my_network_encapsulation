import 'package:my_network_encapsulation/network/model/get_recommends_entity.dart';
import 'package:my_network_encapsulation/network/request_util.dart';
import 'package:my_network_encapsulation/provider/view_state.dart';
import 'package:my_network_encapsulation/provider/view_state_refresh_list_model.dart';

/// 文章
class ArticleModel extends ViewStateRefreshListModel {

  final String? cancelTag;

  ArticleModel({this.cancelTag});

  @override
  void onError(ViewStateError viewStateError) {
    print("onError错误: ${viewStateError.errorType}");
    super.onError(viewStateError);
    // if (viewStateError.isUnauthorized) {
    //   loginModel.logout();
    // }
  }

  @override
  Future<List> loadData(
      {int? pageIndex, int? pageSize}) async {
    // List<GetRecommendsEntity> list = [];
    // list = await RequestUtil.getRecommends(pageIndex!, pageSize!,cancelTag: cancelTag!)
    //     .catchError((e, s) {
    //   print('异常捕捉');
    //   print('$e,$s');
    //   setError(e, s);
    // });
    // return list;
    // return list;
      return await RequestUtil.getRecommends(pageIndex!, pageSize!,cancelTag: cancelTag!)
          .catchError((e, s) {
            print('异常捕捉');
            print('$e,$s');
        setError(e, s);
      });
  }

}
