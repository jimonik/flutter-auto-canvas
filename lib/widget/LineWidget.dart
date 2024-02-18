import 'package:custompaint/page/main/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LineWidget extends StatelessWidget {
  const LineWidget({super.key});

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
