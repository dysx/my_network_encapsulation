
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/generated/l10n.dart';
import 'package:my_network_encapsulation/network/request_util.dart';
import 'package:my_network_encapsulation/provider/theme_data_model.dart';
import 'package:provider/provider.dart';

/// @name：
/// @author qds
/// @date 2020/10/23
class Test extends StatefulWidget {

  Test({Key key,this.name,this.age}) : super(key: key);

  String name;
  String age;

  @override
  State createState() => new TestState();
}

class TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('标题'),
        // centerTitle: true,
        leading: null,
        actions: [
          Text('123'),
          Text('123'),
          Text('123'),
        ],
        flexibleSpace: Text('456'),
        // bottom: Text(''),
      ),
      body:
      Column(
        children: <Widget>[
          FlatButton(
            onPressed: (){
              Provider.of<ThemeDataModel>(context,listen: false).switchTheme(0);
            },
            child: Text('蓝色主题'),
          ),
          FlatButton(
            onPressed: (){
              Provider.of<ThemeDataModel>(context,listen: false).switchTheme(1);
            },
            child: Text('黑色主题'),
          ),
          FlatButton(
            onPressed: (){
              Provider.of<ThemeDataModel>(context,listen: false).switchTheme(2);
            },
            child: Text('黄色主题'),
          ),
          FlatButton(
            onPressed: () async {

              // await RequestUtil.getRecommends(1, 20).then((res){
              //   print("返回结果：$res");
              //   print("${res.result[0].userId}");
              // });

              await RequestUtil.login('15015802692', 'qds123456').then((res){
                print("返回结果：$res");
              });

              // Navigater.pop();


              // computeTest();

              // streamTest();
            },
            child: Text(S.of(context).test),
          )
        ],
      )
    );
  }

  computeTest() async {
    Completer c = new Completer();
    for (var i = 0; i < 1000; i++) {
      print('$i');
      if (i == 900 && c.isCompleted == false) {
        print("900: ${c.isCompleted}");
        c.completeError('error in $i');
      }
      if (i == 800 && c.isCompleted == false) {
        print("800: ${c.isCompleted}");
        c.complete('complete in $i');
      }
    }

    try {
      String res = await c.future;
      print("得到complete传入的返回值: $res"); //得到complete传入的返回值 'complete in 800'
    } catch (e) {
      print("捕获completeError返回的错误: $e");//捕获completeError返回的错误
    }
  }

  streamTest() {
    var data = [1, 2, 3, 4];
    var stream = new Stream.fromIterable(data);
    //匿名箭头函数
    stream.listen((e)=>print(e), onDone: () => print('Done'));
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // HttpUtils.cancelRequest();
    super.dispose();
    // DioConnectivityRequestRetrier().streamSubscription?.cancel();
  }
}