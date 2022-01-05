import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/util/toast.dart';

/// @author: qds
/// @date:
abstract class ABaseLifeState {

  late String _pageName;
  String get pageName => _pageName;

  void setPageName(String name) => _pageName = name;

  /// ---------- 生命周期 ------------
  /// 初始化一些变量 相当于 onCreate ， 放一下 初始化数据操作
  void onCreate() {
    debugPrint("$_pageName -- 页面 --- onCreate");
  }

  /// 相当于onResume, 只要页面来到栈顶， 都会调用此方法，网络请求可以放在这个方法
  void onResume() {
    debugPrint("$_pageName -- 页面 --- onResume");
  }

  /// 页面被覆盖,暂停
  void onPause() {
    debugPrint("$_pageName -- 页面 --- 被覆盖,暂停");
  }

  /// 返回UI控件 相当于setContentView()
  Widget buildWidget(BuildContext context);

  /// app切回到后台
  void onBackground() {
    debugPrint("$_pageName -- 页面 --- 回到后台");
  }

  /// app切回到前台
  void onForeground() {
    debugPrint("$_pageName -- 页面 --- 回到前台");
  }

  /// 页面注销方法
  void onDestroy() {
    debugPrint("$_pageName -- 页面 --- destroy");
  }
}
