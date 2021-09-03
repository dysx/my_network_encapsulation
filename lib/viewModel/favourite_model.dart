
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/model/goods_entity.dart';
import 'package:my_network_encapsulation/provider/view_state.dart';
import 'package:my_network_encapsulation/provider/view_state_model.dart';
import 'package:my_network_encapsulation/provider/view_state_refresh_list_model.dart';
import 'package:my_network_encapsulation/ui/pages/third/goods_mock_data.dart';
import 'package:my_network_encapsulation/viewModel/cart_model.dart';

/// 我的收藏列表
class FavouriteListModel extends ViewStateRefreshListModel<GoodsEntity> {

  final String? cancelTag;

  FavouriteListModel({this.cancelTag});

  @override
  void onError(ViewStateError viewStateError) {
    super.onError(viewStateError);
    // if (viewStateError.isUnauthorized) {
    //   loginModel.logout();
    // }
  }

  @override
  Future<List<GoodsEntity>> loadData(
      {int? pageIndex, int? pageSize}) async {
    await Future.delayed(Duration(seconds: 1),(){});
    return GoodsMockData.list(pageIndex!, pageSize!);
  }

  @override
  onCompleted(List<GoodsEntity> data) {
    // TODO: implement onCompleted
    GlobalFavouriteStateModel.refresh(data);
  }
}

/// 收藏/取消收藏
class FavouriteModel extends ViewStateModel {
  GlobalFavouriteStateModel globalFavouriteModel;

  FavouriteModel({required this.globalFavouriteModel});

  collect(GoodsEntity goods) async {
    setBusy();
    try {
      if (goods.collect!) {
        //取消收藏接口
        // await WanAndroidRepository.unCollect(article.id);
        globalFavouriteModel.removeFavourite(goods.id!);
      } else {
        //收藏接口
        // await WanAndroidRepository.collect(article.id);
        globalFavouriteModel.addFavourite(goods.id!);
      }
      // article.collect 字段为null,代表是从我的收藏页面进入的 需要调用特殊的取消接口
      // if (goods.collect == null) {
      //   //取消收藏接口
      //   // await WanAndroidRepository.unMyCollect(
      //   //     id: article.id, originId: article.originId);
      //   globalFavouriteModel.removeFavourite(goods.id!);
      // } else {
      //   if (goods.collect!) {
      //     //取消收藏接口
      //     // await WanAndroidRepository.unCollect(article.id);
      //     globalFavouriteModel.removeFavourite(goods.id!);
      //   } else {
      //     //收藏接口
      //     // await WanAndroidRepository.collect(article.id);
      //     globalFavouriteModel.addFavourite(goods.id!);
      //   }
      // }
      goods.collect = !(goods.collect ?? true);
      setIdle();
    } catch (e, s) {
      print('收藏错误信息: ${e}');
      setError(e, s);
    }
  }
}

///全局维护状态是否收藏
class GlobalFavouriteStateModel extends ChangeNotifier {
  /// 将页面列表项中所有的收藏状态操作结果存储到集合中
  ///
  /// [key]为articleId,[value]为bool类型，代表是否收藏
  ///
  /// 设置static的目的是，列表更新时，刷新该map中的值
  static final Map<int, bool> _map = Map();

  /// 列表数据刷新后，同步刷新该map的值
  ///
  /// 在其他终端（如pc端）收藏/取消收藏后，会导致两边状态不一致
  /// 列表页面刷新后，应该将新的收藏状态同步更新到map中
  static refresh(List<GoodsEntity> list){
    print(list.length);
    list.forEach((article) {
      if (_map.containsKey(article.id)) {
        _map[article.id!] = article.collect!;
      }
    });
    print(_map);
  }

  addFavourite(int id) {
    _map[id] = true;
    notifyListeners();
  }

  removeFavourite(int id) {
    _map[id] = false;
    notifyListeners();
  }

  /// 用于切换用户后，清空状态
  clearFavourite() {
    _map.clear();
  }

  /// 用于切换用户后，将该用户所有收藏的文章，对应的状态设置为true
  replaceAll(List ids) {
    _map.clear();
    ids.forEach((id) => _map[id] = true );
    notifyListeners();
  }

  contains(id) {
    return _map.containsKey(id);
  }

  operator [](int id) {
    return _map[id];
  }

}