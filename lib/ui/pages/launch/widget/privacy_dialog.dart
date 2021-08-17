import 'dart:io';

import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/generated/l10n.dart';
import 'package:my_network_encapsulation/ui/pages/launch/widget/PrivacyView.dart';

/// @describe: 隐私政策弹窗
/// @author: qds
/// @date:
// ignore: must_be_immutable
class PrivacyDialog extends StatelessWidget {
  String data = "亲爱的xxxx用户，感谢您信任并使用xxxxAPP！\n" +
      " \n" +
      "xxxx十分重视用户权利及隐私政策并严格按照相关法律法规的要求，对《用户协议》和《隐私政策》进行了更新,特向您说明如下：\n" +
      "1.为向您提供更优质的服务，我们会收集、使用必要的信息，并会采取业界先进的安全措施保护您的信息安全；\n" +
      "2.基于您的明示授权，我们可能会获取设备号信息、包括：设备型号、操作系统版本、设备设置、设备标识符、MAC（媒体访问控制）地址、IMEI（移动设备国际身份码）、广告标识符（“IDFA”与“IDFV”）、集成电路卡识别码（“ICCD”）、软件安装列表。我们将使用三方产品（友盟、极光等）统计使用我们产品的设备数量并进行设备机型数据分析与设备适配性分析。（以保障您的账号与交易安全），且您有权拒绝或取消授权；\n" +
      "3.您可灵活设置伴伴账号的功能内容和互动权限，您可在《隐私政策》中了解到权限的详细应用说明；\n" +
      "4.未经您同意，我们不会从第三方获取、共享或向其提供您的信息；\n" +
      "5.您可以查询、更正、删除您的个人信息，我们也提供账户注销的渠道。\n" +
      " \n" +
      "请您仔细阅读并充分理解相关条款，其中重点条款已为您黑体加粗标识，方便您了解自己的权利。如您点击“同意”，即表示您已仔细阅读并同意本《用户协议》及《隐私政策》，将尽全力保障您的合法权益并继续为您提供优质的产品和服务。如您点击“不同意”，将可能导致您无法继续使用我们的产品和服务。";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * .6,
        width: MediaQuery.of(context).size.width * .8,
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    S.of(context).terms_of_service_and_privacy_policy_tips,
                    style: AppTextStyles.sixteenBlack3333Bold,
                  ),
                  Gaps.vGap15w,
                  Text('欢迎使用...app'),
                  Gaps.vGap20w,
                  PrivacyView(
                      data: data,
                      keys: ['《用户协议》', '《隐私政策》'],
                      onTapCallback: (key) {
                        if (key == '《用户协议》') {
                          Toast.showMsg('点击了用户协议');
                        } else if (key == '《隐私政策》') {
                          Toast.showMsg('点击了隐私政策');
                        }
                      }),
                ],
              ),
            )),
            SizedBox(
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: ordinaryButton(
                            minimumSize: Size(double.infinity, 45),
                            onPressed: () {
                              exit(0);
                            },
                            text: '不同意',
                            textStyle: AppTextStyles.fourteenBlack3333)),
                    Gaps.vLine,
                    Expanded(
                        child: ordinaryButton(
                            overlayColor: Colors.blueGrey,
                            backgroundColor: Colors.blue,
                            minimumSize: Size(double.infinity, 45),
                            onPressed: () {
                              LocalStorage.saveBool(
                                  Keys.agreePrivacy, true);
                              MyNavigator.pushReplacementNamed(RouteName.lead);
                            },
                            text: '同意并使用',
                            textStyle: AppTextStyles.sixteenWhite)),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
