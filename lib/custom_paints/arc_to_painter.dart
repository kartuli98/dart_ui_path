import 'package:canvas_path/custom_paints/utils.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

const radiantTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 12,
);

class ArcToPainter extends CustomPainter {
  late Offset center;
  late double bigRadius;
  late double smallRadius;

  final Paint standartPaint = Paint();

  void initializingGeneralVariables(Size size) {
    center = Offset(size.width / 2, size.height / 2);
    bigRadius = math.min(size.width, size.height) / 2;
    smallRadius = bigRadius * 0.8;
  }

  @override
  void paint(Canvas canvas, Size size) {
    initializingGeneralVariables(size);

    arcTo(canvas, size);
  }

  void arcTo(Canvas canvas, Size size) {
    drawBounds(canvas, size);
    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    final startAngle = 0.0;
    final endAngle = 3 * math.pi / 2;
    final path = Path()..arcTo(rect, startAngle, endAngle, true);
    canvas.drawPath(path, standartPaint..style = PaintingStyle.stroke..color = Colors.green..strokeWidth = 5);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}