import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/dart/dart_test.dart';
import 'package:my_network_encapsulation/ui/common/button/outlined_button.dart';
import 'package:my_network_encapsulation/util/size_util.dart';

/// @name：dart语法测试
/// @author qds
/// @date 2020/10/23
class GrammarTest extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          MyOutlinedButton(
            onPressed: (){
              DartTest dartTest = DartTest();
              dartTest.test();
              PageTest.scorllDown();
            },
            text: "dart语法测试",
          ),
        ],
      ),
    );
  }

  void _test() {
    int a;
    a = null;
    print("a is $a.");
  }
}