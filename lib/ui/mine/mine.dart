
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mine extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MineState();
}

class MineState extends State<Mine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text('这是我的页面'),
          ),
        ),
      ),
    );
  }

}