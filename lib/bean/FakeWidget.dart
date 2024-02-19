import 'dart:ui';

import 'package:custompaint/bean/CurveLineBean.dart';
import 'package:custompaint/bean/WidgetType.dart';
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
  final RxDouble rectLeft;
  final RxDouble rectTop;
  final RxDouble rectRight;
  final RxDouble rectBottom;

  final Rx<PaintingStyle> style;

  final RxDouble angle;
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
    required this.rectLeft,
    required this.rectTop,
    required this.rectRight,
    required this.rectBottom,
    required this.angle,
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
        style: style,
        rectLeft: rectLeft,
        rectTop: rectTop,
        rectRight: rectRight,
        rectBottom: rectBottom,
        angle: angle);
  }

  Map<String, dynamic> toJson() {
    return {
      "color": color.value.value,
      "startY": startY.value,
      "endY": endY.value,
      "startX": startX.value,
      "endX": endX.value,
      "strokeWidth": strokeWidth.value,
      "uuid": uuid,
      "type": type.name,
      "name": name.value,
      "strokeCap": strokeCap.value.name,
      "curvePointList":
          curvePointList.map((element) => element.toJson()).toList(),
      "circleRadius": circleRadius.value,
      "style": style.value.name,
      "rectLeft": rectLeft.value,
      "rectTop": rectTop.value,
      "rectRight": rectRight.value,
      "rectBottom": rectBottom.value,
      "angle": angle.value,
    };
  }
}
