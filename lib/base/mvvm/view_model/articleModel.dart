
import 'package:my_network_encapsulation/base/mvvm/provider/view_state_refresh_list_model.dart';
import 'package:my_network_encapsulation/network/model/get_recommends_entity.dart';
import 'package:my_network_encapsulation/network/request_util.dart';

/// 文章
class ArticleModel extends ViewStateRefreshListModel<GetRecommendsEntity> {

  @override
  Future<List<GetRecommendsEntity>> loadData({int pageIndex, int pageSize}) async {
    // return [];
    return await RequestUtil.getRecommends(pageIndex, pageSize);
  }

}