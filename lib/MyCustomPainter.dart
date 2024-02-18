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
    for (var element in fakeWidget) {
      switch (element.type) {
        case WidgetType.line:
          drawLine(element, paint, canvas, size);
        case WidgetType.curve:
          _drawCurve(element, paint, canvas, size);
        case WidgetType.circle:
          _drawCircle(element, paint, canvas, size);
        case WidgetType.elliptic:
          _drawElliptic(element, paint, canvas, size);
        case WidgetType.nAngle:
        // TODO: Handle this case.
      }
    }
  }

  void drawLine(FakeWidget fakeWidget, Paint paint, Canvas canvas, Size size) {
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

  void _drawCurve(FakeWidget element, Paint paint, Canvas canvas, Size size) {
    paint.color = element.color.value;
    paint.strokeWidth = 1;
    paint.style = element.style.value;
    paint.strokeWidth = element.strokeWidth.value;
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
    path.close();
    canvas.drawPath(path, paint);
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
    //todo：旋转未完成
    // canvas.restore();
    // // 将画布平移到椭圆中心点
    // double x = (size.width * fakeWidget.rectRight.value -
    //             size.width * fakeWidget.rectLeft.value) /
    //         2 +
    //     size.width * fakeWidget.rectLeft.value;
    // double y = (size.height * fakeWidget.rectBottom.value -
    //             size.height * fakeWidget.rectTop.value) /
    //         2 +
    //     size.height * fakeWidget.rectTop.value;
    // canvas.translate(x, y);

    // 旋转画布
    // canvas.rotate(fakeWidget.angle.value);
    canvas.drawOval(
        Rect.fromLTRB(
            size.width * fakeWidget.rectLeft.value,
            size.height * fakeWidget.rectTop.value,
            size.width * fakeWidget.rectRight.value,
            size.height * fakeWidget.rectBottom.value),
        paint);

    // 将画布平移回原点
    // canvas.translate(-size.width / 2, -size.height / 2);
  }
}
