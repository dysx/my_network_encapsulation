import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/ui/widget/multipleImage/gridView_photos.dart';

/// @describe: bottomNavItem_second页面
/// @author: qds
/// @date:
// ignore: must_be_immutable
class Second extends BaseInnerWidget {
  @override
  BaseInnerWidgetState<BaseInnerWidget> getState() => SecondState();

  @override
  int setIndex() => 1;
}

class SecondState extends BaseInnerWidgetState<Second> {
  List<String> thumbnail = [
    'https://img10.360buyimg.com/ddimg/jfs/t1/196622/32/15344/79769/61012148E85f8e012/13a997ee2e6d36ba.jpg',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fww1.sinaimg.cn%2Fmw690%2F001RhaGLly1gs16tpjjqfj60j63jsn7s02.jpg&refer=http%3A%2F%2Fwww.sina.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1630657309&t=8bb2a5c3e1f973143203980af8554633',
    'https://img14.360buyimg.com/ddimg/jfs/t1/195166/7/16561/1704049/610a59b1Ec82b0584/67839b2e5bd118ba.png',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimagepphcloud.thepaper.cn%2Fpph%2Fimage%2F146%2F160%2F690.jpg&refer=http%3A%2F%2Fimagepphcloud.thepaper.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1630722995&t=c5268f149e2fb16feda5cb0f1e26adea',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Finews.gtimg.com%2Fnewsapp_match%2F0%2F13845555364%2F0&refer=http%3A%2F%2Finews.gtimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1630722995&t=d11148235dd6ef5b23f1725046a5c140'
  ];
  List<String> originalImage = [
    'https://img11.360buyimg.com/ddimg/jfs/t1/200862/31/155/2454523/610a4dafE89d1ab4f/33efcc6013ea57fb.jpg',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fww1.sinaimg.cn%2Fmw690%2F001RhaGLly1gs16tpjjqfj60j63jsn7s02.jpg&refer=http%3A%2F%2Fwww.sina.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1630657309&t=8bb2a5c3e1f973143203980af8554633',
    'https://img14.360buyimg.com/ddimg/jfs/t1/195166/7/16561/1704049/610a59b1Ec82b0584/67839b2e5bd118ba.png',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimagepphcloud.thepaper.cn%2Fpph%2Fimage%2F146%2F160%2F690.jpg&refer=http%3A%2F%2Fimagepphcloud.thepaper.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1630722995&t=c5268f149e2fb16feda5cb0f1e26adea',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Finews.gtimg.com%2Fnewsapp_match%2F0%2F13845555364%2F0&refer=http%3A%2F%2Finews.gtimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1630722995&t=d11148235dd6ef5b23f1725046a5c140'
  ];

  @override
  Widget buildWidget(BuildContext context) {
    return Column(
      children: [
        GridViewPhotos(thumbnail: thumbnail, originalImage: originalImage)
      ],
    );
  }

  @override
  double getVerticalMargin() => 0;

  @override
  void onCreate() {
    setTopBarVisible(true);
    setAppBarVisible(false);
  }

  @override
  void onPause() {
    // TODO: implement onPause
  }

  @override
  void onResume() {
    // TODO: implement onResume
  }
}
