import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/base/base_widget.dart';
import 'package:my_network_encapsulation/base/mvvm/provider/provider_widget.dart';
import 'package:my_network_encapsulation/base/mvvm/provider/view_state_widget.dart';
import 'package:my_network_encapsulation/base/mvvm/view_model/articleModel.dart';
import 'package:my_network_encapsulation/res/gaps.dart';
import 'package:my_network_encapsulation/res/my_colors.dart';
import 'package:my_network_encapsulation/routes/navigater.dart';
import 'package:my_network_encapsulation/routes/router_manger.dart';
import 'package:my_network_encapsulation/ui/common/button/outlined_button.dart';
import 'package:my_network_encapsulation/ui/widget/skeleton.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TestA extends BaseWidget {
  @override
  BaseWidgetState<BaseWidget> getState() => TestAState();
}

class TestAState extends BaseWidgetState<TestA> {
  RefreshController refreshController = RefreshController();

  @override
  Widget buildWidget(BuildContext context) {

    return SkeletonList(
      // length: 20,
      builder: (context, index) => ArticleItemSkeleton(),
    );

    return ProviderWidget<ArticleModel>(
      model: ArticleModel(),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        if (model.isBusy) {
          return SkeletonList(
            // length: 20,
            builder: (context, index) => ArticleItemSkeleton(),
          );
        } else if (model.isError && model.list.isEmpty) {
          return ViewStateErrorWidget(
              error: model.viewStateError,
              onPressed: () => model.initData());
        } else if (model.isEmpty) {
          return ViewStateEmptyWidget(onPressed: () => model.initData());
        }
        return SmartRefresher(
            controller: model.refreshController,
            header: WaterDropHeader(),
            onRefresh: model.refresh,
            onLoading: model.loadMore,
            enablePullUp: true,
            child: ListView.separated(
              padding: EdgeInsets.only(top: 0),
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (BuildContext context, int index) {
                return Gaps.hLine;
              },
              itemCount: model.list.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  height: 20,
                  color: Colors.red,
                  child: Text(model.list[index].title),
                );
              },
            ));
      },
    );

    return SingleChildScrollView(
        child: Column(
      children: [
        MyOutlinedButton(
          onPressed: () {
            Navigater.pushNamed(RouteName.testB);
          },
          text: "跳到b",
        ),
        ProviderWidget<ArticleModel>(
          model: ArticleModel(),
          onModelReady: (model) => model.initData(),
          builder: (context, model, child) {
            if (model.isBusy) {
              return SkeletonList(
                length: 11,
                builder: (context, index) => ArticleItemSkeleton(),
              );
            } else if (model.isError && model.list.isEmpty) {
              return ViewStateErrorWidget(
                  error: model.viewStateError,
                  onPressed: () => model.initData());
            } else if (model.isEmpty) {
              return ViewStateEmptyWidget(onPressed: () => model.initData());
            }
            return Container(
              height: 500,
              child: SmartRefresher(
                  controller: model.refreshController,
                  header: WaterDropHeader(),
                  onRefresh: model.refresh,
                  onLoading: model.loadMore,
                  enablePullUp: true,
                  child: ListView.separated(
                    padding: EdgeInsets.only(top: 0),
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) {
                      return Gaps.hLine;
                    },
                    itemCount: model.list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        height: 20,
                        color: Colors.red,
                        child: Text(model.list[index].title),
                      );
                    },
                  )),
            );
          },
        )
      ],
    ));
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

class ArticleItemSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BottomBorderDecoration(),
      child:
      ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          title: UnconstrainedBox(
              alignment: Alignment.centerLeft,
              child: SkeletonBox(width: 80, height: 10)),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SkeletonBox(width: 180, height: 10),
          ),
          trailing: SkeletonBox(width: 50, height: 10))

      // Container(
      //   height: 10,
      //   color: MyColors.background,
      // ),
    );
  }
}
