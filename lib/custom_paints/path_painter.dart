import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:math' as math;

const radiantTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 12,
);

class PathPainter extends CustomPainter {
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

    addPath(canvas, size);
  }

  ///https://blog.codemagic.io/flutter-matrix4-perspective-transformations/
  void addPathWithMatrix(Canvas canvas, Size size, Float64List matrix4) {
    final path = Path();
    final center1 = Offset(size.width * 0.1, size.height * 0.1);
    final center2 = Offset(size.width * 0.9, size.height * 0.1);
    final innerPath = Path()
      ..addOval(Rect.fromCenter(
          center: center1, width: smallRadius, height: smallRadius))
      ..addOval(Rect.fromCenter(
          center: center2, width: smallRadius, height: smallRadius));
    path.addOval(Rect.fromCenter(
        center: center, width: smallRadius * 2, height: smallRadius * 2));
    path.addPath(innerPath, Offset.zero, matrix4: matrix4);
    canvas.drawPath(path, standartPaint);
  }

  void addPath(Canvas canvas, Size size) {
    final path = Path();
    final center1 = Offset(size.width * 0.1, size.height * 0.1);
    final center2 = Offset(size.width * 0.9, size.height * 0.1);
    final innerPath = Path()
      ..addOval(Rect.fromCenter(
          center: center1, width: smallRadius, height: smallRadius))
      ..addOval(Rect.fromCenter(
          center: center2, width: smallRadius, height: smallRadius));
    path.addOval(Rect.fromCenter(
        center: center, width: smallRadius * 2, height: smallRadius * 2));
    path.addPath(innerPath, Offset.zero);
    canvas.drawPath(path, standartPaint);
  }

 @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}