import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/base/base_inner_widget.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/ui/widget/bottom_clipper.dart';
import 'package:my_network_encapsulation/util/size_util.dart';
import 'package:my_network_encapsulation/view_model/base/cache_model.dart';
import 'package:my_network_encapsulation/view_model/my_login_model.dart';
import 'package:my_network_encapsulation/view_model/user_model.dart';

/// @describe: bottomNavItem_second页面
/// @author: qds
/// @date:

// ignore: must_be_immutable
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
            return ListTile(
              trailing: Wrap(
                children: [
                  Text(model.cache),
                  Gaps.hGap5,
                  Icon(
                    Icons.cleaning_services_rounded,
                  )
                ],
              ),
              title: Text('清除缓存'),
              // contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
              onTap: () {
                model.clearCache();
              },
            );
          },
        ),
        ListTile(
          trailing: Icon(Icons.login_outlined),
          title: Text('退出登陆'),
          onTap: () {
            MyLoginModel(Provider.of<UserModel>(context, listen: false))
                .logout()
                .then((value) {
              print('退出是否成功: $value');
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
            child: Consumer<UserModel>(
              builder: (context, userModel, child) {
                return userModel.hasUser
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                            ClipOval(
                              child: NetImage.cachedNetworkImage(
                                  imgUrl: userModel.user!.avatarUrl ?? '',width: 45.w,height: 45.w)
                            ),
                            Gaps.vGap10w,
                            Text('${userModel.user!.nickName}'),
                          ])
                    : Center(
                        child: GestureDetector(
                          onTap: () =>
                              MyNavigator.pushNamed(RouteName.loginPage),
                          child: Text('去登录'),
                        ),
                      );
              },
            )));
  }
}
