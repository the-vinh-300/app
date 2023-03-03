import 'dart:async';
import 'dart:math';

import 'package:demo_flutter/Screens/Index/Pages/home_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../Component/object.dart';
import '../statistical_tab.dart';

class SaleData {
  SaleData(this.sales, this.year);
  final String year;
  final int sales;
}

class Chart extends StatefulWidget {
  final List<DataItem> dataset;
  Chart(this.dataset);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late Timer timer;
  double fullAngle = 0.0;
  double secondsToComple = 5.0;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 1000 ~/ 60), ((timer) {
      setState(() {
        fullAngle += 360.0 / (secondsToComple * 1000 ~/ 60);
        if (fullAngle >= 360.0) {
          fullAngle = 360.0;
          timer.cancel();
        }
      });
    }));
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        child: Container(
            // height: MediaQuery.of(context).size.height * 1 / 4,
            ),
        painter: ChartPainter(widget.dataset, fullAngle),
      ),
    );
  }
}

final linePaint = Paint()
  ..color = Colors.white
  ..strokeWidth = 2.0
  ..style = PaintingStyle.stroke;
final midPaint = Paint()
  ..color = Colors.white
  ..style = PaintingStyle.fill;
const textFieldTextBigSize = TextStyle(
    color: Colors.black38, fontWeight: FontWeight.bold, fontSize: 30.0);
const labelStyle = TextStyle(color: Colors.black, fontSize: 12.0);

class ChartPainter extends CustomPainter {
  final List<DataItem> dataset;
  final double fullAngle;
  ChartPainter(this.dataset, this.fullAngle);
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2.0, size.height / 2.0);
    final radius = size.width * 0.8;
    final rect = Rect.fromCenter(center: c, width: radius, height: radius);
    var startAngle = 0.0;

    dataset.forEach((element) {
      final sweepAngle = element.value * fullAngle * pi / 180.0;

      //draw lines
      drawSetor(canvas, element, rect, startAngle, sweepAngle);
      startAngle += sweepAngle;
      // print("${element.label} ${element.value}");
    });
    startAngle = 0.0;
    dataset.forEach((element) {
      final sweepAngle = element.value * fullAngle * pi / 180.0;
      //draw lines
      drawLine(canvas, c, radius, startAngle);
      startAngle += sweepAngle;
    });
    startAngle = 0.0;
    dataset.forEach((element) {
      final sweepAngle = element.value * fullAngle * pi / 180.0;
      //draw lines
      drawLabels(canvas, c, radius, startAngle, sweepAngle, element.label);
      startAngle += sweepAngle;
    });
    //draw the midle
    canvas.drawCircle(c, radius * 0.3, midPaint);
    //draw title
    drawTextCentered(canvas, c, "Số liệu \nthống kê", textFieldTextBigSize,
        radius * 0.6, (Size sz) {});
  }

  TextPainter measureText(
      String s, TextStyle style, double maxWidth, TextAlign align) {
    final span = TextSpan(text: s, style: style);
    final tp = TextPainter(
        text: span, textAlign: align, textDirection: TextDirection.ltr);
    tp.layout(minWidth: 0, maxWidth: maxWidth);
    return tp;
  }

  Size drawTextCentered(Canvas canvas, Offset position, String text,
      TextStyle style, double maxWidth, Function(Size sz) bgCb) {
    final tp = measureText(text, style, maxWidth, TextAlign.center);
    final pos = position + Offset(-tp.width / 2.0, -tp.height / 2.0);
    bgCb(tp.size);
    tp.paint(canvas, pos);
    return tp.size;
  }

  void drawLine(Canvas canvas, Offset c, double radius, double startAngle) {
    final dx = radius / 2.0 * cos(startAngle);
    final dy = radius / 2.0 * sin(startAngle);
    final p2 = c + Offset(dx, dy);
    canvas.drawLine(c, p2, linePaint);
  }

  double drawSetor(Canvas canvas, DataItem element, Rect rect,
      double startAngle, double sweepAngle) {
    final sweepAngle = element.value * 360 * pi / 180.0;
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = element.color;
    canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
    return sweepAngle;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void drawLabels(Canvas canvas, Offset c, double radius, double startAngle,
      double sweepAngle, String label) {
    final r = radius * 0.4;
    final dx = r * cos(startAngle + sweepAngle / 2.0);
    final dy = r * sin(startAngle + sweepAngle / 2.0);

    final position = c + Offset(dx, dy);
    drawTextCentered(canvas, position, label, labelStyle, 100.0, (Size sz) {
      final rect = Rect.fromCenter(
          center: position, width: sz.width + 5, height: sz.height + 5);
      final rrect = RRect.fromRectAndRadius(rect, Radius.circular(5));
      canvas.drawRRect(rrect, midPaint);
    });
  }
}
