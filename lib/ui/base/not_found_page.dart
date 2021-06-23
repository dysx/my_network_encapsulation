import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @name: 404页面
/// 当路由表中没有匹配的路径时，跳转到404页面
class NotFoundPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Text('404页面'),
      ),
    );
  }
}