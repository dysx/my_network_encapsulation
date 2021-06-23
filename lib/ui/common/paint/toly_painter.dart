import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/util/paintUtil/dash_painter.dart';

class TolyPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.orangeAccent
      ..strokeWidth = 1;

    final Path path = Path();
    // path.moveTo(-100, 0);
    // path.lineTo(100, 0);
    // path.moveTo(0, -100);
    // path.lineTo(0, 100);

    path.addOval(Rect.fromCircle(center: Offset.zero, radius: 100));
    path.addOval(Rect.fromCircle(center: Offset.zero, radius: 80));
    path.addOval(Rect.fromCircle(center: Offset.zero, radius: 60));
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromCircle(center: Offset.zero, radius: 100),
      Radius.circular(20),
    ));
    const DashPainter(span: 4, step: 9).paint(canvas, path, paint);
  }

  @override
  bool shouldRepaint(covariant TolyPainter oldDelegate) => true;
}