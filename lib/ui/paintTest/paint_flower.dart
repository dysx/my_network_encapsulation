
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/util/paintUtil/dash_painter.dart';

class PaintFlower extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    /// 画点
    // Paint _pointPaint = Paint()
    // ..color = Colors.red
    // ..strokeWidth = 3;
    // var points = [
    //   Offset(0, 0),
    //   Offset(size.width / 2, size.height / 2),
    //   Offset(size.width, size.height),
    // ];
    // canvas.drawPoints(PointMode.points, points, _pointPaint);

    /// 画线
    // Paint _linePaint = Paint()
    // ..color = Colors.red
    // ..strokeWidth = 3;
    // canvas.drawLine(Offset.zero, Offset(size.width,size.height / 2), _linePaint);

    /// 绘制路径
    Paint _pathPaint = Paint()
    ..style = PaintingStyle.stroke
        ..color = Colors.red
        ..strokeWidth = 3;
    // Path _path = Path()
    // ..moveTo(0, 0)
    // ..lineTo(size.width, 0)
    // ..lineTo(size.width, size.height)
    // ..close();
    // canvas.drawPath(_path, _pathPaint);


    // canvas.drawCircle(Offset(size.width/2,size.height/2), 20, _pathPaint);
    // canvas.drawOval(Rect.fromLTRB(0, 0, size.width, size.height/2), _pathPaint);
    canvas.drawArc(Rect.fromLTRB(0, 0, size.width, size.height), 0, pi*2, false, _pathPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}