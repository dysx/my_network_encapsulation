import 'package:flutter/cupertino.dart';

abstract class IBaseView {

  BuildContext getContext();

  void showProgress();

  void closeProgress();

  void showToast(String msg);

}