import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Second extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SecondState();
}

class SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('bloc测试')),
      body: SafeArea(
        child: Center(
          child: Text('这是第二个页面'),
        ),
      ),
    );
  }
}
