
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:my_network_encapsulation/ui/widget/skeleton.dart';
import 'package:my_network_encapsulation/view_model/article_model.dart';

class TestA extends BaseWidget {
  @override
  BaseWidgetState<BaseWidget> getState() => TestAState();
}

class TestAState extends BaseWidgetState<TestA>{
  RefreshController refreshController = RefreshController();

  @override
  Widget buildWidget(BuildContext context) {
    return ProviderWidget<ArticleModel>(
      model: ArticleModel(cancelTag: 'TestA'),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        if (model.isBusy) {
          // return ViewStateBusyWidget();
          return SkeletonList(
            // length: 20,
            builder: (context, index) => ArticleItemSkeleton(),
          );
        } else if (model.isEmpty) {
          print("model.isEmpty");
          return ViewStateEmptyWidget(onPressed: () => model.initData());
        } else if (model.isError) {
          print("model.isError");
          if (model.viewStateError!.isUnauthorized) {
            return ViewStateUnAuthWidget(onPressed: () async {
              var success =
                  await Navigator.of(context).pushNamed(RouteName.login);
              // 登录成功,获取数据,刷新页面
              if (success != null) {
                model.initData();
              }
            });
          } else if (model.list.isEmpty) {
            print(model.list.isEmpty);
            // 只有在页面上没有数据的时候才显示错误widget
            return ViewStateErrorWidget(
                error: model.viewStateError, onPressed: model.initData);
          }
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
                return GestureDetector(
                  onTap: () async {
                    await for(int i in countForOneMinute()) {
                      print(i);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    height: 20,
                    color: Colors.red,
                    child: Text(model.list[index].title!),
                  ),
                );
              },
            ));
      },
    );
  }

  @override
  void onCreate() {
    setAppBarTitle('testA');
    // TODO: implement onCreate
  }

  @override
  void onPause() {
    // TODO: implement onPause
  }

  @override
  void onResume() {
    // TODO: implement onResume
  }

  Stream<int> countForOneMinute() async* {
    for (int i = 1; i <= 5; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;//生成Stream的一个值
    }
  }

  get() async* {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(Duration(seconds: 1));
      yield getData();
    }
  }

  getData() {
    print('=======');
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class ArticleItemSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BottomBorderDecoration(),
        child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            title: UnconstrainedBox(
                alignment: Alignment.centerLeft,
                child: SkeletonBox(width: 80, height: 10)),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SkeletonBox(width: 180, height: 10),
            ),
            trailing: SkeletonBox(width: 50, height: 10)));
  }
}
