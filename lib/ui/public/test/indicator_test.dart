
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/ui/widget/page_indicaor.dart';

/// @describe:
/// @author: qds
/// @date:
class IndicatorTest extends BaseWidget {

   IndicatorTest({Key? key}):super(key: key);

  @override
  BaseWidgetState<BaseWidget> getState() => new _IndicatorTestState();
}

class _IndicatorTestState extends BaseWidgetState<IndicatorTest> {

  PageController _pageController = PageController();

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: PageView(
            controller: _pageController,
            children: [
              Container(
                height: double.maxFinite,
                color: Colors.red,
              ),
              Container(
                height: double.maxFinite,
                color: Colors.yellow,
              ),
              Container(
                height: double.maxFinite,
                color: Colors.blue,
              )
            ],
          )
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 15.h,
          child: Center(
            child: PageIndicator(
              length: 3,
              pageController: _pageController,
              // currentWidth: 20.w,
              // currentHeight: 20.w,
              // normalWidth: 20.w,
              // normalHeight: 20.w,
              currentDecoration:

              BoxDecoration(
                  color: Colors.blue, shape: BoxShape.circle),
            ),
          ),
        )
      ],
    );
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
    setAppBarTitle('');
    setBackground(AppColors.background);

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