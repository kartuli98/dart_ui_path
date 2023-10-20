import 'package:flutter/material.dart';
import 'dart:math' as math;

const radiantTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 12,
);

class PolygonPainter extends CustomPainter {
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

    addPolygon(canvas, size);
  }

  void addPolygon(Canvas canvas, Size size) {
    final points = <Offset>[
      center,
      Offset(center.dx, size.height),
      Offset(size.width, size.height),
      Offset(size.width, 0),
      Offset(0, 0),
      // Offset(0, center.dy),
    ];
    final path = Path()..addPolygon(points, true);
    canvas.drawPath(
        path,
        standartPaint
          ..strokeWidth = 10
          ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}