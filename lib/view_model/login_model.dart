

import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/model/user.dart';
import 'package:my_network_encapsulation/provider/view_state_model.dart';

import 'user_model.dart';

const String qLoginName = 'qLoginName';

class LoginModel extends ViewStateModel {
  final UserModel userModel;

  LoginModel(this.userModel);

  String getLoginName() {
    return LocalStorage.get(qLoginName)!;
  }

  Future<bool> login(loginName, password) async {
    setBusy();
    try {
      //接口登陆
      // var user = await WanAndroidRepository.login(loginName, password);
      Map<String,dynamic> map = {
        "id": 222,
        "nickname": 'double'
      };
      userModel.saveUser(User.fromJsonMap(map));
      LocalStorage.saveString(qLoginName, userModel.user!.nickname);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e,s);
      return false;
    }
  }

  Future<bool> logout() async {
    if (!userModel.hasUser) {
      //防止递归
      return false;
    }
    setBusy();
    try {
      //接口退出登陆
      // await WanAndroidRepository.logout();
      userModel.clearUser();
      setIdle();
      return true;
    } catch (e, s) {
      setError(e,s);
      return false;
    }
  }
}
