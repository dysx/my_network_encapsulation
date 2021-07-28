

import 'package:my_network_encapsulation/base/base_insert.dart';

class Second extends BaseInnerWidget {
  @override
  BaseInnerWidgetState<BaseInnerWidget> getState() => SecondState();

  @override
  int setIndex() => 1;
}

class SecondState extends BaseInnerWidgetState<Second> {
  @override
  Widget buildWidget(BuildContext context) {
    // return SafeArea(
    //   child: Center(
    //     child: Text('这是第二个页面', style: MyTextStyles.fourteenBlack3333),
    //   ),
    // );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: NetImage.cachedNetworkImage(
              imgUrl: 'https://img10.360buyimg.com/ddimg/jfs/t1/196622/32/15344/79769/61012148E85f8e012/13a997ee2e6d36ba.jpg',
          width: double.infinity,
          height: double.infinity)
        ),
      ),
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
