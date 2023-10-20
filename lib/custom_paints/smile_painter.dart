import 'package:flutter/material.dart';
import 'dart:math' as math;

const radiantTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 12,
);

class SmilePainter extends CustomPainter {
  late final Offset center;
  late final double bigRadius;
  late final double smallRadius;
  late final List<(Offset, double)> positions;

  final Paint standartPaint = Paint();

  void initializingGeneralVariables(Size size) {
    center = Offset(size.width / 2, size.height / 2);
    bigRadius = math.min(size.width, size.height) / 2;
    smallRadius = bigRadius * 0.8;
    positions = [
      (Offset(size.width, size.height / 2), 0),
      (Offset(size.width, size.height), 45),
      (Offset(size.width / 2, size.height), 90),
      (Offset(0, size.height), 135),
      (Offset(0, size.height / 2), 180),
      (Offset.zero, 235),
      (Offset(size.width / 2, 0), 270),
      (Offset(size.width, 0), 315)
    ];
  }

  @override
  void paint(Canvas canvas, Size size) {
    initializingGeneralVariables(size);

    paintSmile(canvas, size);
  }

  void paintSmile(Canvas canvas, Size size) {
    final radius = math.min(size.width, size.height) / 2;
    final center = Offset(size.width / 2, size.height / 2);
    //Draw the body
    final bodyPaint = Paint()..color = Colors.yellow;
    canvas.drawCircle(center, radius, bodyPaint);
    //Draw the mouth
    final mouthPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius / 2), 0,
        math.pi, false, mouthPaint);
    //Draw the eyes
    final eyesPositions = <Offset>[
      Offset(center.dx - radius / 2, center.dy - radius / 2),
      Offset(center.dx + radius / 2, center.dy - radius / 2),
    ];
    for (final eye in eyesPositions) {
      canvas.drawCircle(eye, 10, Paint());
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}