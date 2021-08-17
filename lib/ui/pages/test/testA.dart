import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flutter_mvideo_plugin/flutter_mvideo_plugin.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/ui/widget/skeleton.dart';
import 'package:my_network_encapsulation/view_model/article_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TestA extends BaseWidget {
  @override
  BaseWidgetState<BaseWidget> getState() => TestAState();
}

class TestAState extends BaseWidgetState<TestA> {
  RefreshController refreshController = RefreshController();

  /// 视频
  // late MVideoPlayer videoPlayer;
  // late MVideoPlayerController mVideoController;

  @override
  Widget buildWidget(BuildContext context) {
    // return Container(height: getScreenWidth() * 9.0 / 16.0, child: videoPlayer);

    return Container(
      color: Colors.blue,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedTextKit(animatedTexts: [
            TypewriterAnimatedText('我爱学习'),
            // TyperAnimatedText('我爱'),
            // TyperAnimatedText('我爱学'),
            // TyperAnimatedText('我爱学习')
          ])
        ],
      ),
    );

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
                  await Navigator.of(context).pushNamed(RouteName.loginPage);
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
                return Gaps.vGap5w;
              },
              itemCount: model.list.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: Duration(milliseconds: 375),
                    child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                            child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          height: 60,
                          color: AppColors.grey_9999,
                        ))));
              },
            ));
      },
    );
  }

  @override
  void onCreate() {
    setAppBarTitle('testA');
    // _initVideo();
  }

  @override
  void onPause() {
    // TODO: implement onPause
  }

  @override
  void onResume() {
    // TODO: implement onResume
  }

  // void _initVideo() {
  //   double x = 0.0;
  //   double y = 0.0;
  //   var width = getScreenWidth();
  //   var height = width * 9.0 / 16.0;
  //   videoPlayer = MVideoPlayer(
  //       onCreated: _createPlayerView, x: x, y: y, width: width, height: height);
  // }
  //
  // void _createPlayerView(MVideoPlayerController videoController) {
  //   this.mVideoController = videoController;
  //   this
  //       .mVideoController
  //       .loadUrl('http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4', 'https://img10.360buyimg.com/ddimg/jfs/t1/196622/32/15344/79769/61012148E85f8e012/13a997ee2e6d36ba.jpg');
  // }

  Stream<int> countForOneMinute() async* {
    for (int i = 1; i <= 5; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield i; //生成Stream的一个值
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
