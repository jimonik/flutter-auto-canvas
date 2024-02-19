import 'package:get/get.dart';

class CurveLineBean {
  final RxDouble startX;
  final RxDouble endX;
  final RxDouble startY;
  final RxDouble endY;

  CurveLineBean(
      {required this.startX,
      required this.endX,
      required this.startY,
      required this.endY});
  Map<String, dynamic> toJson() {
    return {
      "startX": startX.value,
      "endX": endX.value,
      "startY": startY.value,
      "endY": endY.value,
    };
  }
}
