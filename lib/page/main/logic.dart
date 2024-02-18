import 'package:custompaint/bean/Line.dart';
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
    WidgetType? type = await showSelectWidgetDialog([
      WidgetType.line,
      WidgetType.curve,
    ]);
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
            curvePointList: <CurveLineBean>[].obs));
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
            ].obs));
    }
  }

  void refreshList() {
    var l = state.fakeWidgetList.map((element) => element.clone()).toList();
    state.fakeWidgetList.assignAll(l);
  }
}
