import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/routes/navigater.dart';
import 'package:my_network_encapsulation/routes/router_manger.dart';
import 'package:my_network_encapsulation/ui/base/common_widgets.dart';
import 'package:my_network_encapsulation/ui/common/button/outlined_button.dart';

class TestA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.appBar(title: 'testA', actions: [Text('123')]),
      body: SafeArea(
        child: Center(
          child: MyOutlinedButton(
            onPressed: () {
              Navigater.pushNamed(RouteName.testB);
            },
            text: "跳到b",
          ),
        ),
      ),
    );
  }
}
