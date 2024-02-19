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

  @override
  void onInit() {
    super.onInit();
  }

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
}
