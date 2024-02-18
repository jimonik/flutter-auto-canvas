import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//文本输入框
class CustomTextField extends StatefulWidget {
  late TextEditingController controller;
  String? value;
  TextInputAction? textInputAction;
  InputDecoration? inputDecoration;
  Function(String)? onChanged;
  Function(bool hasFocus)? onFocusChanged;
  TextAlign textAlign;
  TextStyle? style;
  Color? cursorColor;
  List<TextInputFormatter>? inputFormatters;
  bool enabled;
  bool? obscureText;

  int? maxLines;
  TextInputType? keyboardType;

  CustomTextField({
    super.key,
    this.value,
    this.onChanged,
    this.inputDecoration,
    this.textInputAction = TextInputAction.done,
    this.cursorColor,
    this.onFocusChanged,
    this.maxLines,
    this.keyboardType,
    this.style,
    this.obscureText,
    this.inputFormatters,
    this.textAlign = TextAlign.start,
    this.enabled = true,
  }) {
    controller =
        TextEditingController.fromValue(TextEditingValue(text: value ?? ""));
  }

  @override
  State<StatefulWidget> createState() => _CustomTextField();
}

class _CustomTextField extends State<CustomTextField> {
  late TextEditingController controller;
  final _focusNode = FocusNode();

  @override
  void initState() {
    controller = widget.controller;
    controller.text = widget.value ?? "";
    super.initState();
    _focusNode.addListener(() {
      widget.onFocusChanged?.call(_focusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.controller = controller;
    if (widget.value != controller.text) {
      controller.text = widget.value ?? "";
    }
    return TextField(
      obscureText: widget.obscureText ?? false,
      focusNode: _focusNode,
      controller: controller,
      enabled: widget.enabled,
      cursorColor: widget.cursorColor,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      style: widget.style,
      decoration: widget.inputDecoration,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      textAlign: widget.textAlign,
      onChanged: (value) {
        widget.value = value;
        widget.onChanged?.call(controller.text);
      },
    );
  }
}
