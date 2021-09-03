import 'package:flutter/material.dart';

abstract class Leader {
  late Leader nextHandler;

  void handleRequest(int money) {
    print(getLeader());
    if (money <= limit()) {
      handle(money);
    } else {
      print('权限不足，请往上走');
      nextHandler.handleRequest(money);
    }
  }

  int limit();

  String getLeader();

  void handle(int money);
}

class A extends Leader {
  @override
  String getLeader() {
    // TODO: implement getLeader
    return '我是组长';
  }

  @override
  void handle(int money) {
    // TODO: implement handle
    print('组长：同意报销$money元');
  }

  @override
  int limit() {
    // TODO: implement limit
    return 1000;
  }
}

class B extends Leader {
  @override
  String getLeader() {
    // TODO: implement getLeader
    return '我是经理';
  }

  @override
  void handle(int money) {
    // TODO: implement handle
    print('经理：同意报销$money元');
  }

  @override
  int limit() {
    // TODO: implement limit
    return 5000;
  }
}

class C extends Leader {
  @override
  String getLeader() {
    // TODO: implement getLeader
    return '我是老板';
  }

  @override
  void handle(int money) {
    // TODO: implement handle
    print('老板：同意报销$money元');
  }

  @override
  int limit() {
    // TODO: implement limit
    return 1000000;
  }
}

class LeaderWidget extends StatelessWidget {
  LeaderWidget({Key? key}) : super(key: key);
  TextEditingController controller = TextEditingController();
  A aLead = A();
  B bLead = B();
  C cLead = C();

  @override
  Widget build(BuildContext context) {
    aLead.nextHandler = bLead;
    bLead.nextHandler = cLead;
    return Scaffold(
      body: Center(
          child: Column(
            children: [
              TextField(
                controller: controller,
              ),
              InkWell(
                onTap: () {
                  aLead.handleRequest(int.parse(controller.text));
                },
                child: Text('点击'),
              )
            ],
          )),
    );
  }
}
