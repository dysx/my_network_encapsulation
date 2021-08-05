import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/util/image/local_image_selector.dart';

///@name: 网络图片（带缓存）
class NetImage {
  static Widget cachedNetworkImage(
      {String? imgUrl,
      double? width,
      double? height,
      BoxFit? fit,
      double? placeholderWidth,
      double? placeholderHeight,
      Widget? errorImage,
      Widget? normalImage}) {
    if (isCorrectImg(imgUrl!)) {
      return CachedNetworkImage(
        // placeholder: (context, url) => SizedBox(
        //     width: placeholderWidth,
        //     height: placeholderHeight,
        //     child: Image.asset('assets/images/image_loading.gif')),
        errorWidget: (context, url, error) =>
            errorImage ?? Icon(Icons.error_outline),
        imageUrl: imgUrl,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
      );
    } else {
      return normalImage ??
          LocalImageSelector.getSingleImage('setting',
              imageWidth: width, imageHeight: height,bFitFill: fit ?? BoxFit.cover);
    }
  }

  //检验是否是网络图片地址
  static bool isCorrectImg(String imgUrl) {
    if (imgUrl != null && imgUrl.length > 7 &&
        (imgUrl.substring(0, 7) == "http://" ||
            imgUrl.substring(0, 8) == "https://")) {
      return true;
    } else {
      return false;
    }
  }
}
