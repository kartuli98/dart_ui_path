import 'dart:ui';

import 'package:flutter/material.dart';

void drawBounds(Canvas canvas, Size size) {
  canvas.drawRect(
      Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height)),
      Paint()
        ..color = Colors.red
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke);
}

const textStyle = TextStyle(
  color: Colors.black,
  fontSize: 12,
);

void drawText({
  required Canvas canvas,
  required Offset position,
  required String text,
  double? fontSize,
  Color? color,
  FontWeight? fontWeight = FontWeight.bold,
  double textMaxWidth = 150,
}) {
  final textSpan = TextSpan(
    text: text,
    style: textStyle.copyWith(fontSize: fontSize, fontWeight: fontWeight, color: color),
  );
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
  );
  textPainter.layout(
    minWidth: 0,
    maxWidth: textMaxWidth,
  );
  textPainter.paint(canvas, position);
}

void drawDashLine(Canvas canvas, Offset start, Offset end) {
  Paint _paint = Paint()
    ..color = Colors.black
    ..strokeWidth = 4.0
    ..style = PaintingStyle.stroke
    ..strokeJoin = StrokeJoin.round;

  var path = Path()
    ..moveTo(start.dx, start.dy)
    ..lineTo(end.dx, end.dy);

  Path dashPath = Path();

  double dashWidth = 10.0;
  double dashSpace = 5.0;
  double distance = 0.0;

  for (PathMetric pathMetric in path.computeMetrics()) {
    while (distance < pathMetric.length) {
      dashPath.addPath(
        pathMetric.extractPath(distance, distance + dashWidth),
        Offset.zero,
      );
      distance += dashWidth;
      distance += dashSpace;
    }
  }
  canvas.drawPath(dashPath, _paint);
}

void drawDegrees(Canvas canvas, Size size) {
  final positions = List.unmodifiable([
    (Offset(size.width, size.height / 2), 0),
    (Offset(size.width, size.height), 45),
    (Offset(size.width / 2, size.height), 90),
    (Offset(0, size.height), 135),
    (Offset(0, size.height / 2), 180),
    (Offset.zero, 235),
    (Offset(size.width / 2, 0), 270),
    (Offset(size.width, 0), 315)
  ]);
  for (final position in positions) {
    final textSpan = TextSpan(
      text: position.$2.toString(),
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    textPainter.paint(canvas, position.$1);
  }
}

extension OffsetExtensions on Offset {
  String uiString(String name) => "$name(${dx.toInt()},${dy.toInt()})";
}
