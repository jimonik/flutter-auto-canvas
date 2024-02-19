import 'package:custompaint/page/main/logic.dart';
import 'package:custompaint/util/Util.dart';
import 'package:custompaint/widget/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:get/get.dart';

class PublicPropertyWidget extends StatelessWidget {
  const PublicPropertyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<MainLogic>();
    final state = logic.state;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Column(
                children: [
                  const Text("画板大小"),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomTextField(
                      value: state.panelWidth.value.toString(),
                      inputDecoration: const InputDecoration(
                        prefixIcon: Text("宽度:"),
                        isCollapsed: true,
                        isDense: true,
                        border: InputBorder.none,
                        hintText: "请输入宽度",
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                      ],
                      onChanged: (t) {
                        state.panelWidth.value = double.tryParse(t) ?? 400;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Obx(() {
                      return CustomTextField(
                        value: state.panelHeight.value.toString(),
                        inputDecoration: const InputDecoration(
                          isCollapsed: true,
                          isDense: true,
                          prefixIcon: Text("高度:"),
                          border: InputBorder.none,
                          hintText: "请输入高度",
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                        ],
                        onChanged: (t) {
                          state.panelHeight.value = double.tryParse(t) ?? 400;
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Column(
                children: [
                  const Text("背景颜色"),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(
                          text:
                              Util.getColorValue(state.backgroundColor.value)));
                      EasyLoading.showToast("已复制");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() {
                        return Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                              color: state.backgroundColor.value),
                          child: Center(
                            child: Obx(() {
                              return Text(Util.getColorValue(
                                  state.backgroundColor.value));
                            }),
                          ),
                        );
                      }),
                    ),
                  ),
                  MaterialColorPicker(
                    onColorChange: (c) {
                      state.backgroundColor.value = c;
                    },
                    onMainColorChange: (c) {
                      state.backgroundColor.value = Color.fromARGB(
                          c?.alpha ?? 0,
                          c?.red ?? 0,
                          c?.green ?? 0,
                          c?.blue ?? 0);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          decoration: const InputDecoration(
                              isDense: true,
                              isCollapsed: true,
                              border: InputBorder.none,
                              hintText: "请输入颜色值，例如：0x00000000"),
                          onChanged: (t) {
                            state.inputColor = t;
                          },
                        )),
                        ElevatedButton(
                            onPressed: () {
                              Color? c = Util.string2Color(state.inputColor);
                              if (c == null) {
                                EasyLoading.showToast("请输入正确的颜色值");
                              } else {
                                state.backgroundColor.value = c;
                              }
                            },
                            child: const Text("设置"))
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
