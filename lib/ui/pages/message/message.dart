import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/viewModel/message/conversion.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation_result.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';

/// @describe: 腾讯云消息测试
/// @author: qds
/// @date:
class Message extends BaseWidget {
  Message({Key? key}) : super(key: key);

  @override
  BaseWidgetState<BaseWidget> getState() => _MessageState();
}

class _MessageState extends BaseWidgetState<Message> {
  _MessageState() {
    getMessage();
  }

  RefreshController _refreshController = RefreshController();

  @override
  Widget buildWidget(BuildContext context) {
    List<V2TimConversation>? conversionList = Provider.of<ConversionModel>(
      context,
      listen: true,
    ).conversionList;

    print('5555555555555');
    print(conversionList);

    return Container();
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
    setAppBarTitle('');
    setBackground(AppColors.white);
  }

  @override
  void onPause() {
    // TODO: implement onPause
  }

  @override
  void onResume() {
    // TODO: implement onResume
  }

  getMessage() async {
    V2TimValueCallback<V2TimConversationResult> data = await TencentImSDKPlugin
        .v2TIMManager
        .getConversationManager()
        .getConversationList(count: 100, nextSeq: "0");
    List<V2TimConversation> newList = [];
    if (data.data != null) {
      newList = data.data!.conversationList!.cast<V2TimConversation>();
    } else {
      newList = [];
    }

    Provider.of<ConversionModel>(
      context,
      listen: false,
    ).setConversionList(newList);
    print('消息列表');
    print(newList);
    // Provider.of<ConversionModel>(
    //   context,
    //   listen: false,
    // ).setConversionList(newList);
  }
}
