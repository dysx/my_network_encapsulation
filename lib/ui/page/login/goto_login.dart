import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/util/buttons.dart';

///@name: 登陆提示

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoToLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new GoToLoginState();
}

class GoToLoginState extends State<GoToLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        // backgroundColor: MyColors.grey_f8f8,
      ),
      body: SafeArea(
        child: Center(
            child: ordinaryButton(
              text: '去登陆',
              // backgroundColor: Colors.blue,
              // style: MyTextStyles.fourteenWhite,
              // buttonSize: Size(170.w,36.w),
            )
        ),
      ),
    );
  }

}