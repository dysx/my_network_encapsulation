import 'package:my_network_encapsulation/config/appConfig.dart';
import 'package:my_network_encapsulation/viewModel/message/conversion.dart';
import 'package:provider/provider.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimAdvancedMsgListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimConversationListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimFriendshipListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimGroupListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimSDKListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimSignalingListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimSimpleMsgListener.dart';
import 'package:tencent_im_sdk_plugin/enum/log_level.dart';
import 'package:tencent_im_sdk_plugin/manager/v2_tim_manager.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_application.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_group_application_result.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message_receipt.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';

/// @describe: 腾讯云im初始化
/// @author: qds
/// @date:
class TencentIm {

  static initSDK() async {
    V2TIMManager timManager = TencentImSDKPlugin.v2TIMManager;
    await timManager.initSDK(
      sdkAppID: 1400562790,
      loglevel: LogLevel.V2TIM_LOG_DEBUG,
      listener: V2TimSDKListener(
        onConnectFailed: (code, error) {},
        onConnectSuccess: () {},
        onConnecting: () {},
        onKickedOffline: () {
          onKickedOffline();
        },
        onSelfInfoUpdated: (info) {
          onSelfInfoUpdated();
        },
        onUserSigExpired: () {},
      ),
    );

    print("initSDK");

    //简单监听
    timManager.addSimpleMsgListener(
      listener: new V2TimSimpleMsgListener(
        onRecvC2CCustomMessage: (msgID, sender, customData) {},
        onRecvC2CTextMessage: (msgID, userInfo, text) {},
        onRecvGroupCustomMessage: (msgID, groupID, sender, customData) {},
        onRecvGroupTextMessage: (msgID, groupID, sender, customData) {},
      ),
    );

    //群组监听
    timManager.setGroupListener(
      listener: new V2TimGroupListener(
        onApplicationProcessed: (groupID, opUser, isAgreeJoin, opReason) {},
        onGrantAdministrator: (groupID, opUser, memberList) {},
        onGroupAttributeChanged: (groupID, groupAttributeMap) {},
        onGroupCreated: (groupID) {},
        onGroupDismissed: (groupID, opUser) {},
        onGroupInfoChanged: (groupID, changeInfos) {},
        onGroupRecycled: (groupID, opUser) {},
        onMemberEnter: (groupID, memberList) {
          onReceiveJoinApplicationonMemberEnter();
        },
        onMemberInfoChanged: (groupID, v2TIMGroupMemberChangeInfoList) {},
        onMemberInvited: (groupID, opUser, memberList) {},
        onMemberKicked: (groupID, opUser, memberList) {},
        onMemberLeave: (groupID, member) {},
        onQuitFromGroup: (groupID) {},
        onReceiveJoinApplication: (groupID, member, opReason) {
          onReceiveJoinApplicationonMemberEnter();
        },
        onReceiveRESTCustomData: (groupID, customData) {},
        onRevokeAdministrator: (groupID, opUser, memberList) {},
      ),
    );
    //高级消息监听
    timManager.getMessageManager().addAdvancedMsgListener(
          listener: new V2TimAdvancedMsgListener(
            onRecvC2CReadReceipt: (receiptList) {
              onRecvC2CReadReceipt(receiptList);
            },
            onRecvMessageRevoked: (msgID) {},
            onRecvNewMessage: (msg) {
              onRecvNewMessage(msg);
            },
            onSendMessageProgress: (message, progress) {
              onSendMessageProgress(message, progress);
            },
          ),
        );

    timManager.getFriendshipManager().setFriendListener(
          listener: new V2TimFriendshipListener(
            onBlackListAdd: (infoList) {},
            onBlackListDeleted: (userList) {
              onFriendListAddedonFriendListDeletedonFriendInfoChangedonBlackListDeleted();
            },
            onFriendApplicationListAdded: (applicationList) {
              onFriendApplicationListAdded(applicationList);
            },
            onFriendApplicationListDeleted: (userIDList) {},
            onFriendApplicationListRead: () {},
            onFriendInfoChanged: (infoList) {
              onFriendListAddedonFriendListDeletedonFriendInfoChangedonBlackListDeleted();
            },
            onFriendListAdded: (users) {
              onFriendListAddedonFriendListDeletedonFriendInfoChangedonBlackListDeleted();
            },
            onFriendListDeleted: (userList) {
              onFriendListAddedonFriendListDeletedonFriendInfoChangedonBlackListDeleted();
            },
          ),
        );
    //会话监听
    timManager.getConversationManager().setConversationListener(
          listener: new V2TimConversationListener(
            onConversationChanged: (conversationList) {
              try {
                Provider.of<ConversionModel>(AppConfig.globalKey.currentContext!, listen: false)
                    .setConversionList(conversationList);
                //如果当前会话在使用中，也更新一下

              } catch (e) {}
            },
            onNewConversation: (conversationList) {
              try {
                Provider.of<ConversionModel>(AppConfig.globalKey.currentContext!, listen: false)
                    .setConversionList(conversationList);
                //如果当前会话在使用中，也更新一下

              } catch (e) {}
            },
            onSyncServerFailed: () {},
            onSyncServerFinish: () {},
            onSyncServerStart: () {},
          ),
        );
    timManager.getSignalingManager().addSignalingListener(
          listener: new V2TimSignalingListener(
            onInvitationCancelled: (inviteID, inviter, data) {},
            onInvitationTimeout: (inviteID, inviteeList) {},
            onInviteeAccepted: (inviteID, invitee, data) {},
            onInviteeRejected: (inviteID, invitee, data) {},
            onReceiveNewInvitation:
                (inviteID, inviter, groupID, inviteeList, data) {},
          ),
        );
    print("初始化完成了");
  }

