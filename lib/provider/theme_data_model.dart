import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/res/my_commons.dart';
import 'package:my_network_encapsulation/util/local_storage.dart';

/// 主题model
class ThemeDataModel extends ChangeNotifier {
  int _themeIndex = LocalStorage.get(MyCommons.THEME_DATA) ?? 1;

  int get themeIndex => _themeIndex;

  final ThemeData norTheme = ThemeData(
      brightness: Brightness.light, // content颜色
      backgroundColor: Colors.white,
      textTheme:
          TextTheme(bodyText1: TextStyle(fontSize: 30, color: Colors.red)));

  final ThemeData darkTheme = ThemeData(
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
    LocalStorage.save(MyCommons.THEME_DATA, index);
  }
}
