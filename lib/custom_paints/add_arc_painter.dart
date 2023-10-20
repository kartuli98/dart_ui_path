import 'dart:ui';

import 'package:canvas_path/custom_paints/utils.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

const radiantTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 12,
);

class ArcPainter extends CustomPainter {
  late  Offset center;
  late  double bigRadius;
  late  double smallRadius;
  final Paint standartPaint = Paint();

  void initializingGeneralVariables(Size size) {
    center = Offset(size.width / 2, size.height / 2);
    bigRadius = math.min(size.width, size.height) / 2;
    smallRadius = bigRadius * 0.8;
  }

  @override
  void paint(Canvas canvas, Size size) {
    initializingGeneralVariables(size);

    addArc(canvas, size);
  }
  
  void addArc(Canvas canvas, Size size) {
    drawDegrees(canvas, size);

    final Rect oval = Rect.fromCircle(center: center, radius: smallRadius);
    final double startAngle = math.pi / 4;
    final double sweepAngle = math.pi;

    final startAnglePath = Path()..addArc(oval, 0, math.pi / 4);
    final sweepAnglePath = Path()..addArc(oval, math.pi / 4, math.pi);

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    ///start angle
    canvas.drawPath(startAnglePath, paint..color = Colors.green.withOpacity(0.5));
    final startAngleCenter = startAnglePath.getBounds().center;
    drawText(canvas: canvas, position: Offset(startAngleCenter.dx - 50, startAngleCenter.dy), text: "startAngle", fontSize: 20, color: Colors.green);
    ///sweep angle
    canvas.drawPath(sweepAnglePath, paint..color = Colors.blue.withOpacity(0.5));
    final sweepAngleCenter = sweepAnglePath.getBounds().center;
    drawText(canvas: canvas, position: Offset(sweepAngleCenter.dx - 50, sweepAngleCenter.dy), text: "sweepAngle", fontSize: 20, color: Colors.blueAccent);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}