import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/res/my_theme.dart' as theme;
import 'package:my_network_encapsulation/ui/public/login/widget/login_indicaor.dart';
import 'package:my_network_encapsulation/ui/widget/key_board_hider.dart';
import 'package:my_network_encapsulation/view_model/login_model.dart';

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
  late PageController _pageController;
  late PageView _pageView;

  @override
  Widget buildWidget(BuildContext context) {
    return KeyboardHider(
        child: SingleChildScrollView(
            child: Container(
                width: double.maxFinite,
                height: getScreenHeight(),
                // 设置渐变的背景
                decoration: new BoxDecoration(
                  gradient: theme.MyTheme.primaryGradient,
                ),
                child: new Column(
                  children: <Widget>[
                    SizedBox(height: getTopBarHeight()),
                    //顶部图片
                    LocalImageSelector.getSingleImage('login_logo',
                        imageHeight: 191.h),
                    Gaps.vGap20,
                    LoginIndicator(pageController: _pageController),
                    new Expanded(child: _pageView),
                  ],
                ))));

    return ProviderWidget<LoginModel>(
        model: LoginModel(Provider.of(context)),
        builder: (context, model, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(),
              TextField(),
              ordinaryButton(
                  text: '登陆',
                  backgroundColor: MyColors.blue_91ff,
                  onPressed: () {
                    model.login('123', '456').then((value) {
                      print(value);
                    });
                  })
            ],
          );
        });
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
    setTopBarVisible(false);
    setAppBarVisible(false);
    setBottomInset(isBottomInset: true);

    _pageController = PageController();
    _pageView = PageView(
      controller: _pageController,
      children: <Widget>[
        SignInPage(),
        SignUpPage(),
      ],
    );
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
