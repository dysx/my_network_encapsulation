import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/routes/page_route_anim.dart';
import 'package:my_network_encapsulation/ui/widget/multipleImage/my_photo_view.dart';

/// @describe: 网格图片
/// @author: qds
/// @date:
class GridViewPhotos extends StatelessWidget {
  final List<String> thumbnail;
  final List<String> originalImage;

  GridViewPhotos({required this.thumbnail, required this.originalImage});

  @override
  Widget build(BuildContext context) {
    return thumbnail.isNotEmpty
        ? GridView.builder(
            padding: EdgeInsets.only(top: 0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: Dimens.gapDp15w,
              mainAxisSpacing: Dimens.gapDp15w,
              childAspectRatio: 1.0,
            ),
            itemCount: thumbnail.length,
            itemBuilder: (BuildContext context, int index) {
              return _getListImage(context)[index];
            },
          )
        : SizedBox();
  }

  List<Widget> _getListImage(BuildContext context) {
    List<Widget> list = [];
    if (thumbnail.isNotEmpty) {
      for (int i = 0; i < thumbnail.length; i++) {
        list.add(
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => MyPhotoView(
                          photoList: originalImage,
                          thumbnails: thumbnail,
                          localPhotos: [],
                          initialIndex: i)));
            },
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: NetImage.cachedNetworkImage(imgUrl: thumbnail[i]),
              ),
            ),
          ),
        );
      }
    }
    return list;
  }
}
