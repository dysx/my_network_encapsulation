
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/util/paintUtil/dash_painter.dart';

class ArcTest extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    /// 画笔
    Paint paint = Paint()
      ..style = PaintingStyle.stroke //笔
      ..color = Colors.yellow // 画笔颜色
      ..strokeWidth = 1;  // 画笔宽度

    // /// 画圆弧
    // canvas.drawCircle(Offset.zero, 20, paint);
    //
    // /// 画内圆
    // canvas.drawCircle(Offset.zero, 19, Paint()..color = Color(0xFFFFFAF1));

    final Path path = Path();
    // path.moveTo(-200, 0);
    // path.lineTo(200, 0);
    // path.moveTo(0, -200);
    // path.lineTo(0, 200);

    // path.addOval(Rect.fromCircle(center: Offset.zero, radius: 80));
    /// 圆角矩形
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromCircle(center: Offset.zero, radius: 50),
      Radius.circular(8),
    ));
    /// 将实线path路径变虚线
    const DashPainter(span: 4, step: 9).paint(canvas, path, paint);
  }

  @override
  bool shouldRepaint(covariant ArcTest oldDelegate) => true;
}