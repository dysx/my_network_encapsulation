
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Third extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ThirdState();
}

class ThirdState extends State<Third> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text('这是第三个页面'),
          ),
        ),
      ),
    );
  }

}