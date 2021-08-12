import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/model/user.dart';

import 'favourite_model.dart';

/// 用户model
class UserModel extends ChangeNotifier {
  static const String qUser = 'qUser';

  final GlobalFavouriteStateModel globalFavouriteStateModel = GlobalFavouriteStateModel();

  User? _user;

  User? get user => _user;

  bool get hasUser => user != null;

  UserModel() {
    String? userMap = LocalStorage.get(qUser);
    _user = userMap != null ? User.fromJsonMap(json.decode(userMap)) : null;
  }

  saveUser(User user) {
    _user = user;
    notifyListeners();
    globalFavouriteStateModel.clearFavourite();
    LocalStorage.saveString(qUser, jsonEncode(user).toString());
  }

  /// 清除持久化的用户数据
  clearUser() {
    _user = null;
    notifyListeners();
    LocalStorage.remove(qUser);
  }
}
