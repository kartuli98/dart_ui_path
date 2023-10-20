import 'package:canvas_path/custom_paints/utils.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../widgets/offset_input.dart';

const radiantTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 12,
);

const size = Size(360, 340);

class RelativeToCubicWidget extends StatefulWidget {
  const RelativeToCubicWidget({super.key});

  @override
  State<RelativeToCubicWidget> createState() => _RelativeCubitWidgetState();
}

class _RelativeCubitWidgetState extends State<RelativeToCubicWidget> {

  late Offset point0;
  late Offset point1;
  late Offset point2;
  late Offset point3;

  @override
  void initState() {
    super.initState();
    point0 = Offset(0, size.height / 2);
    point3 = Offset(size.width, size.height /2);
    point1 = Offset(size.width * 1 / 4, size.height);
    point2 = Offset(size.width * 0.6, 0);
  }

  void setOffsetDx(String dx, Offset offset) {
    setState(() {
      offset = Offset(double.parse(dx), offset.dy);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            OffsetInput(
              initialOffset: point0,
              title: "p0", onSubmittedDx: (dx) {
                setState(() {
                  point0 = Offset(double.parse(dx), point0.dy);
                });
            }, onSubmittedDy: (dy) {
              setState(() {
                point0 = Offset(point0.dx, double.parse(dy));
              });
            },),
            OffsetInput(
              initialOffset: point1,
              title: "p1",
              onSubmittedDx: (dx) {
                setState(() {
                  point1 = Offset(double.parse(dx), point1.dy);
                });
              }, onSubmittedDy: (dy) {
              setState(() {
                point1 = Offset(point1.dx, double.parse(dy));
              });
            },),
            OffsetInput(
              initialOffset: point2,
              title: "p2",
              onSubmittedDx: (dx) {
                setState(() {
                  point2 = Offset(double.parse(dx), point2.dy);
                });
              }, onSubmittedDy: (dy) {
              setState(() {
                point2 = Offset(point2.dx, double.parse(dy));
              });
            },),
            OffsetInput(
              initialOffset: point3,
              title: "p3",
              onSubmittedDx: (dx) {
                setState(() {
                  point3 = Offset(double.parse(dx), point3.dy);
                });
              }, onSubmittedDy: (dy) {
              setState(() {
                point3 = Offset(point3.dx, double.parse(dy));
              });
            },),
            const SizedBox(height: 20,),
            Text("void relativeCubicTo(   double x1,   double y1,   double x2,   double y2,   double x3,   double y3, )", style: Theme.of(context).textTheme.titleMedium,),
            const SizedBox(height: 20,),
            FittedBox(
              child: CustomPaint(
                size: size,
                painter: RelativeCubicToPainter(
                  point0,
                  point1,
                  point2,
                  point3
                )
              ),
            ),
          ],
        );
      }
    );
  }
}

class RelativeCubicToPainter extends CustomPainter {

  final Offset point0;
  final Offset point1;
  final Offset point2;
  final Offset point3;

  RelativeCubicToPainter(
      this.point0,
      this.point1,
      this.point2,
      this.point3,
      );

  late Offset center;

  final Paint standartPaint = Paint();

  void initializingGeneralVariables(Size size) {
    center = Offset(size.width / 2, size.height / 2);
  }

  @override
  void paint(Canvas canvas, Size size) {
    initializingGeneralVariables(size);

    relativeCubicTo(canvas, size);
  }

  void relativeCubicTo(Canvas canvas, Size size) {

    final path = Path()
      ..moveTo(point0.dx, point0.dy)
      ..relativeCubicTo(point1.dx, point1.dy, point2.dx, point2.dy, point3.dx, point3.dy);


    drawBounds(canvas, size);

    canvas.drawPath(
        path,
        standartPaint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 7
          ..color = Colors.green);
    ///p0
    drawText(canvas: canvas, position: Offset(0 + 10, center.dy - 10), text: point0.uiString("p0"), fontSize: 22);
    ///p1
    drawDashLine(canvas, point0, point1);
    drawText(canvas: canvas, position: Offset(point1.dx - 60, point1.dy + 10), text: point1.uiString("p1"), fontSize: 22);
    ///p2
    drawDashLine(canvas, Offset(point3.dx + point0.dx, point3.dy + point0.dy), point2);
    drawText(canvas: canvas, position: Offset(point2.dx + 10, point2.dy - 10), text: point2.uiString("p2"), fontSize: 22);
    ///p3
    drawText(
        canvas: canvas, position: Offset(point3.dx - 120, point3.dy + point0.dy + 10), text: point3.uiString("p3"), fontSize: 22);
    drawText(
        canvas: canvas, position: Offset(point3.dx - 120, point3.dy + point0.dy + 30), text: "+${point0.uiString("p0")}", fontSize: 22);
    drawText(
        canvas: canvas, position: Offset(point3.dx - 120, point3.dy + point0.dy + 50), text: "       =", fontSize: 22);
    drawText(
        textMaxWidth: 160,
        canvas: canvas, position: Offset(point3.dx + point0.dx - 120, point3.dy + point0.dy + 70), text: Offset(point3.dx, point3.dy + point0.dy).uiString("end"), fontSize: 22);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}