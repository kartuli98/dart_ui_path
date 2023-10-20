import 'package:canvas_path/custom_paints/utils.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

const radiantTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 12,
);

class QuadraticBezierToPainter extends CustomPainter {
  late Offset center;

  final Paint standartPaint = Paint();

  void initializingGeneralVariables(Size size) {
    center = Offset(size.width / 2, size.height / 2);
  }

  @override
  void paint(Canvas canvas, Size size) {
    initializingGeneralVariables(size);

    quadraticBezierTo(canvas, size);
  }

  void quadraticBezierTo(Canvas canvas, Size size) {

    drawBounds(canvas, size);

    final path = Path()
      ..moveTo(0, center.dy)
      ..quadraticBezierTo(size.width / 4, size.height, size.width, center.dy);
    canvas.drawPath(path, standartPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}