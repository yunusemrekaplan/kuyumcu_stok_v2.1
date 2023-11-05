// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constant.dart';

class FormRow extends StatelessWidget {
  FormRow({
    super.key,
    required this.formRowController,
    required this.hint,
    required this.inputFormatters,
    required this.maxWidth,
    required this.onChanged,
  });

  late TextEditingController formRowController;
  late List<TextInputFormatter> inputFormatters;
  late void Function(String)? onChanged;
  late String hint;
  late double maxWidth;

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
          onChanged: onChanged,
        ),
      ],
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: hintFontSize,
        color: textColor,
      ),
      border: border,
      enabledBorder: border,
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
