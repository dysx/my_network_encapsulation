import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/res/login_theme.dart' as theme;
import 'package:my_network_encapsulation/ui/public/login/widget/login_indicaor.dart';
import 'package:my_network_encapsulation/ui/widget/key_board_hider.dart';
import 'package:my_network_encapsulation/view_model/my_login_model.dart';

import 'sign_in_page.dart';
import 'sign_up_page.dart';

/// @describe: 登陆页面
/// @author: qds
/// @date:
class LoginPage extends BaseWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  BaseWidgetState<BaseWidget> getState() => new _LoginPageState();
}

class _LoginPageState extends BaseWidgetState<LoginPage> {
  PageController _pageController = PageController();

  @override
  Widget buildWidget(BuildContext context) {
    return KeyboardHider(
        child: SingleChildScrollView(
            child: Container(
                width: double.maxFinite,
                height: getScreenHeight(),
                // 设置渐变的背景
                decoration: new BoxDecoration(
                  gradient: theme.LoginTheme.primaryGradient,
                ),
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: getTopBarHeight()),
                    //顶部图片
                    // LocalImageSelector.getSingleImage('login_logo',
                    //     imageHeight: 191.h),
                    Gaps.vGap20h,
                    Expanded(
                      child: ProviderWidget<MyLoginModel>(
                        model: MyLoginModel(Provider.of(context)),
                        builder: (context, model, child) {
                          return Column(
                            children: [
                              LoginIndicator(pageController: _pageController),
                              Expanded(
                                  child: PageView(
                                controller: _pageController,
                                children: <Widget>[
                                  SignInPage(myLoginModel: model),
                                  SignUpPage(),
                                ],
                              ))
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ))));
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
    setTopBarVisible(false);
    setAppBarVisible(false);
    setBottomInset(isBottomInset: true);
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
