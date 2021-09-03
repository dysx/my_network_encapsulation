import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:console/console.dart';
import 'package:image/image.dart' as image;
import 'package:xmpp_stone/src/logger/Log.dart';
import 'package:xmpp_stone/xmpp_stone.dart' as xmpp;

final String TAG = 'example';

class XmppUtil {
  static late xmpp.MessageHandler messageHandler;
  static late xmpp.PresenceManager presenceManager;
  static late xmpp.RosterManager rosterManager;

  static late xmpp.Connection connection;

  static String userAtDomain = 'qds@192.168.168.247';
  static String password = '123456';

  static void init() {
    Log.logLevel = LogLevel.DEBUG;
    Log.logXmpp = true;
    xmpp.Jid jid = xmpp.Jid.fromFullJid(userAtDomain);
    xmpp.XmppAccountSettings account = xmpp.XmppAccountSettings(
        userAtDomain, jid.local, jid.domain, password, 5222,
        resource: 'app');
    connection = xmpp.Connection(account);
    connection.connect();

    xmpp.MessagesListener messagesListener = xmpp.MyMessagesListener();
    xmpp.MyConnectionStateChangedListener(connection, messagesListener);

    messageHandler = xmpp.MessageHandler.getInstance(connection);
    presenceManager = xmpp.PresenceManager.getInstance(connection);
    rosterManager = xmpp.RosterManager.getInstance(connection);

    presenceManager.subscriptionStream.listen((streamEvent) {
      if (streamEvent.type == xmpp.SubscriptionEventType.REQUEST) {
        Log.d(TAG, 'Accepting presence request');
        presenceManager.acceptSubscription(streamEvent.jid);
      }
    });
  }

  /// 订阅好友(类似加好友)
  static void subscribe({required receiver}) {
    xmpp.Jid receiverJid = xmpp.Jid.fromFullJid(receiver);
    presenceManager.subscribe(receiverJid);
  }

  /// 取消订阅好友
  static void unSubscribe({required receiver}) {
    xmpp.Jid receiverJid = xmpp.Jid.fromFullJid(receiver);
    presenceManager.unsubscribe(receiverJid);
    // xmpp.RosterManager.getInstance(connection)
    //     .removeRosterItem(xmpp.Buddy(jid));
  }

  /// 删除好友
  static void deleteRoster({required receiver}) {
    xmpp.Jid receiverJid = xmpp.Jid.fromFullJid(receiver);
    rosterManager.removeRosterItem(xmpp.Buddy(receiverJid));
  }

  /// 私聊
  static void send(
      {required receiver,
      required content,
      required xmpp.MessageType messageType}) {
    xmpp.Jid receiverJid = xmpp.Jid.fromFullJid(receiver);
    messageHandler.sendMessage(receiverJid, content, messageType);
  }

  /// 群聊
  static void sendGroup(
      {required receiver,
      required content,
      required xmpp.MessageType messageType}) {
    xmpp.Jid receiverJid = xmpp.Jid.fromFullJid(receiver);
    messageHandler.sendGroupMessage(receiverJid, content, messageType);
  }

  /// 加入群
  static void joinGroup({required receiver}) {
    String presence =
        ''' <presence from="$userAtDomain" to="$receiver" xmlns="jabber:client"><x xmlns="http://jabber.org/protocol/muc"><history/></x></presence>''';
    connection.write(presence);
  }

  /// 退出群
  static void exitGroup({required receiver}) {
    String presence =
        '''<presence to="$receiver" type="unavailable" xmlns="jabber:client"><priority>0</priority><c xmlns="http://jabber.org/protocol/caps"/></presence>''';
    connection.write(presence);
  }

  /// 请求好友列表
  static void queryFriends() {
    String iq =
        '''<iq from='juliet@example.com/balcony' type='get' id='roster_1'>
     <query xmlns='jabber:iq:roster'/>
   </iq>''';
    connection.write(iq);
  }
}

class ExampleConnectionStateChangedListener
    implements xmpp.ConnectionStateChangedListener {
  late xmpp.Connection _connection;
  late xmpp.MessagesListener _messagesListener;

  late StreamSubscription<String> subscription;

  ExampleConnectionStateChangedListener(
      xmpp.Connection connection, xmpp.MessagesListener messagesListener) {
    _connection = connection;
    _messagesListener = messagesListener;
    _connection.connectionStateStream.listen(onConnectionStateChanged);
  }

  @override
  void onConnectionStateChanged(xmpp.XmppConnectionState state) {
    if (state == xmpp.XmppConnectionState.Ready) {
      Log.d(TAG, 'Connected');
      var vCardManager = xmpp.VCardManager(_connection);
      vCardManager.getSelfVCard().then((vCard) {
        if (vCard != null) {
          Log.d(TAG, 'Your info' + vCard.buildXmlString());
        }
      });
      var messageHandler = xmpp.MessageHandler.getInstance(_connection);
      var rosterManager = xmpp.RosterManager.getInstance(_connection);
      messageHandler.messagesStream.listen(_messagesListener.onNewMessage);
      sleep(const Duration(seconds: 1));
      var receiver = 'nemanja2@test';
      var receiverJid = xmpp.Jid.fromFullJid(receiver);
      rosterManager.addRosterItem(xmpp.Buddy(receiverJid)).then((result) {
        if (result.description != null) {
          Log.d(TAG, 'add roster' + result.description);
        }
      });
      sleep(const Duration(seconds: 1));
      vCardManager.getVCardFor(receiverJid).then((vCard) {
        if (vCard != null) {
          Log.d(TAG, 'Receiver info' + vCard.buildXmlString());
          if (vCard != null && vCard.image != null) {
            var file = File('test456789.jpg')
              ..writeAsBytesSync(image.encodeJpg(vCard.image));
            Log.d(TAG, 'IMAGE SAVED TO: ${file.path}');
          }
        }
      });
      var presenceManager = xmpp.PresenceManager.getInstance(_connection);
      presenceManager.presenceStream.listen(onPresence);
    }
  }

  void onPresence(xmpp.PresenceData event) {
    Log.d(
        TAG,
        'presence Event from ' +
            event.jid.fullJid +
            ' PRESENCE: ' +
            event.showElement.toString());
  }
}

Stream<String> getConsoleStream() {
  return Console.adapter.byteStream().map((bytes) {
    var str = ascii.decode(bytes);
    str = str.substring(0, str.length - 1);
    return str;
  });
}

class ExampleMessagesListener implements xmpp.MessagesListener {
  @override
  void onNewMessage(xmpp.MessageStanza message) {
    if (message.body != null) {
      print('---------');
      print(message.type);
      print(message.subject);
      print(message.thread);
      print(message.id);
      print(message.fromJid.userAtDomain);
      print(message.toJid.userAtDomain);
      print(message.name);
      print(message.children.toString());
      print(message.attributes.toString());
      print(message.textValue);
      print(message.body);
      print('===========');
      // Toast.showMsg(message.body);
      Log.d(
          TAG,
          format(
              'New Message from {color.blue}${message.fromJid.userAtDomain}{color.end} message: {color.red}${message.body}{color.end}'));
    }
  }
}
