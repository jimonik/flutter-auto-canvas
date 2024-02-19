import 'package:custompaint/bean/FakeWidget.dart';
import 'package:custompaint/bean/WidgetType.dart';
import 'package:custompaint/page/main/logic.dart';
import 'package:custompaint/widget/CustomTextField.dart';
import 'package:custompaint/widget/properties/edit/subtype/CircleProperty.dart';
import 'package:custompaint/widget/properties/edit/subtype/CurveProperty.dart';
import 'package:custompaint/widget/properties/edit/subtype/EllipticProperty.dart';
import 'package:custompaint/widget/properties/edit/subtype/LineProperty.dart';
import 'package:custompaint/widget/properties/edit/subtype/NShapeProperty.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EditPropertiesWidget extends StatelessWidget {
  const EditPropertiesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<MainLogic>();
    final state = logic.state;
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey.shade200)),
      child: Obx(() {
        if (state.selectedFakeWidget.value < 0 ||
            state.fakeWidgetList.isEmpty) {
          state.selectedFakeWidget.value = -1;
          return const Center(child: Text("请选择组件"));
        }
        var bean = state.fakeWidgetList[state.selectedFakeWidget.value];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: Text("组件属性")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("组件id：${bean.uuid}"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("组件类型：${bean.type.name}"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Obx(() {
                  return CustomTextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r' '))
                    ],
                    inputDecoration: const InputDecoration(
                      isDense: true,
                      isCollapsed: true,
                      hintText: "请输入名称",
                      border: InputBorder.none,
                    ),
                    value: bean.name.value,
                    onChanged: (t) {
                      bean.name.value = t.trim();
                    },
                  );
                }),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: getWidgetByType(bean),
            ))
          ],
        );
      }),
    );
  }

  Widget getWidgetByType(FakeWidget bean) {
    final logic = Get.find<MainLogic>();
    final state = logic.state;
    switch (bean.type) {
      case WidgetType.line:
        return LineProperty(bean: bean);
      case WidgetType.curve:
        return CurveProperty(bean: bean);
      case WidgetType.circle:
        return CircleProperty(bean: bean);
      case WidgetType.elliptic:
        return EllipticProperty(bean: bean);
      case WidgetType.nAngle:
        return NShapeProperty(bean: bean);
    }
  }
}
