import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/model/user.dart';
import 'package:my_network_encapsulation/provider/view_state_model.dart';
import 'package:my_network_encapsulation/res/keys.dart';
import 'package:my_network_encapsulation/view_model/user_model.dart';

const String loginNickName = 'loginNickName';

class LoginModel extends ViewStateModel {
  final UserModel userModel;

  LoginModel(this.userModel);

  /// 账号tc
  TextEditingController phone = TextEditingController();

  /// 密码tc
  TextEditingController password = TextEditingController();

  /// 验证码tc
  TextEditingController verificationCode = TextEditingController();

  /// 密码是否可见
  bool showPassword = false;

  /// 改变密码可见状态
  changeShow() {
    showPassword = !showPassword;
    notifyListeners();
  }

  /// 账号登陆
  loginWithPhone() async {
    setBusy();
    //调账号登陆接口
    try {
      var user = await RequestUtil.login('15015802692', 'qds123123', cancelTag: 'LoginPage');
      dealUser(user);
      LocalStorage.saveString(Keys.token, user.accessToken!);
      MyNavigator.pop();
      setIdle();
    } on DioError catch (e){
      if(e.error is SocketException){
        Toast.showMsg('请连接网络后重试');
      }
      setIdle();
    }
  }

  /// 微信登陆
  loginWithWeiXin() async {
    setBusy();
    await Future.delayed(Duration(seconds: 2), () {});
    try {
      //调微信登陆接口
      print('微信登陆成功');
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  /// 脸书登陆
  loginWithFaceBook() async {
    setBusy();
    await Future.delayed(Duration(seconds: 2), () {});
    try {
      //调脸书登陆接口
      print('脸书登陆成功');
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  /// 退出登陆
  Future<bool> logout() async {
    if (!userModel.hasUser) {
      //防止递归
      return false;
    }
    setBusy();
    try {
      /// 调退出登陆接口
      /// 清空数据
      userModel.clearUser();
      LocalStorage.remove(Keys.token);
      setIdle();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 保存用户登录信息
  dealUser(User user) {
    LocalStorage.saveString(loginNickName, user.nickName!);
    userModel.saveUser(user);
  }
}
