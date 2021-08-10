
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/network/model/goods_entity.dart';
import 'package:my_network_encapsulation/ui/pages/cartTest/mock/goods_mock_data.dart';
import 'package:my_network_encapsulation/ui/pages/test/testA.dart';
import 'package:my_network_encapsulation/ui/widget/skeleton.dart';
import 'package:my_network_encapsulation/view_model/favourite_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @name：团队介绍
class FavouritePage extends BaseWidget {

  FavouritePage({Key? key}):super(key: key);

  @override
  BaseWidgetState<BaseWidget> getState() => new _FavouritePageState();
}

class _FavouritePageState extends BaseWidgetState<FavouritePage> {

  RefreshController _refreshController = RefreshController();

  @override
  Widget buildWidget(BuildContext context) {

    List<GoodsEntity> list = GoodsMockData.list(1, 20);
    return SmartRefresher(controller: _refreshController,
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.all(Dimens.gapDp15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      NetImage.cachedNetworkImage(imgUrl: list[index].imageUrl,width: 50.w,height: 50.w),
                      Gaps.hGap15,
                      Column(
                        children: [
                          Text('${list[index].name}'),
                          Gaps.vGap5,
                          Text('${list[index].price}'),
                        ],
                      )
                    ],
                  ),
                ),
                Consumer<GlobalFavouriteStateModel>(
                  builder: (context, favouriteModel, child) {
                    print('监听到刷新: $index ${favouriteModel[list[index].id!]}');
                    //利用child局部刷新
                    if (favouriteModel[list[index].id!] == null) {
                      //本地没有此条数据收藏状态
                      return ordinaryButton(
                          text: list[index].collect! ? '已收藏' : '未收藏',
                          backgroundColor: list[index].collect! ? MyColors.blue_91ff : MyColors.yellow_ab00,
                          onPressed: (){
                            // print(favouriteModel);
                            FavouriteModel(globalFavouriteModel: Provider.of(context,listen: false)).collect(list[index]);
                          }
                      );
                    }
                    //选择本地收藏状态
                    list[index]..collect = favouriteModel[list[index].id!];
                    return ordinaryButton(
                        text: list[index].collect! ? '已收藏' : '未收藏',
                        backgroundColor: list[index].collect! ? MyColors.blue_91ff : MyColors.yellow_ab00,
                        onPressed: (){
                          // print(Provider.of(context,listen: false));
                          FavouriteModel(globalFavouriteModel: Provider.of(context,listen: false)).collect(list[index]);
                        }
                    );
                  },
                  // child: ordinaryButton(
                  //     text: '是否收藏111',
                  //     backgroundColor: model.list[index].collect! ? MyColors.blue_91ff : MyColors.yellow_ab00,
                  //     onPressed: (){
                  //       print(Provider.of(context,listen: false));
                  //       // FavouriteModel(globalFavouriteModel: Provider.of(context,listen: false)).collect(model.list[index]);
                  //     }
                  // ),
                )
              ],
            );
          }),
    );

    return ProviderWidget<FavouriteListModel>(
        model: FavouriteListModel(),
        onModelReady: (model) async {
          await model.initData();
        },
        builder: (context,FavouriteListModel model,child){
          if(model.isBusy) {
            return SkeletonList(builder: (context,index) => ArticleItemSkeleton());
          }
          return SmartRefresher(controller: model.refreshController,
          onRefresh: model.refresh,
            onLoading: model.loadMore,
            enablePullUp: true,
            child: ListView.builder(
                itemCount: model.list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.all(Dimens.gapDp15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            NetImage.cachedNetworkImage(imgUrl: model.list[index].imageUrl,width: 50.w,height: 50.w),
                            Gaps.hGap15,
                            Column(
                              children: [
                                Text('${model.list[index].name}'),
                                Gaps.vGap5,
                                Text('${model.list[index].price}'),
                              ],
                            )
                          ],
                        ),
                      ),
                      Consumer<GlobalFavouriteStateModel>(
                        builder: (context, favouriteModel, child) {
                          print('收藏状态: $index ${favouriteModel[model.list[index].id!]}');
                          //利用child局部刷新
                          if (favouriteModel[model.list[index].id!] == null) {
                            //本地没有此条数据收藏状态
                            return ordinaryButton(
                                text: model.list[index].collect! ? '已收藏' : '未收藏',
                                backgroundColor: model.list[index].collect! ? MyColors.blue_91ff : MyColors.yellow_ab00,
                                onPressed: (){
                                  // print(favouriteModel);
                                  FavouriteModel(globalFavouriteModel: Provider.of(context,listen: false)).collect(model.list[index]);
                                }
                            );
                          }
                          //选择本地收藏状态
                          model.list[index]..collect = favouriteModel[model.list[index].id!];
                          return ordinaryButton(
                              text: model.list[index].collect! ? '已收藏' : '未收藏',
                              backgroundColor: model.list[index].collect! ? MyColors.blue_91ff : MyColors.yellow_ab00,
                              onPressed: (){
                                // print(Provider.of(context,listen: false));
                                FavouriteModel(globalFavouriteModel: Provider.of(context,listen: false)).collect(model.list[index]);
                              }
                          );
                        },
                        // child: ordinaryButton(
                        //     text: '是否收藏111',
                        //     backgroundColor: model.list[index].collect! ? MyColors.blue_91ff : MyColors.yellow_ab00,
                        //     onPressed: (){
                        //       print(Provider.of(context,listen: false));
                        //       // FavouriteModel(globalFavouriteModel: Provider.of(context,listen: false)).collect(model.list[index]);
                        //     }
                        // ),
                      )
                    ],
                  );
                }),
          );
        });
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