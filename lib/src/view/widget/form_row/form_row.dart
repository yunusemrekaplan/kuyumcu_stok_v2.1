// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../add/add_gold_controller.dart';
import '../../validator.dart';
import 'constant.dart';

class FormRow extends StatelessWidget {
  FormRow({
    super.key,
    required this.controller,
    required this.text,
    this.hintText,
    this.isEnableDropDownButton = false,
    this.dropdownHintText,
    this.isInteger = false,
    this.isDecimal = false,
    this.isEnabled = true,
    this.isBarcode = false,
    this.isSaveButton = false,
    this.dropdownList = const [],
  });

  final _addGoldController = Get.find<AddGoldController>();
  final _validator = Validator();

  final inetegerFormat = FilteringTextInputFormatter.digitsOnly;
  final decimalFormat = FilteringTextInputFormatter.allow(
    RegExp(r'^\d+\.?\d{0,3}'),
  );

  final bool isEnableDropDownButton;
  final bool isInteger;
  final bool isDecimal;
  final bool isEnabled;
  final bool isBarcode;
  final bool isSaveButton;

  late TextEditingController controller;
  late String text;
  late String? hintText;
  late String? dropdownHintText;
  late List<String> dropdownList;

  @override
  Widget build(BuildContext context) {
    return buildRow();
  }

  Row buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTextBox(),
        buildTextFormField(),
        buildDropDownButtonOrContainer(),
      ],
    );
  }

  SizedBox buildTextBox() {
    return SizedBox(
      width: textBoxWidth,
      height: textBoxHeight,
      child: Text(
        text,
        style: formTextStyle,
      ),
    );
  }

  Padding buildTextFormField() {
    return Padding(
      padding: textFormFieldPadding,
      child: TextFormField(
        controller: controller,
        onChanged: _addGoldController.onChangedTextFormField,
        validator: _validator.validateEmpty,
        style: textFormFieldTextStyle,
        decoration: buildInputDecoration(),
        enabled: isEnabled,
        keyboardType: isDecimal == true
            ? const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              )
            : isInteger == true
                ? TextInputType.number
                : TextInputType.text,
        inputFormatters: [
          isInteger == true
              ? inetegerFormat
              : FilteringTextInputFormatter.deny(''),
          isDecimal == true
              ? decimalFormat
              : FilteringTextInputFormatter.deny(''),
        ],
      ),
    );
  }

  Widget buildDropDownButtonOrContainer() {
    return (isEnableDropDownButton == true
        ? (dropdownList.isNotEmpty
            ? buildDropdownButtonBox()
            : Container(width: dropdownWidth))
        : isBarcode == true
            ? buildBarcodeGenerateButton()
            : isSaveButton == true
                ? buildSaveButtons()
                : Container(width: dropdownWidth));
  }

  SizedBox buildDropdownButtonBox() {
    return SizedBox(
      width: dropdownWidth,
      child: buildDropDownButton(),
    );
  }

  DropdownButton buildDropDownButton() {
    return DropdownButton(
      icon: dropDownIcon,
      iconSize: dropdownIconSize,
      isExpanded: dropdownIsExpanded,
      dropdownColor: dropdownColor,
      hint: Text(dropdownHintText!, style: dropdownHintTextStyle),
      style: dropdownButtonTextStyle,
      padding: dropdownPadding,
      underline: Container(
          height: dropdownButtonUnderlineHeight, color: underLineColor),
      items: buildDropDownMenuItemList(),
      onChanged: (value) =>
          _addGoldController.onChangedDropDownButton(value, controller),
    );
  }

  List<DropdownMenuItem> buildDropDownMenuItemList() {
    return dropdownList.map(
      (value) {
        return DropdownMenuItem(
          value: value.split(' ').length == 2
              ? (value.split(' ')[1] == 'Ayar' ? value.split(' ')[0] : value)
              : value,
          child: Text(value.toString(), style: dropdownItemTextStyle),
        );
      },
    ).toList();
  }

  InputDecoration buildInputDecoration() {
    return InputDecoration(
      border: textFormFieldBorder,
      enabledBorder: textFormFieldBorder,
      disabledBorder: textFormFieldBorder,
      hintText: hintText,
      hintStyle: textFormFieldHintTextStyle,
      contentPadding: contentPadding,
      constraints: boxConstraints,
    );
  }

  SizedBox buildBarcodeGenerateButton() {
    return SizedBox(
      width: dropdownWidth,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ElevatedButton(
          onPressed: _addGoldController.onGenerateBarcode,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
          ),
          child: const Text(
            barcodeGenerateButtonText,
            style: TextStyle(
              fontSize: buttonFontSize,
              letterSpacing: letterSpacing,
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildSaveButtons() {
    return SizedBox(
      width: dropdownWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildSaveAndPrintButton(),
          buildSaveButton(),
        ],
      ),
    );
  }

  ElevatedButton buildSaveButton() {
    return ElevatedButton(
      onPressed: _addGoldController.onPressedSaveButton,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
      ),
      child: const Text(
        saveButtonText,
        style: TextStyle(
          fontSize: buttonFontSize,
          letterSpacing: letterSpacing,
        ),
      ),
    );
  }

  ElevatedButton buildSaveAndPrintButton() {
    return ElevatedButton(
      onPressed: _addGoldController.onPressedSaveAndPrintButton,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
      ),
      child: const Text(
        saveAndPrintButtonText,
        style: TextStyle(
          fontSize: buttonFontSize,
          letterSpacing: letterSpacing,
        ),
      ),
    );
  }
}
