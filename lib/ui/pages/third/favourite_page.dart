import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/network/model/goods_entity.dart';
import 'package:my_network_encapsulation/ui/pages/third/goods_mock_data.dart';
import 'package:my_network_encapsulation/view_model/favourite_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @describe: 加入收藏的页面
/// @author: qds
/// @date:
class FavouritePage extends BaseWidget {
  FavouritePage({Key? key}) : super(key: key);

  @override
  BaseWidgetState<BaseWidget> getState() => new _FavouritePageState();
}

class _FavouritePageState extends BaseWidgetState<FavouritePage> {
  RefreshController _refreshController = RefreshController();

  @override
  Widget buildWidget(BuildContext context) {
    List<GoodsEntity> list = GoodsMockData.list(1, 20);
    return SmartRefresher(
      controller: _refreshController,
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.all(Dimens.gapDp15w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      NetImage.cachedNetworkImage(
                          imgUrl: list[index].imageUrl,
                          width: 50.w,
                          height: 50.w),
                      Gaps.hGap15,
                      Column(
                        children: [
                          Text('${list[index].name}'),
                          Gaps.vGap5w,
                          Text('${list[index].price}'),
                        ],
                      )
                    ],
                  ),
                ),
                Consumer<GlobalFavouriteStateModel>(
                  builder: (context, favouriteModel, child) {
                    //利用child局部刷新
                    if (favouriteModel[list[index].id!] == null) {
                      //本地没有此条数据收藏状态
                      return ordinaryButton(
                          text: list[index].collect! ? '已收藏' : '未收藏',
                          backgroundColor: list[index].collect!
                              ? MyColors.blue_91ff
                              : MyColors.yellow_ab00,
                          onPressed: () {
                            FavouriteModel(
                                    globalFavouriteModel:
                                        Provider.of(context, listen: false))
                                .collect(list[index]);
                          });
                    }
                    //选择本地收藏状态
                    list[index]..collect = favouriteModel[list[index].id!];
                    return ordinaryButton(
                        text: list[index].collect! ? '已收藏' : '未收藏',
                        backgroundColor: list[index].collect!
                            ? MyColors.blue_91ff
                            : MyColors.yellow_ab00,
                        onPressed: () {
                          FavouriteModel(
                                  globalFavouriteModel:
                                      Provider.of(context, listen: false))
                              .collect(list[index]);
                        });
                  },
                )
              ],
            );
          }),
    );
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
    setAppBarTitle('');
    setBackground(MyColors.white);
  }

  @override
  void onPause() {
    // TODO: implement onPause
  }

  @override
  void onResume() {
    // TODO: implement onResume
  }
}
