import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/ui/paint/dialPlate.dart';

class AlarmPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AlarmPageState();
  }

}

class _AlarmPageState extends State<AlarmPage> {

  Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            painter: DialPlate(context,Color.fromARGB(255, 70, 0, 144),
                Color.fromARGB(255, 121, 83, 254)),
          )
        ],),
    );
  }
}
