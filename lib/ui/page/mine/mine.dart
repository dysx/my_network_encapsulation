import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/base/base_inner_widget.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/ui/widget/bottom_clipper.dart';
import 'package:my_network_encapsulation/util/local_image_selector.dart';
import 'package:my_network_encapsulation/util/size_util.dart';
import 'package:my_network_encapsulation/view_model/base/cache_model.dart';

class Mine extends BaseInnerWidget {
  @override
  BaseInnerWidgetState<BaseInnerWidget> getState() => MineState();

  @override
  int setIndex() => 3;
}

class MineState extends BaseInnerWidgetState<Mine> {
  @override
  Widget buildWidget(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 304.h,
          child: UserHeaderWidget(),
        ),
        ProviderWidget<CacheModel>(
          model: CacheModel(),
          onModelReady: (model) => model.initCache(),
          builder: (context, model, child) {
            if (model.isBusy) {
              return SizedBox();
            }
            return ordinaryButton(
                text: model.cache,
                onPressed: () {
                  model.clearCache();
                });
          },
        )
      ],
    );
  }

  @override
  double getVerticalMargin() => 0;

  @override
  void onCreate() async {
    setTopBarVisible(false);
    setAppBarVisible(false);
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

class UserHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: BottomClipper(),
        child: Container(
            color: Theme.of(context).primaryColor.withAlpha(200),
            // padding: EdgeInsets.only(top: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: Hero(
                      tag: 'loginLogo',
                      child: ClipOval(
                        child: LocalImageSelector.getSingleImage('setting'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(children: <Widget>[
                    Text('double'),
                    SizedBox(
                      height: 10,
                    ),
                  ])
                ])));
  }
}
