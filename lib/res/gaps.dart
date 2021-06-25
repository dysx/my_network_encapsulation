import 'package:flutter/widgets.dart';
import 'package:my_network_encapsulation/res/my_colors.dart';

import 'dimens.dart';
/// 间隔
class Gaps {
  /// 水平间隔
  static Widget hGap5 = SizedBox(width: Dimens.gapDp5);
  static Widget hGap10 = SizedBox(width: Dimens.gapDp10);
  static Widget hGap15 = SizedBox(width: Dimens.gapDp15);
  static Widget hGap20 = SizedBox(width: Dimens.gapDp20);
  /// 垂直间隔
  static Widget vGap5 = SizedBox(height: Dimens.gapDp5);
  static Widget vGap10 = SizedBox(height: Dimens.gapDp10);
  static Widget vGap15 = SizedBox(height: Dimens.gapDp15);
  static Widget vGap20 = SizedBox(height: Dimens.gapDp20);

  static Widget hLine = const SizedBox(
    height: 1.0,
    width: double.infinity,
    child: const DecoratedBox(decoration: BoxDecoration(color: MyColors.gray_ee)),
  );

  static Widget vLine = const SizedBox(
    width: 1.0,
    height: double.infinity,
    child: const DecoratedBox(decoration: BoxDecoration(color: MyColors.gray_ee)),
  );

  static const Widget empty = const SizedBox();
}
