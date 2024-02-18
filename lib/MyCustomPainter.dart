import 'package:custompaint/bean/Line.dart';
import 'package:flutter/material.dart';

class MyCustomPainter extends CustomPainter {
  final Color backgroundColor;
  final List<FakeWidget> line;
  late Size s;
  late Canvas c;

  MyCustomPainter(
      {super.repaint, required this.backgroundColor, required this.line});
  @override
  void paint(Canvas canvas, Size size) {
    c = canvas;
    s = size;
    final Paint paint = Paint();
    drawBackgroundColor(canvas, size, backgroundColor, paint);
    drawWidget(line, paint, canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void drawLoading(Size size, Canvas canvas) {
    final textPainter = TextPainter(
        text:
            const TextSpan(text: '加载中', style: TextStyle(color: Colors.black)),
        textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: size.width);
    textPainter.paint(
        canvas,
        Offset((size.width - textPainter.width) / 2,
            (size.height - textPainter.height) / 2));
  }

  void drawBackgroundColor(
      Canvas canvas, Size size, Color backgroundColor, Paint paint) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        paint..color = backgroundColor);
  }

  void drawWidget(
      List<FakeWidget> fakeWidget, Paint paint, Canvas canvas, Size size) {
    for (var element in fakeWidget) {
      switch (element.type) {
        case WidgetType.line:
          drawLine(element, paint, canvas, size);
        case WidgetType.curve:
          drawCurve(element, paint, canvas, size);
      }
    }
  }

  void drawLine(FakeWidget element, Paint paint, Canvas canvas, Size size) {
    paint.color = element.color.value;
    paint.strokeWidth = element.strokeWidth.value;
    paint.strokeCap = element.strokeCap.value;
    canvas.drawLine(
      Offset(size.width * element.startX.value,
          size.height * element.startY.value),
      Offset(size.width * element.endX.value, size.height * element.endY.value),
      paint,
    );
  }

  void drawCurve(FakeWidget element, Paint paint, Canvas canvas, Size size) {
    paint.color = element.color.value;
    paint.strokeWidth = 1;
    final Path path = Path();
    path.moveTo(
        size.width * element.startX.value, size.height * element.startY.value);
    for (var i = 0; i < element.curvePointList.length; i++) {
      var point = element.curvePointList[i];
      path.quadraticBezierTo(
          size.width * point.startX.value,
          size.height * point.startY.value,
          size.width * point.endX.value,
          size.height * point.endY.value);
    }
    // path.close();
    canvas.drawPath(path, paint);
  }
}
