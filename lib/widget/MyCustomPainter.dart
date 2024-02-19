import 'dart:math';

import 'package:custompaint/bean/FakeWidget.dart';
import 'package:custompaint/bean/WidgetType.dart';
import 'package:flutter/material.dart';

class MyCustomPainter extends CustomPainter {
  final Color backgroundColor;
  final List<FakeWidget> line;
  MyCustomPainter(
      {super.repaint, required this.backgroundColor, required this.line});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    _drawBackgroundColor(canvas, size, backgroundColor, paint);
    _drawWidget(line, paint, canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
  void _drawBackgroundColor(
      Canvas canvas, Size size, Color backgroundColor, Paint paint) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        paint..color = backgroundColor);
  }

  void _drawWidget(
      List<FakeWidget> fakeWidget, Paint paint, Canvas canvas, Size size) {
    for (var fakeWidget in fakeWidget) {
      switch (fakeWidget.type) {
        case WidgetType.line:
          _drawLine(fakeWidget, paint, canvas, size);
        case WidgetType.curve:
          _drawCurve(fakeWidget, paint, canvas, size);
        case WidgetType.circle:
          _drawCircle(fakeWidget, paint, canvas, size);
        case WidgetType.elliptic:
          _drawElliptic(fakeWidget, paint, canvas, size);
        case WidgetType.nAngle:
          _drawNPath(fakeWidget, paint, canvas, size);
      }
    }
  }

  void _drawLine(FakeWidget fakeWidget, Paint paint, Canvas canvas, Size size) {
    paint.color = fakeWidget.color.value;
    paint.strokeWidth = fakeWidget.strokeWidth.value;
    paint.strokeCap = fakeWidget.strokeCap.value;
    canvas.drawLine(
      Offset(size.width * fakeWidget.startX.value,
          size.height * fakeWidget.startY.value),
      Offset(size.width * fakeWidget.endX.value,
          size.height * fakeWidget.endY.value),
      paint,
    );
  }

  void _drawCurve(
      FakeWidget fakeWidget, Paint paint, Canvas canvas, Size size) {
    paint.color = fakeWidget.color.value;
    paint.strokeWidth = 1;
    paint.style = fakeWidget.style.value;
    paint.strokeWidth = fakeWidget.strokeWidth.value;
    final Path path = Path();
    path.moveTo(size.width * fakeWidget.startX.value,
        size.height * fakeWidget.startY.value);
    for (var i = 0; i < fakeWidget.curvePointList.length; i++) {
      var point = fakeWidget.curvePointList[i];
      path.quadraticBezierTo(
          size.width * point.startX.value,
          size.height * point.startY.value,
          size.width * point.endX.value,
          size.height * point.endY.value);
    }
    path.close();
    // 计算曲线的包围框中心点作为画布中心点
    Rect bounds = path.getBounds();
    double centerX = bounds.center.dx;
    double centerY = bounds.center.dy;

    canvas.save();
    canvas.translate(centerX, centerY);
    canvas.rotate(fakeWidget.angle.value * pi / 180);
    canvas.translate(-centerX, -centerY);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  void _drawCircle(
      FakeWidget fakeWidget, Paint paint, Canvas canvas, Size size) {
    paint.color = fakeWidget.color.value;
    paint.strokeWidth = fakeWidget.strokeWidth.value;
    paint.style = fakeWidget.style.value;
    canvas.drawCircle(
        Offset(size.width * fakeWidget.startX.value,
            size.height * fakeWidget.startY.value),
        fakeWidget.circleRadius.value,
        paint);
  }

  void _drawElliptic(
      FakeWidget fakeWidget, Paint paint, Canvas canvas, Size size) {
    paint.color = fakeWidget.color.value;
    paint.strokeWidth = fakeWidget.strokeWidth.value;
    paint.style = fakeWidget.style.value;
    double left = size.width * fakeWidget.rectLeft.value;
    double top = size.height * fakeWidget.rectTop.value;
    double right = size.width * fakeWidget.rectRight.value;
    double bottom = size.height * fakeWidget.rectBottom.value;

    double centerX = (left + right) / 2;
    double centerY = (top + bottom) / 2;
    canvas.save();
    canvas.translate(centerX, centerY);
    canvas.rotate(fakeWidget.angle.value * pi / 180);

    canvas.drawOval(
        Rect.fromCenter(
            center: Offset.zero, width: right - left, height: bottom - top),
        paint);

    canvas.restore();
  }

  void _drawNPath(
      FakeWidget fakeWidget, Paint paint, Canvas canvas, Size size) {
    paint.color = fakeWidget.color.value;
    paint.strokeWidth = 1;
    paint.style = fakeWidget.style.value;
    paint.strokeWidth = fakeWidget.strokeWidth.value;
    final Path path = Path();
    path.moveTo(size.width * fakeWidget.startX.value,
        size.height * fakeWidget.startY.value);
    for (var i = 0; i < fakeWidget.curvePointList.length; i++) {
      var point = fakeWidget.curvePointList[i];
      path.lineTo(
          size.width * point.startX.value, size.height * point.startY.value);
    }
    path.close();
    // 计算曲线的包围框中心点作为画布中心点
    Rect bounds = path.getBounds();
    double centerX = bounds.center.dx;
    double centerY = bounds.center.dy;
    canvas.save();
    canvas.translate(centerX, centerY);
    canvas.rotate(fakeWidget.angle.value * pi / 180);
    canvas.translate(-centerX, -centerY);
    canvas.drawPath(path, paint);
    canvas.restore();
  }
}
