import 'package:flutter/material.dart';

class Util {
  static String getColorValue(Color color) => color == Colors.transparent
      ? '0xFFFFFFFF(透明)'
      : '0x${color.value.toRadixString(16).padLeft(6, '0').toUpperCase()}';

  static Color? string2Color(String inputColor) {
    try {
      int value = int.parse(inputColor.substring(2), radix: 16);
      double opacity = ((value >> 24) & 0xFF) / 255.0;
      int red = (value >> 16) & 0xFF;
      int green = (value >> 8) & 0xFF;
      int blue = value & 0xFF;
      return Color.fromRGBO(red, green, blue, opacity);
    } catch (error) {
      return null;
    }
  }
}
