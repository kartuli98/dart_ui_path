import 'package:canvas_path/custom_paints/utils.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../widgets/offset_input.dart';
import '../widgets/value_input.dart';

const size = Size(360, 340);

class ConicToWidget extends StatefulWidget {
  const ConicToWidget({super.key});

  @override
  State<ConicToWidget> createState() => _RelativeCubitWidgetState();
}

class _RelativeCubitWidgetState extends State<ConicToWidget> {

  late Offset point0;
  late Offset point1;
  late Offset point2;
  late double w;

  @override
  void initState() {
    super.initState();
    w = 1.3;
    point0 = Offset(0, size.height / 2);
    point1 = Offset(size.width / 2, 0);
    point2 = Offset(size.width, size.height / 2);
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
              ValueInput(
                initialValue: w,
                title: "w",
                onSubmittedValue: (value) {
                  setState(() {
                    w = double.parse(value);
                  });
                },
              ),
              const SizedBox(height: 20,),
              Text("void conicTo(   double x1,   double y1,   double x2,   double y2,   double w, )", style: Theme.of(context).textTheme.titleMedium,),
              const SizedBox(height: 20,),
              FittedBox(
                child: CustomPaint(
                    size: size,
                    painter: ConicToPainter(
                        point0,
                        point1,
                        point2,
                        w
                    )
                ),
              ),
            ],
          );
        }
    );
  }
}


class ConicToPainter extends CustomPainter {

  final Offset point0;
  final Offset point1;
  final Offset point2;
  final double w;

  ConicToPainter(this.point0, this.point1, this.point2, this.w);

  late Offset center;
  late List<(Offset, double)> positions;

  final Paint standartPaint = Paint();

  void initializingGeneralVariables(Size size) {
    center = Offset(size.width / 2, size.height / 2);
  }

  @override
  void paint(Canvas canvas, Size size) {
    initializingGeneralVariables(size);
    conicTo(canvas, size);
  }



  void conicTo(Canvas canvas, Size size) {
    ///If the weight is greater than 1, then the curve is a hyperbola; if the weight equals 1, it's a parabola; and if it is less than 1, it is an ellipse.
    final path = Path()
      ..moveTo(point0.dx, point0.dy)
      ..conicTo(point1.dx, point1.dy, point2.dx, point2.dy, w);

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


    ///p0
    drawText(canvas: canvas, position: Offset(point0.dx, point0.dy), text: point0.uiString("p0"), fontSize: 22);
    ///p1
    drawText(canvas: canvas, position: Offset(point1.dx, point1.dy), text: point1.uiString("p1"), fontSize: 22);
    ///p2
    drawText(canvas: canvas, position: Offset(point2.dx, point2.dy - 10), text: point2.uiString("p2"), fontSize: 22);
  }

  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}