import 'package:flutter/material.dart';

const textColor = Colors.white;
const iconColor = Colors.white;
const dropdownColor = Colors.blueGrey;
const underLineColor = Colors.white;
const borderSideColor = Colors.white;
final hintColor = Colors.white.withOpacity(0.5);

const textBoxWidth = 130.0;
const textBoxHeight = 50.0;
const formTextSize = 26.0;
const textFormFieldPaddingLeft = 10.0;
const textFormFieldPaddingRight = 20.0;
const textFormFieldPaddingBottom = 0.0;
const textFormFieldTextSize = 22.0;
const dropdownWidth = 400.0;
const dropdownIconSize = 24.0;
const dropdownHintTextSize = 22.0;
const dropdownHintTextHeight = 0.4;
const dropdownValueTextSize = 24.0;
const dropdownPaddingBottom = 4.0;
const dropdownButtonUnderlineHeight = 1.0;
const contentPaddingLeft = 10.0;
const contentPaddingRight = 10.0;
const boxConstraintsMaxWidth = 300.0;
const boxConstraintsMinHeight = 70.0;
const boxConstraintsMaxHeight = 70.0;

const bool dropdownIsExpanded = true;

const formTextStyle = TextStyle(
  color: textColor,
  fontSize: formTextSize,
);
const textFormFieldTextStyle = TextStyle(
  color: textColor,
  fontSize: textFormFieldTextSize,
);
const dropdownHintTextStyle = TextStyle(
  color: textColor,
  fontSize: dropdownHintTextSize,
  height: dropdownHintTextHeight,
);
const dropdownButtonTextStyle = TextStyle(
  color: textColor,
  fontSize: dropdownValueTextSize,
  height: dropdownHintTextHeight,
);
const dropdownItemTextStyle = TextStyle(
  color: textColor,
  fontSize: dropdownValueTextSize,
);
final textFormFieldHintTextStyle = TextStyle(
  color: hintColor,
  fontSize: textFormFieldTextSize,
);

const EdgeInsets textFormFieldPadding = EdgeInsets.only(
  left: textFormFieldPaddingLeft,
  right: textFormFieldPaddingRight,
  bottom: textFormFieldPaddingBottom,
);
const EdgeInsets dropdownPadding = EdgeInsets.only(
  bottom: dropdownPaddingBottom,
);
const EdgeInsets contentPadding = EdgeInsets.only(
  left: contentPaddingLeft,
  right: contentPaddingRight,
);

BorderSide borderSide = const BorderSide(color: borderSideColor);

InputBorder textFormFieldBorder = UnderlineInputBorder(borderSide: borderSide);

BoxConstraints boxConstraints = const BoxConstraints(
  maxWidth: boxConstraintsMaxWidth,
  minHeight: boxConstraintsMinHeight,
  maxHeight: boxConstraintsMaxHeight,
);

Icon dropDownIcon = const Icon(Icons.arrow_downward, color: iconColor);
