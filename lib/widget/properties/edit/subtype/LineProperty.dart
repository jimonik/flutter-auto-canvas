import 'dart:math';

import 'package:custompaint/bean/FakeWidget.dart';
import 'package:custompaint/page/main/logic.dart';
import 'package:custompaint/util/Util.dart';
import 'package:custompaint/widget/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:get/get.dart';

class LineProperty extends StatelessWidget {
  final FakeWidget bean;

  const LineProperty({super.key, required this.bean});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<MainLogic>();
    final state = logic.state;
    return Column(
      children: [
        Row(
          children: [
            Obx(() {
              return Text("startX(${bean.startX.value.toStringAsFixed(2)}):");
            }),
            Expanded(
              child: Obx(() {
                return Slider(
                    value: bean.startX.value,
                    onChanged: (a) {
                      bean.startX.value = a;
                    });
              }),
            ),
          ],
        ),
        Row(
          children: [
            Obx(() {
              return Text("startY(${bean.startY.value.toStringAsFixed(2)}):");
            }),
            Expanded(
              child: Obx(() {
                return Slider(
                    value: bean.startY.value,
                    onChanged: (a) {
                      bean.startY.value = a;
                    });
              }),
            ),
          ],
        ),
        Row(
          children: [
            Obx(() {
              return Text("endX(${bean.endX.value.toStringAsFixed(2)}):");
            }),
            Expanded(
              child: Obx(() {
                return Slider(
                    value: bean.endX.value,
                    onChanged: (a) {
                      bean.endX.value = a;
                    });
              }),
            ),
          ],
        ),
        Row(
          children: [
            Obx(() {
              return Text("endY(${bean.endY.value.toStringAsFixed(2)}):");
            }),
            Expanded(
              child: Obx(() {
                return Slider(
                    value: bean.endY.value,
                    onChanged: (a) {
                      bean.endY.value = a;
                    });
              }),
            ),
          ],
        ),
        Row(
          children: [
            Obx(() {
              return Text("线宽:(${bean.strokeWidth.value.toStringAsFixed(2)})");
            }),
            Expanded(
              child: Obx(() {
                return Slider(
                    min: 0,
                    max: max(state.panelHeight.value, state.panelWidth.value),
                    value: bean.strokeWidth.value,
                    onChanged: (a) {
                      bean.strokeWidth.value = a;
                    });
              }),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("线条颜色"),
                ),
                MaterialColorPicker(
                  onMainColorChange: (c) {
                    bean.color.value = Color.fromARGB(c?.alpha ?? 0,
                        c?.red ?? 0, c?.green ?? 0, c?.blue ?? 0);
                  },
                  onColorChange: (c) {
                    bean.color.value = c;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(() {
                          return CustomTextField(
                            value: Util.getColorValue(bean.color.value),
                            inputDecoration: const InputDecoration(
                                hintText: "请输入颜色值",
                                isCollapsed: true,
                                isDense: true,
                                border: InputBorder.none),
                            onChanged: (c) {
                              state.inputLineColor = c;
                            },
                          );
                        }),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Color? color =
                                Util.string2Color(state.inputLineColor);
                            if (color == null) {
                              EasyLoading.showToast("请输入正确的颜色值");
                            } else {
                              bean.color.value = color;
                            }
                          },
                          child: const Text("设置"))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Obx(() {
                return Checkbox(
                    value: bean.strokeCap.value == StrokeCap.round,
                    onChanged: (b) {
                      bean.strokeCap.value = StrokeCap.round;
                    });
              }),
              const Text("圆角"),
              Obx(() {
                return Checkbox(
                    value: bean.strokeCap.value == StrokeCap.square,
                    onChanged: (b) {
                      bean.strokeCap.value = StrokeCap.square;
                    });
              }),
              const Text("直角"),
              Obx(() {
                return Checkbox(
                    value: bean.strokeCap.value == StrokeCap.butt,
                    onChanged: (b) {
                      bean.strokeCap.value = StrokeCap.butt;
                    });
              }),
              const Text("无端点直角"),
            ],
          ),
        )
      ],
    );
  }
}
