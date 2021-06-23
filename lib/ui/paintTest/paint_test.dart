import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/ui/common/paint/arc_test.dart';
import 'package:my_network_encapsulation/ui/common/paint/toly_painter.dart';
import 'package:my_network_encapsulation/ui/paintTest/paint_flower.dart';

/// @name：
/// @author qds
/// @date 2020/10/23
class PaintTest extends StatefulWidget {
  PaintTest({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new PaintTestState();
}

class PaintTestState extends State<PaintTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('标题111'),
        // centerTitle: true,
        leading: null,
        actions: [
          Text('123'),
          Text('123'),
          Text('123'),
        ],
        flexibleSpace: Text('456'),
        // bottom: Text(''),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   width: 300,
            //   height: 300,
            //   color: Colors.red,
            //   child: CustomPaint(
            //     size: Size(200, 200),
            //     painter: TolyPainter(),
            //   ),
            // ),

            Container(
              width: 200,
              height: 200,
              color: Colors.blue,
              child: Stack(
                children: [
                  Center(
                    child: CustomPaint(
                      size: Size(200, 200),
                      painter: ArcTest(),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Text('123'),
                    ),
                  )
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 20),
              width: double.maxFinite,
              height: 200,
              color: Colors.white,
              child: Center(
                child: CustomPaint(
                  size: Size(200, 200),
                  painter: TolyPainter(),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 20),
              width: double.maxFinite,
              height: 200,
              color: Colors.white,
              child: Center(
                child: CustomPaint(
                  size: Size(200,200),
                  painter: PaintFlower(),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
