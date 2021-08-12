import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/generated/l10n.dart';
import 'package:my_network_encapsulation/res/my_commons.dart';
import 'package:my_network_encapsulation/util/local_storage.dart';

/// 语言model
class LocaleModel extends ChangeNotifier {

  int _localeIndex = LocalStorage.get(MyCommons.LOCALE) ?? 0;

  int get localeIndex => _localeIndex;

  Locale? get locale {
    if(_localeIndex > 0){
      switch (_localeIndex){
        case 1: return Locale("zh");
        case 2: return Locale("en");
      }
    }
    print('当前localeIndex： $_localeIndex');
    // 跟随系统
    return null;
  }

  switchLocale(int index) {
    _localeIndex = index;
    notifyListeners();
    LocalStorage.saveInt(MyCommons.LOCALE, index);
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
