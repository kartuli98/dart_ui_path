import 'package:flutter/material.dart';
import 'dart:math' as math;

const radiantTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 12,
);

class RectPainter extends CustomPainter {
  late Offset center;
  late double bigRadius;
  late double smallRadius;
  late List<(Offset, double)> positions;

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
    final matrix = Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1);

    addRRect(canvas, size);
  }

  void addRRect(Canvas canvas, Size size) {
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTRB(0, 0, size.width, size.height), Radius.circular(40)));
    canvas.drawPath(path, standartPaint);
  }

  void addRect(Canvas canvas, Size size) {
    final path = Path()..addRect(Rect.fromLTRB(0, 0, size.width, size.height));
    canvas.drawPath(path, standartPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}