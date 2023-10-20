import 'dart:typed_data';
import 'dart:ui';

import 'package:canvas_path/custom_paints/add_arc_painter.dart';
import 'package:canvas_path/custom_paints/arc_to_painter.dart';
import 'package:canvas_path/custom_paints/arc_to_point_painter.dart';
import 'package:canvas_path/custom_paints/conic_to_painter.dart';
import 'package:canvas_path/custom_paints/cubic_to_painter.dart';
import 'package:canvas_path/custom_paints/oval_painter.dart';
import 'package:canvas_path/custom_paints/path_painter.dart';
import 'package:canvas_path/custom_paints/polygon_painter.dart';
import 'package:canvas_path/custom_paints/quadratic_bezier_to_painter.dart';
import 'package:canvas_path/custom_paints/rect_painter.dart';
import 'package:canvas_path/custom_paints/relative_arc_to_point_painter.dart';
import 'package:canvas_path/custom_paints/relative_conic_to_painter.dart';
import 'package:canvas_path/custom_paints/relative_cubic_to_painter.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  final List<Widget> painters = [
  CustomPainterWidget(painter: ArcPainter()),
  CustomPainterWidget(painter: ArcToPainter()),
  CustomPainterWidget(painter: ArcToPointPainter()),
  CustomPainterWidget(painter: RelativeArcToPointPainter()),
    const ConicToWidget(),
  CustomPainterWidget(painter: RelativeConicToPainter()),
    const CubicWidget(),
    const RelativeToCubicWidget(),
  CustomPainterWidget(painter: OvalPainter()),
  CustomPainterWidget(painter: PathPainter()),
  CustomPainterWidget(painter: PolygonPainter()),
  CustomPainterWidget(painter: RectPainter()),
  CustomPainterWidget(painter: QuadraticBezierToPainter()),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Row(
            children: [
              Drawer(
                width: 100,
                child: ListView(
                  children: List.generate(painters.length, (index) => ListTile(
                    title: Text(painters[index].toString().split("#").first, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: index == _selectedIndex ? Theme.of(context).primaryColor : null),),
                    onTap: () {
                      _onItemTapped(index);
                    },
                  ))
                ),
              ),
              Expanded(
                  child: SizedBox()),
              painters[_selectedIndex],
              Expanded(
                  child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomPainterWidget extends StatelessWidget {
  const CustomPainterWidget({
    super.key,
    required this.painter,
  });

  final CustomPainter painter;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: CustomPaint(
        size: const Size(360, 340),
        painter: painter,
      ),
    );
  }
}
