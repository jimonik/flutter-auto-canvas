import 'dart:convert';

import 'package:custompaint/bean/CurveLineBean.dart';
import 'package:custompaint/bean/FakeWidget.dart';
import 'package:custompaint/bean/WidgetType.dart';
import 'package:custompaint/widget/dialog/SelectWidgetDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import 'state.dart';

class MainLogic extends GetxController {
  final MainState state = MainState();
  Future<void> addLine() async {
    WidgetType? type = await showSelectWidgetDialog();
    if (type == null) {
      return;
    }
    switch (type) {
      case WidgetType.line:
        state.fakeWidgetList.add(FakeWidget(
            color: Colors.black.obs,
            strokeWidth: (3.0).obs,
            startX: (0.0).obs,
            startY: (0.0).obs,
            endX: (1.0).obs,
            endY: (1.0).obs,
            uuid: const Uuid().v4(),
            type: WidgetType.line,
            name: "".obs,
            strokeCap: StrokeCap.square.obs,
            curvePointList: <CurveLineBean>[].obs,
            circleRadius: (3.0).obs,
            style: PaintingStyle.fill.obs,
            rectLeft: (0.0).obs,
            rectTop: (0.0).obs,
            rectRight: (0.0).obs,
            rectBottom: (0.0).obs,
            angle: (0.0).obs));
      case WidgetType.curve:
        state.fakeWidgetList.add(FakeWidget(
            color: Colors.black.obs,
            strokeWidth: (3.0).obs,
            startX: (0.0).obs,
            startY: (0.0).obs,
            endX: (1.0).obs,
            endY: (1.0).obs,
            uuid: const Uuid().v4(),
            type: WidgetType.curve,
            name: "".obs,
            strokeCap: StrokeCap.square.obs,
            curvePointList: <CurveLineBean>[
              CurveLineBean(
                  startX: (0.2).obs,
                  endX: (0.2).obs,
                  startY: (0.5).obs,
                  endY: (0.5).obs),
              CurveLineBean(
                  startX: (0.6).obs,
                  endX: (0.6).obs,
                  startY: (1.0).obs,
                  endY: (1.0).obs),
            ].obs,
            circleRadius: (3.0).obs,
            style: PaintingStyle.fill.obs,
            rectLeft: (0.0).obs,
            rectTop: (0.0).obs,
            rectRight: (0.0).obs,
            rectBottom: (0.0).obs,
            angle: (0.0).obs));
      case WidgetType.circle:
        state.fakeWidgetList.add(FakeWidget(
            color: Colors.black.obs,
            strokeWidth: (3.0).obs,
            startX: (0.0).obs,
            startY: (0.0).obs,
            endX: (1.0).obs,
            endY: (1.0).obs,
            uuid: const Uuid().v4(),
            type: WidgetType.circle,
            name: "".obs,
            strokeCap: StrokeCap.square.obs,
            curvePointList: <CurveLineBean>[].obs,
            circleRadius: (50.0).obs,
            style: PaintingStyle.fill.obs,
            rectLeft: (0.0).obs,
            rectTop: (0.0).obs,
            rectRight: (0.0).obs,
            rectBottom: (0.0).obs,
            angle: (0.0).obs));
      case WidgetType.elliptic:
        state.fakeWidgetList.add(FakeWidget(
            color: Colors.black.obs,
            strokeWidth: (3.0).obs,
            startX: (0.0).obs,
            startY: (0.0).obs,
            endX: (1.0).obs,
            endY: (1.0).obs,
            uuid: const Uuid().v4(),
            type: WidgetType.elliptic,
            name: "".obs,
            strokeCap: StrokeCap.square.obs,
            curvePointList: <CurveLineBean>[].obs,
            circleRadius: (3.0).obs,
            style: PaintingStyle.fill.obs,
            rectLeft: (0.26).obs,
            rectTop: (0.09).obs,
            rectRight: (0.78).obs,
            rectBottom: (0.9).obs,
            angle: (0.0).obs));
      case WidgetType.nAngle:
        state.fakeWidgetList.add(FakeWidget(
            color: Colors.black.obs,
            strokeWidth: (3.0).obs,
            startX: (0.0).obs,
            startY: (0.0).obs,
            endX: (1.0).obs,
            endY: (1.0).obs,
            uuid: const Uuid().v4(),
            type: WidgetType.nAngle,
            name: "".obs,
            strokeCap: StrokeCap.square.obs,
            curvePointList: <CurveLineBean>[
              CurveLineBean(
                  startX: (0.2).obs,
                  endX: (0.2).obs,
                  startY: (0.0).obs,
                  endY: (0.0).obs),
              CurveLineBean(
                  startX: (0.6).obs,
                  endX: (0.6).obs,
                  startY: (0.0).obs,
                  endY: (0.0).obs),
              CurveLineBean(
                  startX: (0.3).obs,
                  endX: (0.4).obs,
                  startY: (0.0).obs,
                  endY: (0.0).obs),
            ].obs,
            circleRadius: (3.0).obs,
            style: PaintingStyle.fill.obs,
            rectLeft: (0.0).obs,
            rectTop: (0.0).obs,
            rectRight: (0.0).obs,
            rectBottom: (0.0).obs,
            angle: (0.0).obs));
    }
  }

  void refreshList() {
    var l = state.fakeWidgetList.map((element) => element.clone()).toList();
    state.fakeWidgetList.assignAll(l);
  }

  void export() {
    String code = '''
import 'package:flutter/cupertino.dart';
import 'dart:math';
class CustomAutoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    _drawBackgroundColor(canvas, size, Color(${state.backgroundColor.value.value}), paint);
      _drawWidget(${jsonEncode(state.fakeWidgetList.map((p0) => p0.toJson()).toList())}, paint, canvas, size);
  }
  void _drawBackgroundColor(
      Canvas canvas, Size size, Color backgroundColor, Paint paint) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        paint..color = backgroundColor);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
   void _drawWidget(
      List fakeWidget, Paint paint, Canvas canvas, Size size) {
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
 void _drawCurve(
      dynamic fakeWidget, Paint paint, Canvas canvas, Size size) {
    paint.color = Color(fakeWidget['color']);
    paint.strokeWidth = fakeWidget['strokeWidth'];
    paint.style = PaintingStyle.values.firstWhere((element) => element.name==fakeWidget['style']);
    paint.strokeWidth = fakeWidget['strokeWidth'];
    final Path path = Path();
    path.moveTo(size.width * fakeWidget['startX'],
        size.height * fakeWidget['startY']);
    var b=fakeWidget['curvePointList'];
    for (var i = 0; i < b.length; i++) {
      var point = b[i];
      path.quadraticBezierTo(
          size.width * point['startX'],
          size.height * point['startY'],
          size.width * point['endX'],
          size.height * point['endY']);
    }
    path.close();
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
    paint.style = PaintingStyle.values.firstWhere((element) => element.name == fakeWidget['style']);
    paint.strokeWidth = fakeWidget['strokeWidth'];
    canvas.drawCircle(
        Offset(size.width * fakeWidget['startX'],
            size.height * fakeWidget['startY']),
        fakeWidget['circleRadius'],
        paint);
  }
  
  void _drawElliptic(dynamic fakeWidget, Paint paint, Canvas canvas, Size size) {
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




// 使用方式
CustomPaint(
  size: const Size(${state.panelWidth.value}, ${state.panelHeight.value}),
  painter: CustomAutoPainter(),
)
        
    ''';
    print(code);
    showCode(code);
  }
}
