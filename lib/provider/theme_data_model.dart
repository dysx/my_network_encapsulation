import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/res/my_commons.dart';
import 'package:my_network_encapsulation/util/local_storage.dart';

/// 主题model
class ThemeDataModel extends ChangeNotifier {
  int _themeIndex = LocalStorage.get(MyCommons.THEME_DATA) ?? 1;

  int get themeIndex => _themeIndex;

  ThemeData get myThemeData {
    switch (_themeIndex) {
      case 0:
        return ThemeData(
            brightness: Brightness.light, // content颜色
            primaryColor: Colors.blue[800], // appbar、topBar颜色
            accentColor: Colors.lightBlue[100],
            backgroundColor: Colors.red);
      case 1:
        return ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.black,
            accentColor: Colors.red,
            backgroundColor: Colors.black38);
      default:
        return ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.blue[800],
            accentColor: Colors.lightBlue[100],
            backgroundColor: Colors.red);
    }
  }

  switchTheme(int index) {
    _themeIndex = index;
    notifyListeners();
    LocalStorage.save(MyCommons.THEME_DATA, index);
  }
}
