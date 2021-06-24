import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/res/my_commons.dart';
import 'package:my_network_encapsulation/util/local_storage.dart';

/// 主题model
class ThemeDataModel extends ChangeNotifier {
  int _themeIndex = LocalStorage.get(MyCommons.THEME_DATA) ?? 1;

  int get themeIndex => _themeIndex;

  final ThemeData norTheme = ThemeData(
      brightness: Brightness.light, // content颜色
      primaryColor: Color(0xFFF8F8F8), // appbar、topBar颜色
      accentColor: Colors.lightBlue[100],
      backgroundColor: Colors.white);

  final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      accentColor: Colors.red,
      backgroundColor: Colors.black38);

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
