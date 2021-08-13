import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/res/my_theme.dart' as theme;
import 'package:my_network_encapsulation/util/size_util.dart';
import 'package:my_network_encapsulation/view_model/my_login_model.dart';

/// @describe: 登陆页面
/// @author: qds
/// @date:
// ignore: must_be_immutable
class SignInPage extends StatefulWidget {
  MyLoginModel myLoginModel;

  SignInPage({required this.myLoginModel});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>
    with AutomaticKeepAliveClientMixin {
  /// 利用FocusNode和FocusScopeNode来控制焦点
  /// 可以通过FocusNode.of(context)来获取widget树中默认的FocusScopeNode
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  bool isShowPassWord = false;

  MyLoginModel get loginModel => widget.myLoginModel;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 23, bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[_inputWrap(), _bottomWrap()],
        ));
  }

  Widget _inputWrap() {
    return Column(
      children: [
        buildSignInTextForm(),
        Gaps.vGap15w,
        buildSignInButton(),
      ],
    );
  }

  Widget _bottomWrap() {
    return Column(
      children: [
        Text(
          "忘记密码?",
          style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              decoration: TextDecoration.underline),
        ),
        Gaps.vGap10h,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 1,
              width: 100.w,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.white10,
                Colors.white,
              ])),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "Or",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            Container(
              height: 1,
              width: 100.w,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.white,
                Colors.white10,
              ])),
            ),
          ],
        ),
        Gaps.vGap10h,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.weixin,
                    color: Color(0xFF0084ff),
                  ),
                  onPressed: () async {
                    if (loginModel.isIdle) {
                      print('点击了微信登陆');
                      loginModel.loginWithWeiXin();
                    }
                  }),
            ),
            SizedBox(
              width: 40,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.facebookF,
                    color: Color(0xFF0084ff),
                  ),
                  onPressed: () async {
                    if (loginModel.isIdle) {
                      print('点击了脸书登陆');
                      loginModel.loginWithFaceBook();
                    }
                  }),
            ),
          ],
        )
      ],
    );
  }

  /// 创建登录界面的TextForm
  Widget buildSignInTextForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.gapDp15w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      width: 300.w,
      // height: 180.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: Dimens.gapDp10w),
              child: TextField(
                controller: loginModel.phone,
                focusNode: emailFocusNode,
                onChanged: (email) {},
                decoration: InputDecoration(
                    icon: Icon(Icons.phone, color: Colors.black),
                    hintText: '请输入手机号',
                    border: InputBorder.none),
              ),
            ),
          ),
          Gaps.hLine,
          Flexible(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: Dimens.gapDp10w),
                child: TextField(
                  controller: loginModel.password,
                  focusNode: passwordFocusNode,
                  onChanged: (password) {},
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      hintText: "请输入密码",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.black,
                          ),
                          onPressed: () => loginModel.changeShow())),
                  obscureText: loginModel.showPassword,
                )),
          ),
        ],
      ),
    );
  }

  /// 创建登录界面的按钮
  Widget buildSignInButton() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          gradient: theme.MyTheme.primaryGradient,
        ),
        child: loginModel.isBusy
            ? SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  value: null,
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      theme.MyTheme.loginGradientStart),
                ),
              )
            : Text(
                "登录",
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
      ),
      onTap: () {
        loginModel.loginWithPhone();
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
