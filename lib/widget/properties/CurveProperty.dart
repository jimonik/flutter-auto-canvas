import 'package:custompaint/bean/Line.dart';
import 'package:custompaint/page/main/logic.dart';
import 'package:custompaint/util/Util.dart';
import 'package:custompaint/widget/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:get/get.dart';

class CurveProperty extends StatelessWidget {
  final FakeWidget bean;

  const CurveProperty({super.key, required this.bean});

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
              const Text("初始位置X:"),
              Expanded(
                child: Obx(() {
                  return Slider(
                    value: bean.startX.value,
                    onChanged: (a) {
                      bean.startX.value = a;
                    },
                    onChangeEnd: (d) {
                      bean.startX.value = d;
                    },
                  );
                }),
              ),
            ],
          ),
          Row(
            children: [
              const Text("初始位置Y:"),
              Expanded(
                child: Obx(() {
                  return Slider(
                    value: bean.startY.value,
                    onChanged: (a) {
                      bean.startY.value = a;
                    },
                    onChangeEnd: (d) {
                      bean.startY.value = d;
                    },
                  );
                }),
              ),
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
                              onChanged: (a) {},
                              onChangeEnd: (d) {
                                item.startX.value = d;
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
                              onChanged: (a) {},
                              onChangeEnd: (a) {
                                item.startY.value = a;
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("endX:"),
                        Expanded(
                          child: Obx(() {
                            return Slider(
                              value: item.endX.value,
                              onChanged: (a) {},
                              onChangeEnd: (a) {
                                item.endX.value = a;
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("endY:"),
                        Expanded(
                          child: Obx(() {
                            return Slider(
                              value: item.endY.value,
                              onChanged: (a) {
                                item.endY.value = a;
                              },
                              onChangeEnd: (d) {
                                item.endY.value = d;
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
