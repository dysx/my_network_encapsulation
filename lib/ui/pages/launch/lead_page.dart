import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/ui/pages/launch/widget/animation_page.dart';

/// @describe: 引导页
/// @author: qds
/// @date:
class LeadPage extends BaseWidget {
  @override
  BaseWidgetState<BaseWidget> getState() => LeadPageState();
}

class LeadPageState extends BaseWidgetState<LeadPage> {
  // 引出带动画的widget
  AnimationPage aniPage = new AnimationPage();

  List<String> _leadImages = ['guide_page1', 'guide_page2', 'guide_page3'];

  @override
  Widget buildWidget(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      children: _leads(),
      onPageChanged: (pageIndex) {
        startPagePaged(pageIndex);
      },
    );
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
    setTopBarVisible(false);
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

  void startPagePaged(int page) {
    if (page == 2) {
      // 当到达带按钮的页面时触发动画
      aniPage.btn.startAnimation();
    }
  }

  List<Widget> _leads() {
    List<Widget> list = [];

    for (int i = 0; i < 2; i++) {
      list.add(ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: LocalImageSelector.getImgByPhysicalSize(_leadImages[i]),
      ));
    }

    list.add(aniPage);

    return list;
  }
}
