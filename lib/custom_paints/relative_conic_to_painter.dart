import 'package:flutter/material.dart';
import 'dart:math' as math;

const radiantTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 12,
);

class RelativeConicToPainter extends CustomPainter {
  late Offset center;
  late double bigRadius;

  final Paint standartPaint = Paint();

  void initializingGeneralVariables(Size size) {
    center = Offset(size.width / 2, size.height / 2);
    bigRadius = math.min(size.width, size.height) / 2;
  }

  @override
  void paint(Canvas canvas, Size size) {
    initializingGeneralVariables(size);
    relativeConicTo(canvas, size);
  }

  void relativeConicTo(Canvas canvas, Size size) {
    ///If the weight is greater than 1, then the curve is a hyperbola; if the weight equals 1, it's a parabola; and if it is less than 1, it is an ellipse.
    final width = 1.3;
    final path = Path()
      ..moveTo(0, center.dx)
      ..relativeConicTo(center.dx, size.height, size.width, center.dy, width);

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
          ..strokeWidth = 7
          ..color = Colors.green);
  }

  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}