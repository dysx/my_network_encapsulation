
import 'package:flutter/cupertino.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';

/// @description: loading
class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
      color: AppColors.white,
      width: screenSize.width,
      // height: double.infinity,
      child: Center(
        child:
        // 圆形进度条
        new CircularProgressIndicator(
          strokeWidth: 4.0,
          backgroundColor: AppColors.yellow_9a22,
          // value: 0.2,
          valueColor: new AlwaysStoppedAnimation<Color>(AppColors.yellow_c133),
        ),
      ),
    );
  }
}
