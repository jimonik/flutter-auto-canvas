import 'package:custompaint/MyCustomPainter.dart';
import 'package:custompaint/widget/properties/edit/EditPropertiesWidget.dart';
import 'package:custompaint/widget/properties/tab/PublicPropertyWidget.dart';
import 'package:custompaint/widget/properties/tab/ShapeWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<MainLogic>();
    final state = logic.state;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("自定义组件代码生成器"),
        centerTitle: true,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey.shade200,
              child: Center(
                child: Obx(() {
                  return CustomPaint(
                    size: Size(state.panelWidth.value, state.panelHeight.value),
                    painter: MyCustomPainter(
                      backgroundColor: state.backgroundColor.value,
                      line: state.fakeWidgetList.value,
                    ),
                  );
                }),
              ),
            ),
          ),
          const Expanded(flex: 1, child: EditPropertiesWidget()),
          const Expanded(
              flex: 1,
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Tab(
                      child: TabBar(tabs: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("公共属性"),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("形状"),
                        ),
                      ]),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          PublicPropertyWidget(),
                          ShapeWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
