import 'package:flutter/material.dart';
import 'dart:math' as math;

const radiantTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 12,
);

class ArcToPointPainter extends CustomPainter {
  late Offset center;
  late double bigRadius;
  late double smallRadius;

  final Paint standartPaint = Paint();

  void initializingGeneralVariables(Size size) {
    center = Offset(size.width / 2, size.height / 2);
    bigRadius = math.min(size.width, size.height) / 2;
    smallRadius = bigRadius * 0.8;}

  @override
  void paint(Canvas canvas, Size size) {
    initializingGeneralVariables(size);

    arcToPoint(canvas, size);
  }

  void arcToPoint(Canvas canvas, Size size) {
    final arcEnd = Offset(size.width, size.height * 0.9);
    final path = Path()
      ..moveTo(0, size.height * 0.1)
      ..arcToPoint(arcEnd,
          radius: Radius.circular(100), largeArc: true, clockwise: false);

    canvas.drawRect(
        Rect.fromCenter(center: center, width: size.width, height: size.height),
        Paint()
          ..color = Colors.red
          ..strokeWidth = 5
          ..style = PaintingStyle.stroke);

    canvas.drawPath(
        path,
        standartPaint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5
          ..color = Colors.green);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
