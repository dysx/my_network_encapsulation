import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_network_encapsulation/ui/second/bloc/test_bloc.dart';

class Second extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SecondState();
}

class SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TestBloc(),
      child: Scaffold(
        appBar: AppBar(title: Text('bloc测试')),
        body: SafeArea(
          child: Center(
            child: Text('这是第二个页面'),
          ),
        ),
      ),
    );
  }
}
