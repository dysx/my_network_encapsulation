import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/config/appConfig.dart';
import 'package:my_network_encapsulation/model/user.dart';
import 'package:my_network_encapsulation/provider/view_state_model.dart';
import 'package:my_network_encapsulation/res/keys.dart';
import 'package:my_network_encapsulation/viewModel/message/user.dart';
import 'package:my_network_encapsulation/viewModel/user_model.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_user_full_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';

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

  /// 腾讯云im登陆
  loginTencentIm() async {
    setBusy();
    var data = TencentImSDKPlugin.v2TIMManager.login(
        userID: '127825',
        userSig:
            'eJwtjMsKwjAUBf8laynJ1bwK7hSbKpSoq*6siXIpmhCLCOK-G9ouz8xhvuR8OBVvn0hJoKBkMW50-jngDUfMQCrgs3m5-hIjOlKyFaVMySWHyQz48JkK0FJoqvlE-Sdiypwzlf90juA9d13PDAq5qes99xW0x2RlZ9zWBtWYKthdGzorYpPUdU1*f38pL8Q_');
    LocalStorage.saveString("sessionId", '56743877');
    LocalStorage.saveString("imToken", 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwaG9uZSI6IjE1MDE1ODAyNjkyIiwidXNlcklkIjoxMjc4MjUsIm5hbWUiOiIiLCJhdmF0YXIiOiJodHRwczovL2ltZ2NhY2hlLnFxLmNvbS9xY2xvdWQvcHVibGljL3N0YXRpYy8vYXZhdGFyNV8xMDAuMjAxOTEyMzAucG5nIiwiaWF0IjoxNjI5NzY5MDk1LCJleHAiOjE2MzIzNjEwOTV9.OV3pTR0US5CQiyv09wUUokU-yiHzcZmENE1j5LYVVrk');
    LocalStorage.saveString("phone", '15015802692');
    LocalStorage.saveString("code", '126972');
    V2TimValueCallback<List<V2TimUserFullInfo>> infos = await TencentImSDKPlugin.v2TIMManager.getUsersInfo(userIDList: ['127825']);
    await TencentImSDKPlugin.v2TIMManager
        .setSelfInfo(
        userFullInfo:
        V2TimUserFullInfo.fromJson({
          "nickName": '127825',
          "faceUrl": 'https://imgcache.qq.com/qcloud/public/static//avatar5_100.20191230.png',
        }));
    print('++++++');
    print(infos.desc);
    print(infos.code);
    print(infos.data);
    Provider.of<ImUserModel>(AppConfig.globalKey.currentContext!, listen: false)
        .setInfo(infos.data![0]);
    setIdle();
    MyNavigator.pop();
  }

  /// 账号登陆
  loginWithPhone() async {
    setBusy();
    //调账号登陆接口
    try {
      var user = await RequestUtil.login('15015802692', 'qds123123',
          cancelTag: 'LoginPage');
      dealUser(user);
      LocalStorage.saveString(Keys.token, user.accessToken!);
      MyNavigator.pop();
      setIdle();
    } on DioError catch (e) {
      if (e.error is SocketException) {
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
