import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/res/keys.dart';
import 'package:my_network_encapsulation/util/local_storage.dart';
import 'package:my_network_encapsulation/util/size_util.dart';

/// 主题model
class ThemeDataModel extends ChangeNotifier {
  int _themeIndex = LocalStorage.get(Keys.currentTheme) ?? 0;

  int get themeIndex => _themeIndex;

  final ThemeData norTheme = ThemeData(
      platform: TargetPlatform.iOS,
      brightness: Brightness.light, // content颜色
      backgroundColor: Colors.white,
      textTheme: TextTheme(
          bodyText2: TextStyle(fontSize: 14.sp, color: AppColors.black_3333)));

  final ThemeData darkTheme = ThemeData(
      platform: TargetPlatform.iOS,
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      textTheme: TextTheme(bodyText1: TextStyle(fontSize: 50)));

  ThemeData get myThemeData {
    switch (_themeIndex) {
      case 0:
        return norTheme;
      case 1:
        return darkTheme;
      default:
        return norTheme;
    }
  }

  switchTheme(int index) {
    _themeIndex = index;
    notifyListeners();
    LocalStorage.saveInt(Keys.currentTheme, index);
  }
}
