import 'package:flutter/material.dart';

const iconColor = Colors.white;
const dropdownColor = Colors.blueGrey;
const textColor = Colors.white;
const underLineColor = Colors.white;

const dropdownIconSize = 24.0;
const dropdownValueTextSize = 24.0;
const dropdownHintTextSize = 22.0;
const dropdownHintTextHeight = 0.4;
const dropdownPaddingBottom = 4.0;
const dropdownButtonUnderlineHeight = 1.0;

const bool dropdownIsExpanded = true;

Icon dropDownIcon = const Icon(Icons.arrow_downward, color: iconColor);

const dropdownButtonTextStyle = TextStyle(
  color: textColor,
  fontSize: dropdownValueTextSize,
  height: dropdownHintTextHeight,
);

const EdgeInsets dropdownPadding = EdgeInsets.only(
  bottom: dropdownPaddingBottom,
);

const dropdownItemTextStyle = TextStyle(
  color: textColor,
  fontSize: dropdownValueTextSize,
);
const dropdownHintTextStyle = TextStyle(
  color: textColor,
  fontSize: dropdownHintTextSize,
  height: dropdownHintTextHeight,
);

const List<String> carats = [
  '8 Ayar',
  '10 Ayar',
  '14 Ayar',
  '18 Ayar',
  '22 Ayar',
  '24 Ayar',
];
