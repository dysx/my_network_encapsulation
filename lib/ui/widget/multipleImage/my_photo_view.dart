import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/util/permission_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

/// @describe: 图片浏览
/// @author: qds
/// @date:
class MyPhotoView extends BaseWidget {
  MyPhotoView({
    required this.photoList,
    required this.localPhotos,
    required this.thumbnails,

    /// 地址列表
    this.initialIndex: 0,

    /// 初始页
  });

  final List<String> photoList;
  final List<File> localPhotos;
  final List<String> thumbnails;
  final int initialIndex;

  @override
  BaseWidgetState<BaseWidget> getState() => new _MyPhotoViewState();
}

class _MyPhotoViewState extends BaseWidgetState<MyPhotoView> {
  int currentIndex = 0;

  @override
  Widget buildWidget(BuildContext context) {
    return widget.photoList.isNotEmpty ? _buildNetPhotos() : _buildLocalPhotos();

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      onLongPress: () {
        if (widget.photoList.isNotEmpty) {
          _bottomSheet();
        }
      },
      child:
          widget.photoList.isNotEmpty ? _buildNetPhotos() : _buildLocalPhotos(),
    );
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
    setTopBarVisible(false);
    setAppBarVisible(false);
    print('本地图片地址: ${widget.localPhotos}');
    print('网络图片地址: ${widget.photoList}');
    currentIndex = widget.initialIndex;
  }

  @override
  void onPause() {
    // TODO: implement onPause
  }

  @override
  void onResume() {
    // TODO: implement onResume
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void _bottomSheet() {
    showModalBottomSheet(
        context: context,
        barrierColor: Colors.transparent,
        backgroundColor: AppColors.white,
        elevation: 100,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                  title: Text('保存图片',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.sixteenBlack3333),
                  onTap: () {
                    _saveImage(widget.photoList[currentIndex]);
                    // Navigator.pop(context);
                    // _openGallery();
                    //Navigator.pop(context1);
                  }),
              Gaps.hLine,
              ListTile(
                  title: Text('取消',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.sixteenFF66),
                  onTap: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  void _saveImage(String imageUrl) async {
    Uint8List imageBytes;
    CachedNetworkImage image = CachedNetworkImage(imageUrl: imageUrl);
    BaseCacheManager manager = image.cacheManager ?? DefaultCacheManager();
    File file = await manager.getSingleFile(imageUrl);
    imageBytes = await file.readAsBytes();
    PermissionManager.applyStoragePermission(() async {
      await ImageGallerySaver.saveImage(imageBytes, quality: 100);
      Toast.showMsg('保存图片成功');
      Navigator.pop(context);
    });
  }

  PhotoViewComputedScale? _getNetScale(int index) {
    PhotoViewComputedScale? scale;
    ImageProvider imageProvider =
        CachedNetworkImageProvider(widget.photoList[index]);
    imageProvider
        .resolve(new ImageConfiguration())
        .addListener(new ImageStreamListener(
      (ImageInfo info, bool _) async {
        if (!mounted) return;
        scale = info.image.width / info.image.height <
                getScreenWidth() / getScreenHeight()
            ? PhotoViewComputedScale.covered
            : PhotoViewComputedScale.contained;
      },
    ));
    return scale;
  }

  PhotoViewComputedScale? _getLocalScale(int index) {
    PhotoViewComputedScale? scale;
    ImageProvider imageProvider = FileImage(widget.localPhotos[index]);
    imageProvider
        .resolve(new ImageConfiguration())
        .addListener(new ImageStreamListener(
      (ImageInfo info, bool _) async {
        if (!mounted) return;
        scale = info.image.width / info.image.height <
                getScreenWidth() / getScreenHeight()
            ? PhotoViewComputedScale.covered
            : PhotoViewComputedScale.contained;
      },
    ));
    return scale;
  }

  /// 加载网络图片
  Widget _buildNetPhotos() {
    int i = 0;
    return PhotoViewGallery.builder(
      enableRotation: false,
      scrollDirection: Axis.horizontal,
      scrollPhysics: const BouncingScrollPhysics(),
      itemCount: widget.photoList.length,
      backgroundDecoration: BoxDecoration(
        color: Colors.black,
      ),
      pageController: PageController(initialPage: widget.initialIndex),
      onPageChanged: onPageChanged,
      loadingBuilder: (BuildContext context, ImageChunkEvent? e) {
        return _loadingChild(e, i);
      },
      builder: (BuildContext context, int index) {
        i = index;
        PhotoViewComputedScale? scale;
        scale = _getNetScale(index);
        return _pageNetOptions(scale, index);
      },
    );
  }

  /// 加载本地图片
  Widget _buildLocalPhotos() {
    return PhotoViewGallery.builder(
      scrollDirection: Axis.horizontal,
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        PhotoViewComputedScale? scale;
        scale = _getLocalScale(index);
        return _pageLocalOptions(scale, index);
      },
      itemCount: widget.localPhotos.length,
      backgroundDecoration: BoxDecoration(
        color: Colors.black,
      ),
      pageController: PageController(initialPage: widget.initialIndex),
      onPageChanged: onPageChanged,
    );
  }

  Widget _loadingChild(ImageChunkEvent? e, int i) {
    return Stack(
      children: [
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.black,
              child: Center(
                child:
                    NetImage.cachedNetworkImage(imgUrl: widget.thumbnails[i]),
              ),
            )),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: Align(
              alignment: Alignment.center,
              child: Center(
                  child: CircularProgressIndicator(
                value: e != null
                    ? e.cumulativeBytesLoaded / e.expectedTotalBytes!
                    : 0,
                strokeWidth: 4.0,
                backgroundColor: AppColors.white,
                // value: 0.2,
                valueColor:
                    new AlwaysStoppedAnimation<Color>(AppColors.yellow_c133),
              ))),
        )
      ],
    );
  }

  PhotoViewGalleryPageOptions _pageNetOptions(
      PhotoViewComputedScale? scale, int index) {
    return PhotoViewGalleryPageOptions(
      basePosition: scale == PhotoViewComputedScale.covered
          ? Alignment.topCenter
          : Alignment.center,
      imageProvider: CachedNetworkImageProvider(widget.photoList[index],
          maxWidth: MediaQuery.of(context).size.width.toInt()),
      initialScale: scale,
      minScale: scale,
      maxScale: 3.0,
      onTapUp: (c, d, p) => MyNavigator.pop(),
      onTapDown: (c, d, p) {
        print('123456');
      }
    );
  }

  PhotoViewGalleryPageOptions _pageLocalOptions(
      PhotoViewComputedScale? scale, int index) {
    return PhotoViewGalleryPageOptions(
      basePosition: scale == PhotoViewComputedScale.covered
          ? Alignment.topCenter
          : Alignment.center,
      imageProvider: FileImage(widget.localPhotos[index]),
      initialScale: scale,
      minScale: scale,
      maxScale: 3.0,
      // tightMode: false
    );
  }
}
