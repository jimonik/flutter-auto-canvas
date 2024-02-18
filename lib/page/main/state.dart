import 'package:custompaint/bean/Line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainState {
  Rx<Color> backgroundColor = (Colors.transparent).obs;
  RxList<FakeWidget> fakeWidgetList = <FakeWidget>[].obs;
  String inputColor = '';
  RxInt selectedFakeWidget = (-1).obs;
  RxDouble panelWidth = (400.0).obs;
  RxDouble panelHeight = (400.0).obs;

  String inputLineColor = "";
}
