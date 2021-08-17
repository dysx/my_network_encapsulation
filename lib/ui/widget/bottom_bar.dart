import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/util/size_util.dart';

class MyBottomBar extends StatelessWidget {
  MyBottomBar({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 23,
    this.backgroundColor,
    this.containerHeight = 50,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.items,
    required this.onItemSelected,
    this.curve = Curves.linear,
  })  : assert(items.length >= 2 && items.length <= 5),
        super(key: key);

  final int selectedIndex;
  final double iconSize;
  final Color? backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double? containerHeight;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Theme.of(context).bottomAppBarColor;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          if (showElevation)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
            ),
        ],
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight,
          padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 5.w),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children:
            items.map((item) {
              var index = items.indexOf(item);
              return Expanded(child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => onItemSelected(index),
                child: _ItemWidget(
                  item: item,
                  iconSize: iconSize,
                  isSelected: index == selectedIndex,
                  backgroundColor: bgColor,
                  animationDuration: animationDuration,
                  curve: curve,
                ),
              ));
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final Duration animationDuration;
  final Curve curve;

  const _ItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.backgroundColor,
    required this.animationDuration,
    required this.iconSize,
    this.curve = Curves.linear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isSelected ? _select() : _unSelect();
  }

  Widget _select() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: iconSize),
          duration: Duration(milliseconds: 200),
          curve: Curves.linear,
          builder: (context, value, child) {
            return IconTheme(
              data: IconThemeData(
                size: value,
                color: isSelected
                    ? item.activeColor.withOpacity(1)
                    : item.inactiveColor == null
                    ? item.activeColor
                    : item.inactiveColor,
              ),
              child: item.icon,
            );
          },
        ),
        SizedBox(height: 4.w),
        Text(item.title,style: AppTextStyles.tenYellow)
      ],
    );
  }

  Widget _unSelect() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconTheme(
          data: IconThemeData(
            size: iconSize,
            color: isSelected
                ? item.activeColor.withOpacity(1)
                : item.inactiveColor == null
                ? item.activeColor
                : item.inactiveColor,
          ),
          child: item.icon,
        ),
        SizedBox(height: 4.w),
        Text(item.title,style: AppTextStyles.tenBlack3333)
      ],
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem({
    required this.icon,
    required this.title,
    this.activeColor = AppColors.yellow_ab00,
    this.inactiveColor = AppColors.black_3333,
  });

  final Widget icon;
  final String title;
  final Color activeColor;
  final Color? inactiveColor;
}
