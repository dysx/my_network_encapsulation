import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/base/base_inner_widget.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/util/im/xmpp_util.dart';
import 'package:xmpp_stone/xmpp_stone.dart';

/// @describe: bottomNavItem_third页面
/// @author: qds
/// @date:
// ignore: must_be_immutable
class Third extends BaseInnerWidget {
  @override
  BaseInnerWidgetState<BaseInnerWidget> getState() => ThirdState();

  @override
  int setIndex() => 2;
}

class ThirdState extends BaseInnerWidgetState<Third> {
  @override
  Widget buildWidget(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ordinaryButton(
              text: '消息页面',
              backgroundColor: AppColors.blue_91ff,
              onPressed: () {
                MyNavigator.pushNamed(RouteName.message);
              }),
          ordinaryButton(
              text: '订阅好友',
              backgroundColor: AppColors.blue_91ff,
              onPressed: () {
                String receiver = 'baobaoli@192.168.168.247';
                XmppUtil.subscribe(receiver: receiver);
              }),
          ordinaryButton(
              text: '取消订阅好友',
              backgroundColor: AppColors.blue_91ff,
              onPressed: () {
                String receiver = 'baobaoli@192.168.168.247';
                XmppUtil.unSubscribe(receiver: receiver);
              }),
          ordinaryButton(
              text: '删除好友',
              backgroundColor: AppColors.blue_91ff,
              onPressed: () {
                String receiver = 'baobaoli@192.168.168.247';
                XmppUtil.deleteRoster(receiver: receiver);
              }),
          ordinaryButton(
              text: 'app发送消息到用户',
              backgroundColor: AppColors.blue_91ff,
              onPressed: () {
                String receiver = 'baobaoli@192.168.168.247';
                String content = 'app发送消息私聊';
                XmppUtil.send(
                    receiver: receiver,
                    content: content,
                    messageType: MessageType.TEXT);
              }),
          ordinaryButton(
              text: 'app 用户加入群',
              backgroundColor: AppColors.blue_91ff,
              onPressed: () {
                String receiver = 'qds1群@conference.192.168.168.247/qdsapp';
                XmppUtil.joinGroup(receiver: receiver);
              }),
          ordinaryButton(
              text: 'app发送消息到群',
              backgroundColor: AppColors.blue_91ff,
              onPressed: () {
                String receiver = 'qds1群@conference.192.168.168.247';
                String content = 'app发送消息群聊';
                XmppUtil.sendGroup(
                    receiver: receiver,
                    content: content,
                    messageType: MessageType.TEXT);
              }),
          ordinaryButton(
              text: 'app 用户退出群',
              backgroundColor: AppColors.blue_91ff,
              onPressed: () {
                String receiver = 'qds1群@conference.192.168.168.247/qdsapp';
                XmppUtil.exitGroup(receiver: receiver);
              }),
          ordinaryButton(
              text: '请求好友列表',
              backgroundColor: AppColors.blue_91ff,
              onPressed: () {
                XmppUtil.queryFriends();
              }),
          ordinaryButton(
              text: '添加节点',
              backgroundColor: AppColors.blue_91ff,
              onPressed: () {
                XmppElement element = XmppElement();
                element.name = "image";
                element.textValue = "13456";
                // XmppElement element1 = XmppElement();
                // element1.name = "image";
                // element1.textValue = "13456";
                // element.addChild(element1);
                print('---');
                print(element.attributes);
                print(element.name);
                print(element.buildXml());
                // XmppElement().addChild(element);
              })
        ],
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
