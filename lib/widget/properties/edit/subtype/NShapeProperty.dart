import 'dart:math';

import 'package:custompaint/bean/CurveLineBean.dart';
import 'package:custompaint/bean/FakeWidget.dart';
import 'package:custompaint/page/main/logic.dart';
import 'package:custompaint/util/Util.dart';
import 'package:custompaint/widget/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:get/get.dart';

class NShapeProperty extends StatelessWidget {
  final FakeWidget bean;

  const NShapeProperty({super.key, required this.bean});

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
          Row(
            children: [
              Obx(() {
                return Text("初始位置X(${bean.startX.value.toStringAsFixed(2)}):");
              }),
              Expanded(
                child: Obx(() {
                  return Slider(
                    value: bean.startX.value,
                    onChanged: (a) {
                      bean.startX.value = a;
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
                return Text("初始位置Y(${bean.startY.value.toStringAsFixed(2)}):");
              }),
              Expanded(
                child: Obx(() {
                  return Slider(
                    value: bean.startY.value,
                    onChanged: (a) {
                      bean.startY.value = a;
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
          ),
          Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: bean.curvePointList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var item = bean.curvePointList[index];
                return ExpansionTile(
                  title: Text("点${index + 1}"),
                  children: [
                    Row(
                      children: [
                        const Text("startX:"),
                        Expanded(
                          child: Obx(() {
                            return Slider(
                              value: item.startX.value,
                              onChanged: (a) {
                                item.startX.value = a;
                                logic.refreshList();
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("startY:"),
                        Expanded(
                          child: Obx(() {
                            return Slider(
                              value: item.startY.value,
                              onChanged: (a) {
                                item.startY.value = a;
                                logic.refreshList();
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ElevatedButton(
                          onPressed: () {
                            bean.curvePointList.remove(item);
                          },
                          child: const Text("删除")),
                    )
                  ],
                );
              },
            );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ElevatedButton(
                onPressed: () {
                  bean.curvePointList.add(CurveLineBean(
                      startX: (0.6).obs,
                      endX: (0.6).obs,
                      startY: (1.0).obs,
                      endY: (1.0).obs));
                },
                child: const Text("添加点")),
          )
        ],
      ),
    );
  }
}