  static void onKickedOffline() async {
// 被踢下线
    // 清除本地缓存，回到登录页TODO
    // try {
      Provider.of<ConversionModel>(AppConfig.globalKey.currentContext!, listen: false).clear();
    //   Provider.of<UserModel>(context, listen: false).clear();
    //   Provider.of<CurrentMessageListModel>(context, listen: false).clear();
    //   Provider.of<FriendListModel>(context, listen: false).clear();
    //   Provider.of<FriendApplicationModel>(context, listen: false).clear();
    //   Provider.of<GroupApplicationModel>(context, listen: false).clear();
    //   // 去掉存的一些数据
    //   Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    //   SharedPreferences prefs = await _prefs;
    //   prefs.remove('token');
    //   prefs.remove('sessionId');
    //   prefs.remove('phone');
    //   prefs.remove('code');
    // } catch (err) {
    //   print("someError");
    //   print(err);
    // }
    // print("被踢下线了");
    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
    //   ModalRoute.withName('/'),
    // );
  }

  static void onSelfInfoUpdated() async {
    //自己信息更新，从新获取自己的信息；
    // V2TimValueCallback<String> usercallback =
    // await TencentImSDKPlugin.v2TIMManager.getLoginUser();
    // V2TimValueCallback<List<V2TimUserFullInfo>> infos = await TencentImSDKPlugin
    //     .v2TIMManager
    //     .getUsersInfo(userIDList: [usercallback.data!]);
    // if (infos.code == 0) {
    //   Provider.of<UserModel>(context, listen: false).setInfo(infos.data![0]);
    // }
  }

  static void onReceiveJoinApplicationonMemberEnter() async {
    V2TimValueCallback<V2TimGroupApplicationResult> res =
        await TencentImSDKPlugin.v2TIMManager
            .getGroupManager()
            .getGroupApplicationList();
    if (res.code == 0) {
      if (res.code == 0) {
        if (res.data!.groupApplicationList!.length > 0) {
          // Provider.of<GroupApplicationModel>(context, listen: false)
          //     .setGroupApplicationResult(res.data!.groupApplicationList);
        }
      }
    } else {
      print("获取加群申请失败${res.desc}");
    }
  }

  static void onRecvC2CReadReceipt(List<V2TimMessageReceipt> list) {
    print('收到了新消息 已读回执');
    list.forEach((element) {
      print("已读回执${element.userID} ${element.timestamp}");
      // Provider.of<CurrentMessageListModel>(context, listen: false)
      //     .updateC2CMessageByUserId(element.userID);
    });
  }

  static void onRecvNewMessage(V2TimMessage message) {
    try {
      List<V2TimMessage> messageList = List.empty(growable: true);

      messageList.add(message);

      print("c2c_${message.sender}");
      String key;
      if (message.groupID == null) {
        key = "c2c_${message.sender}";
      } else {
        key = "group_${message.groupID}";
      }
      print("conterkey_$key");
      // Provider.of<CurrentMessageListModel>(context, listen: false)
      //     .addMessage(key, messageList);
    } catch (err) {
      print(err);
    }
  }

  static void onSendMessageProgress(V2TimMessage message, int progress) {
// 消息进度
    String key;
    if (message.groupID == null) {
      key = "c2c_${message.userID}";
    } else {
      key = "group_${message.groupID}";
    }
    try {
      // Provider.of<CurrentMessageListModel>(
      //   context,
      //   listen: false,
      // ).addOneMessageIfNotExits(
      //   key,
      //   message,
      // );
    } catch (err) {
      print("error $err");
    }
    print(
        "消息发送进度 $progress ${message.timestamp} ${message.msgID} ${message.timestamp} ${message.status}");
  }

  static void
      onFriendListAddedonFriendListDeletedonFriendInfoChangedonBlackListDeleted() async {
    V2TimValueCallback<List<V2TimFriendInfo>> friendRes =
        await TencentImSDKPlugin.v2TIMManager
            .getFriendshipManager()
            .getFriendList();
    if (friendRes.code == 0) {
      List<V2TimFriendInfo>? newList = friendRes.data;
      if (newList != null && newList.length > 0) {
        // Provider.of<FriendListModel>(context, listen: false)
        //     .setFriendList(newList);
      } else {
        // Provider.of<FriendListModel>(context, listen: false)
        //     .setFriendList(List.empty(growable: true));
      }
    }
  }

  static void onFriendApplicationListAdded(List<V2TimFriendApplication> list) {
    // 收到加好友申请,添加双向好友时双方都会周到这个回调，这时要过滤掉type=2的不显示
    print("收到加好友申请");
    List<V2TimFriendApplication> newlist = List.empty(growable: true);
    list.forEach((element) {
      if (element.type != 2) {
        newlist.add(element);
      }
    });
    if (newlist.isNotEmpty) {
      // Provider.of<FriendApplicationModel>(context, listen: false)
      //     .setFriendApplicationResult(newlist);
    }
  }
}
