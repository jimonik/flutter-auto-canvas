import 'dart:ui';

import 'package:get/get.dart';

class FakeWidget {
  final Rx<Color> color;
  final RxDouble startX;
  final RxDouble startY;

  final RxDouble endX;
  final RxDouble endY;

  final RxDouble strokeWidth;
  final String uuid;
  final WidgetType type;
  final Rx<StrokeCap> strokeCap;
  final RxString name;
  final RxList<CurveLineBean> curvePointList;
  final RxDouble circleRadius;

  final Rx<PaintingStyle> style;
  FakeWidget({
    required this.color,
    required this.startY,
    required this.endY,
    required this.startX,
    required this.endX,
    required this.strokeWidth,
    required this.uuid,
    required this.type,
    required this.name,
    required this.strokeCap,
    required this.curvePointList,
    required this.circleRadius,
    required this.style,
  });
  FakeWidget clone() {
    return FakeWidget(
        color: color,
        startY: startY,
        endY: endY,
        startX: startX,
        endX: endX,
        strokeWidth: strokeWidth,
        uuid: uuid,
        type: type,
        name: name,
        strokeCap: strokeCap,
        curvePointList: curvePointList,
        circleRadius: circleRadius,
        style: style);
  }
}

enum WidgetType {
  line(name: "直线"),
  curve(name: "曲线"),
  circle(name: "圆形"),
  elliptic(name: "椭圆"),
  nAngle(name: "N边形"),
  ;

  final String name;
  const WidgetType({required this.name});
}

class CurveLineBean {
  final RxDouble startX;
  final RxDouble endX;
  final RxDouble startY;
  final RxDouble endY;

  CurveLineBean(
      {required this.startX,
      required this.endX,
      required this.startY,
      required this.endY});
}
