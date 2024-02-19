import 'dart:math';

import 'package:flutter/cupertino.dart';

class CustomAutoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    _drawBackgroundColor(canvas, size, Color(4291937513), paint);
    _drawWidget([
      {
        "color": 4278190080,
        "startY": 0.0,
        "endY": 1.0,
        "startX": 0.0,
        "endX": 1.0,
        "strokeWidth": 3.0,
        "uuid": "0e7e1b66-4ecf-4039-970c-d0dde083ab9d",
        "type": "直线",
        "name": "",
        "strokeCap": "square",
        "curvePointList": [],
        "circleRadius": 3.0,
        "style": "fill",
        "rectLeft": 0.0,
        "rectTop": 0.0,
        "rectRight": 0.0,
        "rectBottom": 0.0,
        "angle": 0.0
      },
      {
        "color": 4283215696,
        "startY": 0.0,
        "endY": 1.0,
        "startX": 0.9581370249862481,
        "endX": 1.0,
        "strokeWidth": 21.7991795484393,
        "uuid": "a5a5d8dc-904b-4162-9ac8-6ae409b2fb0d",
        "type": "曲线",
        "name": "",
        "strokeCap": "square",
        "curvePointList": [
          {"startX": 0.2, "endX": 0.2, "startY": 0.5, "endY": 0.5},
          {"startX": 0.6, "endX": 0.6, "startY": 1.0, "endY": 1.0}
        ],
        "circleRadius": 3.0,
        "style": "stroke",
        "rectLeft": 0.0,
        "rectTop": 0.0,
        "rectRight": 0.0,
        "rectBottom": 0.0,
        "angle": 0.0
      },
      {
        "color": 4294924066,
        "startY": 0.0,
        "endY": 1.0,
        "startX": 0.49681144767909374,
        "endX": 1.0,
        "strokeWidth": 3.0,
        "uuid": "fa56b974-24d2-4bd3-930f-90530632aa71",
        "type": "圆形",
        "name": "",
        "strokeCap": "square",
        "curvePointList": [],
        "circleRadius": 50.0,
        "style": "fill",
        "rectLeft": 0.0,
        "rectTop": 0.0,
        "rectRight": 0.0,
        "rectBottom": 0.0,
        "angle": 0.0
      },
      {
        "color": 4278190080,
        "startY": 0.0,
        "endY": 1.0,
        "startX": 0.0,
        "endX": 1.0,
        "strokeWidth": 3.0,
        "uuid": "328a4f43-28f0-47b4-94af-6d02e500d643",
        "type": "椭圆",
        "name": "",
        "strokeCap": "square",
        "curvePointList": [],
        "circleRadius": 3.0,
        "style": "stroke",
        "rectLeft": 0.26,
        "rectTop": 0.09,
        "rectRight": 0.78,
        "rectBottom": 0.9,
        "angle": 0.0
      },
      {
        "color": 4280391411,
        "startY": 0.7708735778144534,
        "endY": 1.0,
        "startX": 0.6656561918927927,
        "endX": 1.0,
        "strokeWidth": 3.0,
        "uuid": "71e5239d-7e1c-43e2-b5c9-352f19a46d99",
        "type": "N边形",
        "name": "",
        "strokeCap": "square",
        "curvePointList": [
          {
            "startX": 0.2,
            "endX": 0.2,
            "startY": 0.7472483195722665,
            "endY": 0.0
          },
          {
            "startX": 0.6,
            "endX": 0.6,
            "startY": 0.28473576832801445,
            "endY": 0.0
          },
          {"startX": 0.3, "endX": 0.4, "startY": 0.0, "endY": 0.0}
        ],
        "circleRadius": 3.0,
        "style": "fill",
        "rectLeft": 0.0,
        "rectTop": 0.0,
        "rectRight": 0.0,
        "rectBottom": 0.0,
        "angle": 0.0
      }
    ], paint, canvas, size);
  }

  void _drawBackgroundColor(
      Canvas canvas, Size size, Color backgroundColor, Paint paint) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        paint..color = backgroundColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
  void _drawWidget(List fakeWidget, Paint paint, Canvas canvas, Size size) {
    for (var fakeWidget in fakeWidget) {
      switch (fakeWidget['type']) {
        case "直线":
          _drawLine(fakeWidget, paint, canvas, size);
        case "曲线":
          _drawCurve(fakeWidget, paint, canvas, size);
        case "圆形":
          _drawCircle(fakeWidget, paint, canvas, size);
        case "椭圆":
          _drawElliptic(fakeWidget, paint, canvas, size);
        case "N边形":
          _drawNPath(fakeWidget, paint, canvas, size);
      }
    }
  }

  void _drawLine(dynamic fakeWidget, Paint paint, Canvas canvas, Size size) {
    paint.color = Color(fakeWidget['color']);
    paint.strokeWidth = fakeWidget['strokeWidth'];
    paint.strokeCap = StrokeCap.values
        .firstWhere((element) => fakeWidget['strokeCap'] == element.name);
    canvas.drawLine(
        Offset(size.width * fakeWidget['startX'],
            size.height * fakeWidget['startY']),
        Offset(
            size.width * fakeWidget['endX'], size.height * fakeWidget['endY']),
        paint);
  }

  void _drawCurve(dynamic fakeWidget, Paint paint, Canvas canvas, Size size) {
    paint.color = Color(fakeWidget['color']);
    paint.strokeWidth = fakeWidget['strokeWidth'];
    paint.style = PaintingStyle.values
        .firstWhere((element) => element.name == fakeWidget['style']);
    paint.strokeWidth = fakeWidget['strokeWidth'];
    final Path path = Path();
    path.moveTo(
        size.width * fakeWidget['startX'], size.height * fakeWidget['startY']);
    var b = fakeWidget['curvePointList'];
    for (var i = 0; i < b.length; i++) {
      var point = b[i];
      path.quadraticBezierTo(
          size.width * point['startX'],
          size.height * point['startY'],
          size.width * point['endX'],
          size.height * point['endY']);
    }
    path.close();
    // 计算曲线的包围框中心点作为画布中心点
    Rect bounds = path.getBounds();
    double centerX = bounds.center.dx;
    double centerY = bounds.center.dy;
    canvas.save();
    canvas.translate(centerX, centerY);
    canvas.rotate(fakeWidget['angle'] * pi / 180);
    canvas.translate(-centerX, -centerY);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  void _drawCircle(dynamic fakeWidget, Paint paint, Canvas canvas, Size size) {
    paint.color = Color(fakeWidget['color']);
    paint.style = PaintingStyle.values
        .firstWhere((element) => element.name == fakeWidget['style']);
    paint.strokeWidth = fakeWidget['strokeWidth'];
    canvas.drawCircle(
        Offset(size.width * fakeWidget['startX'],
            size.height * fakeWidget['startY']),
        fakeWidget['circleRadius'],
        paint);
  }

  void _drawElliptic(
      dynamic fakeWidget, Paint paint, Canvas canvas, Size size) {
    paint.color = Color(fakeWidget['color']);
    paint.style = PaintingStyle.values
        .firstWhere((element) => element.name == fakeWidget['style']);
    paint.strokeWidth = fakeWidget['strokeWidth'];
    double left = size.width * fakeWidget['rectLeft'];
    double top = size.height * fakeWidget['rectTop'];
    double right = size.width * fakeWidget['rectRight'];
    double bottom = size.height * fakeWidget['rectBottom'];
    double centerX = (left + right) / 2;
    double centerY = (top + bottom) / 2;
    canvas.save();
    canvas.translate(centerX, centerY);
    canvas.rotate(fakeWidget['angle'] * pi / 180);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset.zero, width: right - left, height: bottom - top),
        paint);
    canvas.restore();
  }

  void _drawNPath(dynamic fakeWidget, Paint paint, Canvas canvas, Size size) {
    paint.color = Color(fakeWidget['color']);
    paint.style = PaintingStyle.values
        .firstWhere((element) => element.name == fakeWidget['style']);
    paint.strokeWidth = fakeWidget['strokeWidth'];
    final Path path = Path();
    path.moveTo(
        size.width * fakeWidget['startX'], size.height * fakeWidget['startY']);
    var d = fakeWidget['curvePointList'];
    for (var i = 0; i < d.length; i++) {
      var point = d[i];
      path.lineTo(size.width * point['startX'], size.height * point['startY']);
    }
    path.close();
    // 计算曲线的包围框中心点作为画布中心点
    Rect bounds = path.getBounds();
    double centerX = bounds.center.dx;
    double centerY = bounds.center.dy;
    canvas.save();
    canvas.translate(centerX, centerY);
    canvas.rotate(fakeWidget['angle'] * pi / 180);
    canvas.translate(-centerX, -centerY);
    canvas.drawPath(path, paint);
    canvas.restore();
  }
}
