import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/model/user.dart';
import 'package:my_network_encapsulation/provider/view_state_model.dart';
import 'package:my_network_encapsulation/res/my_commons.dart';
import 'package:my_network_encapsulation/view_model/user_model.dart';

const String qLoginName = '';

class MyLoginModel extends ViewStateModel {
  final UserModel userModel;

  MyLoginModel(this.userModel);

  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

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
    try {
      //调账号登陆接口
      RequestUtil.login('15015802692', 'qds123123', cancelTag: '')
          .then((loginResult) {
        dealUser(loginResult.avatarUrl, loginResult.nickName);
        LocalStorage.saveString(MyCommons.TOKEN, loginResult.accessToken!);
        MyNavigator.pop();
        // MyNavigator.pushNamedAndRemoveUntil(RouteName.home);
        setIdle();
      }).catchError((e) {
        print(e);
        setIdle();
      });
    } catch (e, s) {
      setError(e, s);
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
    print('13456');
    if (!userModel.hasUser) {
      //防止递归
      return false;
    }
    setBusy();
    try {
      /// 调退出登陆接口
      /// 清空数据
      userModel.clearUser();
      LocalStorage.remove(MyCommons.TOKEN);
      setIdle();
      return true;
    } catch (e) {
      return false;
    }
  }

  dealUser(String? avatarUrl, String? nickName) {
    Map<String, dynamic> map = {"avatarUrl": avatarUrl, "nickName": nickName};
    print(map);
    LocalStorage.saveString(qLoginName, nickName!);
    userModel.saveUser(User.fromJsonMap(map));
  }
}
