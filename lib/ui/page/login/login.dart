
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/routes/navigater.dart';
import 'package:my_network_encapsulation/routes/router_manger.dart';
import 'package:my_network_encapsulation/ui/common/button/outlined_button.dart';

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
              MyOutlinedButton(
                onPressed: (){
                  Navigater.popUntil(RouteName.login);
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