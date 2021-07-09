import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/routes/navigater.dart';
import 'package:my_network_encapsulation/routes/router_manger.dart';
import 'package:my_network_encapsulation/ui/common/button/outlined_button.dart';

class TestD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: MyOutlinedButton(
            onPressed: (){
              Navigater.popUntil(RouteName.testA);
            },
            text: "回到a",
          ),
        ),
      ),
    );
  }
}