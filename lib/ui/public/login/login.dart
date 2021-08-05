
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/routes/my_navigator.dart';
import 'package:my_network_encapsulation/routes/router_manger.dart';
import 'package:my_network_encapsulation/util/buttons.dart';

///@name: 登陆页
class Login extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Column(
            children: [
              ordinaryButton(
                onPressed: (){
                  MyNavigator.popUntil(RouteName.login);
                },
                text: "测试路由",
              ),
              Text('这是一个登陆页')
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}