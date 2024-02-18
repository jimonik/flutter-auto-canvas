import 'package:custompaint/page/main/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShapeWidget extends StatelessWidget {
  const ShapeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<MainLogic>();
    final state = logic.state;
    return Scaffold(
      body: Obx(() {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.fakeWidgetList.length,
          itemBuilder: (BuildContext context, int index) {
            var bean = state.fakeWidgetList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      if (state.selectedFakeWidget.value == index) {
                        state.selectedFakeWidget.value = -1;
                        return;
                      }
                      state.selectedFakeWidget.value = index;
                    },
                    child: Obx(() {
                      return Container(
                        decoration: BoxDecoration(
                            border: state.selectedFakeWidget.value == index
                                ? Border.all(
                                    color: Colors.grey,
                                  )
                                : null),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          bean.name.isEmpty == true
                              ? "${bean.type.name}:${bean.uuid}"
                              : '${bean.name}',
                          style: const TextStyle(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }),
                  )),
                  InkWell(
                    onTap: () {
                      int index = state.fakeWidgetList.indexOf(bean);
                      if (index >= 0 &&
                          index < state.fakeWidgetList.length - 1) {
                        state.fakeWidgetList.insert(
                            index + 1, state.fakeWidgetList.removeAt(index));
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_downward_sharp),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      int index = state.fakeWidgetList.indexOf(bean);
                      if (index > 0) {
                        state.fakeWidgetList.insert(
                            index - 1, state.fakeWidgetList.removeAt(index));
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_upward_sharp),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        state.fakeWidgetList.remove(bean);
                      },
                      child: const Text("删除"))
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: logic.addLine,
        child: const Icon(Icons.add),
      ),
    );
  }
}
