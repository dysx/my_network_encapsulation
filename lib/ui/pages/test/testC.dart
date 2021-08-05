import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/routes/my_navigator.dart';
import 'package:my_network_encapsulation/routes/router_manger.dart';
import 'package:my_network_encapsulation/util/buttons.dart';

class TestC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: ordinaryButton(
            onPressed: (){
              MyNavigator.pushNamed(RouteName.testD);
            },
            text: "跳到d",
          ),
        ),
      ),
    );
  }

}