import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/generated/l10n.dart';

///@name: 隐私政策弹窗
class PrivacyDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              S.of(context).terms_of_service_and_privacy_policy_tips,
              style: MyTextStyles.sixteenBlack3333Bold,
            ),
            Gaps.vGap15,
            Text('欢迎使用...app'),
            Gaps.vGap20,
            RichText(text: TextSpan(
              text: '在您使用...app前，请您认真阅读并了解',
              style: MyTextStyles.fourteenBlack3333,
              children: [
                TextSpan(
                  text: '《服务条款》',
                  style: MyTextStyles.fourteenBlue91FF,
                  recognizer: TapGestureRecognizer()..onTap = () {
                    print('点击了服务条款');
                  }
                ),
                TextSpan(
                    text: '和',
                    style: MyTextStyles.fourteenBlack3333
                ),
                TextSpan(
                    text: '《隐私政策》',
                    style: MyTextStyles.fourteenBlue91FF,
                    recognizer: TapGestureRecognizer()..onTap = () {
                      print('点击了隐私政策');
                    }
                )
              ]
            )),
            Gaps.vGap15,
            ordinaryButton(
                backgroundColor: Colors.red,
                onPressed: () {
                  LocalStorage.save(MyCommons.AGREE_PRIVACY, true);
                  MyNavigator.pushReplacementNamed(RouteName.lead);
                },
                text: '同意',
                radius: 30,
                textStyle: MyTextStyles.sixteenWhite),
            Gaps.vGap10,
            ordinaryButton(
                onPressed: () {
                  exit(0);
                },
                text: '不同意并退出APP>>',
                textStyle: MyTextStyles.fourteenBlue91FF,
                radius: 30)
          ],
        ),
      ),
    );
  }
}
