
import 'package:flutter/cupertino.dart';
import 'package:my_network_encapsulation/res/my_colors.dart';
import 'package:my_network_encapsulation/util/image/net_image.dart';

///头像类型

class MyAvatar extends StatelessWidget {
  MyAvatar({
    this.avatarUrl,
    this.width,
    this.height,
    this.borderWidth,
    this.defaultImage,
    this.onTap,
    this.bigSize : false,
  });
  final String? avatarUrl;
  final double? width;
  final double? height;
  final double? borderWidth;
  final Widget? defaultImage;
  final Function? onTap;
  final bool bigSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        onTap!();
      },
      child: Container(
        // color: Colors.red,
        width: width ?? 55,
        height: height ?? 55,
        decoration: BoxDecoration(
          border: Border.all(color: MyColors.white, width: borderWidth??0),
          shape: BoxShape.circle,
        ),
        child: ClipOval(
            child: NetImage.cachedNetworkImage()
          // avatarUrl == null
          //     ? BaseCommon.netImage( null, normalImage: LocalImageSelector.getImage('default_group'))
          //     : BaseCommon.netImage(avatarUrl, normalImage: LocalImageSelector.getImage('default_group'))
        ),
      ),
    );
  }
}