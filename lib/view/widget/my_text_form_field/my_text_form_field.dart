// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constant.dart';

class MyTextFormField extends StatelessWidget {
  MyTextFormField({
    super.key,
    required this.formRowController,
    required this.hint,
    this.inputFormatters,
    required this.maxWidth,
    this.onChanged,
    this.isDecimal = false,
    this.isEnbaled = true,
  });

  late TextEditingController formRowController;
  late List<TextInputFormatter>? inputFormatters;
  void Function(String)? onChanged;
  late String hint;
  late double maxWidth;
  bool isDecimal;
  bool isEnbaled;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextFormField(
          controller: formRowController,
          style: const TextStyle(
            fontSize: textFontSize,
            color: textColor,
            height: height,
          ),
          decoration: inputDecoration(),
          inputFormatters: inputFormatters,
          keyboardType: TextInputType.numberWithOptions(
            decimal: isDecimal,
            signed: true,
          ),
          onChanged: onChanged,
          enabled: isEnbaled,
        ),
      ],
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: hintFontSize,
        color: textColor.withOpacity(0.7),
      ),
      border: border,
      enabledBorder: border,
      disabledBorder: border,
      focusedBorder: border,
      constraints: BoxConstraints(
        maxHeight: maxHeight,
        maxWidth: maxWidth,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: contentPaddingVertical,
        horizontal: contentPaddingHorizontal,
      ),
    );
  }
}
