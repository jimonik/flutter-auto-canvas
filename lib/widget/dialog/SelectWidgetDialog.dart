import 'package:custompaint/bean/WidgetType.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<WidgetType?> showSelectWidgetDialog() async {
  return await Get.dialog(Container(
    width: Get.width * 0.1,
    height: Get.height * 0.1,
    margin: EdgeInsets.symmetric(
        vertical: Get.height * 0.1, horizontal: Get.width * 0.1),
    decoration: const BoxDecoration(color: Colors.white),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: Get.back,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.close),
              ),
            )
          ],
        ),
        Expanded(
          child: Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: List.generate(WidgetType.values.length, (index) {
                var bean = WidgetType.values[index];
                return InkWell(
                  onTap: () {
                    Get.back(result: bean);
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        bean.name,
                        style: TextStyle(color: Colors.white),
                      )),
                );
              }),
            ),
          ),
        ),
      ],
    ),
  ));
}
