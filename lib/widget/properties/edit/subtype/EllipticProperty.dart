import 'dart:math';

import 'package:custompaint/bean/FakeWidget.dart';
import 'package:custompaint/page/main/logic.dart';
import 'package:custompaint/util/Util.dart';
import 'package:custompaint/widget/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:get/get.dart';

class EllipticProperty extends StatelessWidget {
  final FakeWidget bean;

  const EllipticProperty({super.key, required this.bean});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<MainLogic>();
    final state = logic.state;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("椭圆颜色"),
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
          Row(
            children: [
              Obx(() {
                return Text("左(${bean.rectLeft.value.toStringAsFixed(2)}):");
              }),
              Expanded(
                child: Obx(() {
                  return Slider(
                    value: bean.rectLeft.value,
                    onChanged: (a) {
                      bean.rectLeft.value = a;
                    },
                  );
                }),
              ),
            ],
          ),
          Row(
            children: [
              Obx(() {
                return Text("顶(${bean.rectTop.value.toStringAsFixed(2)}):");
              }),
              Expanded(
                child: Obx(() {
                  return Slider(
                    value: bean.rectTop.value,
                    onChanged: (a) {
                      bean.rectTop.value = a;
                      logic.refreshList();
                    },
                  );
                }),
              ),
            ],
          ),
          Row(
            children: [
              Obx(() {
                return Text("右(${bean.rectRight.value.toStringAsFixed(2)}):");
              }),
              Expanded(
                child: Obx(() {
                  return Slider(
                    value: bean.rectRight.value,
                    onChanged: (a) {
                      bean.rectRight.value = a;
                      logic.refreshList();
                    },
                  );
                }),
              ),
            ],
          ),
          Row(
            children: [
              Obx(() {
                return Text("底:${bean.rectBottom.value.toStringAsFixed(2)}");
              }),
              Expanded(
                child: Obx(() {
                  return Slider(
                      value: bean.rectBottom.value,
                      onChanged: (a) {
                        bean.rectBottom.value = a;
                      });
                }),
              ),
            ],
          ),
          Row(
            children: [
              Obx(() {
                return Text("线宽:${bean.strokeWidth.value.toStringAsFixed(2)}");
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
          Row(
            children: [
              Obx(() {
                return Text("角度:${bean.angle.value.toStringAsFixed(2)}");
              }),
              Expanded(
                child: Obx(() {
                  return Slider(
                      min: 0,
                      max: 360,
                      value: bean.angle.value,
                      onChanged: (a) {
                        bean.angle.value = a;
                      });
                }),
              ),
            ],
          ),
          Row(
            children: [
              Obx(() {
                return Checkbox(
                    value: bean.style.value == PaintingStyle.stroke,
                    onChanged: (b) {
                      bean.style.value = PaintingStyle.stroke;
                      logic.refreshList();
                    });
              }),
              const Text("空心"),
              Obx(() {
                return Checkbox(
                    value: bean.style.value == PaintingStyle.fill,
                    onChanged: (b) {
                      bean.style.value = PaintingStyle.fill;
                      logic.refreshList();
                    });
              }),
              const Text("实心"),
            ],
          )
        ],
      ),
    );
  }
}
