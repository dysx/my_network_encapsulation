import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/generated/l10n.dart';
import 'package:my_network_encapsulation/res/keys.dart';
import 'package:my_network_encapsulation/util/local_storage.dart';

/// 语言model
class LocaleModel extends ChangeNotifier {

  int _localeIndex = LocalStorage.get(Keys.currentLanguage) ?? 0;

  int get localeIndex => _localeIndex;

  Locale? get locale {
    if(_localeIndex > 0){
      switch (_localeIndex){
        case 1: return Locale("zh");
        case 2: return Locale("en");
      }
    }
    // 跟随系统
    return null;
  }

  switchLocale(int index) {
    _localeIndex = index;
    notifyListeners();
    LocalStorage.saveInt(Keys.currentLanguage, index);
  }

  static String localeName(index, context) {
    switch (index) {
      case 0:
        return S.of(context).autoBySystem;
      case 1:
        return '中文';
      case 2:
        return 'English';
      default:
        return '';
    }
  }
}
