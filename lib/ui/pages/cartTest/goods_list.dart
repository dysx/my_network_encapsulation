import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/base/base_widget.dart';
import 'package:my_network_encapsulation/network/model/goods_entity.dart';
import 'package:my_network_encapsulation/ui/pages/test/testA.dart';
import 'package:my_network_encapsulation/ui/widget/skeleton.dart';
import 'package:my_network_encapsulation/view_model/cart_model.dart';
import 'package:my_network_encapsulation/view_model/favourite_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GoodsList extends BaseWidget {
  @override
  BaseWidgetState<BaseWidget> getState() => _GoodsListState();
}

class _GoodsListState extends BaseWidgetState<GoodsList> {
  @override
  Widget buildWidget(BuildContext context) {
    return ProviderWidget<FavouriteListModel>(
        model: FavouriteListModel(),
        onModelReady: (model) => model.initData(),
        builder: (context, model, child){
          if(model.isBusy) {
            return SkeletonList(builder: (context,index) => ArticleItemSkeleton());
          }
          return SmartRefresher(controller: model.refreshController,
          onRefresh: model.refresh,
          onLoading: model.loadMore,
          child: ListView.builder(
              itemCount: model.list.length,
              itemBuilder: (BuildContext context, int index) {
                // print('00000000${model.list[index].name}');
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
                    ordinaryButton(
                        text: model.list[index].collect! ? '减' : '加',
                        backgroundColor: model.list[index].collect! ? MyColors.blue_91ff : MyColors.yellow_ab00,
                        onPressed: model.list[index].collect!
                            ? () {
                          // favouriteModel.addFavourite(model.list[index].id!);
                          // var cart = context.read<CartModel>();
                          // cart.remove(goodsEntity);
                        }
                            : () {
                          // favouriteModel.removeFavorite(model.list[index].id!);
                          // var cart = context.read<CartModel>();
                          // cart.add(goodsEntity);
                        }
                    )
                  ],
                );
              }));
    });
  }

  @override
  void onCreate() {
    setAppBarTitle('testA');
    // TODO: implement onCreate
    // setTopBarBackColor(MyColors.background);
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
