import 'package:flutter/widgets.dart';
import 'package:my_network_encapsulation/res/my_colors.dart';

import 'dimens.dart';

/// @describe: 通用占位盒子封装和分割线
/// @author: qds
/// @date:
class Gaps {
  /// 水平间隔
  static Widget hGap5 = SizedBox(width: Dimens.gapDp5w);
  static Widget hGap10 = SizedBox(width: Dimens.gapDp10w);
  static Widget hGap15 = SizedBox(width: Dimens.gapDp15w);
  static Widget hGap20 = SizedBox(width: Dimens.gapDp20w);

  /// 垂直间隔
  static Widget vGap5w = SizedBox(height: Dimens.gapDp5w);
  static Widget vGap10w = SizedBox(height: Dimens.gapDp10w);
  static Widget vGap15w = SizedBox(height: Dimens.gapDp15w);
  static Widget vGap20w = SizedBox(height: Dimens.gapDp20w);

  static Widget vGap5h = SizedBox(height: Dimens.gapDp5h);
  static Widget vGap10h = SizedBox(height: Dimens.gapDp10h);
  static Widget vGap15h = SizedBox(height: Dimens.gapDp15h);
  static Widget vGap20h = SizedBox(height: Dimens.gapDp20h);

  static Widget hLine = const SizedBox(
    height: 1,
    width: double.infinity,
    child:
        const DecoratedBox(decoration: BoxDecoration(color: MyColors.gray_ee)),
  );

  static Widget vLine = const SizedBox(
    width: 1,
    height: double.infinity,
    child:
        const DecoratedBox(decoration: BoxDecoration(color: MyColors.gray_ee)),
  );

  static const Widget empty = const SizedBox();
}
