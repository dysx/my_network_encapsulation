import 'package:shared_preferences/shared_preferences.dart';

///@name: 数据存取
class LocalStorage {
  static late SharedPreferences preferences;

  /// 初始化
  static Future getInstance() async {
    preferences = await SharedPreferences.getInstance();
  }

  /// ------------- save --------------
  static save(String key, value) {
    SharedPreferences prefs = preferences;
    if (value is String) {
      prefs.setString(key, value);
    } else if (value is int) {
      prefs.setInt(key, value);
    } else if (value is double) {
      prefs.setDouble(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else {
      prefs.setStringList(key, value);
    }
  }

  static saveString(String key, String value) {
    SharedPreferences prefs = preferences;
    prefs.setString(key, value);
  }

  static saveInt(String key, int value) {
    SharedPreferences prefs = preferences;
    prefs.setInt(key, value);
  }

  static saveDouble(String key, double value) {
    SharedPreferences prefs = preferences;
    prefs.setDouble(key, value);
  }

  static saveBool(String key, bool value) {
    SharedPreferences prefs = preferences;
    prefs.setBool(key, value);
  }

  static saveListString(String key, List<String> value) {
    SharedPreferences prefs = preferences;
    prefs.setStringList(key, value);
  }

  /// ------------- get --------------
  static get(String key) {
    SharedPreferences prefs = preferences;
    return prefs.get(key);
  }

  static Set<String> getKeys() {
    SharedPreferences prefs = preferences;
    return prefs.getKeys();
  }

  static remove(String key) {
    SharedPreferences prefs = preferences;
    prefs.remove(key);
  }
}
