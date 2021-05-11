import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/ui/common/button/outlined_button.dart';

/// @name：dart语法测试
/// @author qds
/// @date 2020/10/23
class GrammarTest extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          MyOutlinedButton(
            onPressed: (){
              _test();
            },
            text: "dart语法测试",
          )
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