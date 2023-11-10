import 'package:flutter/material.dart';

const dateFormat = 'yyyy-MM-dd HH:mm:ss';

const labelFontSize = 24.0;
const paddingBoxWidth = 10.0;
const maxWidth = 140.0;
const maxHeight = 40.0;
const borderWidth = 1.0;
const horizontalPadding = 10.0;
const dateFontSize = 22.0;
const datePickerBoxWidth = 300.0;
const datePickerBoxHeight = 200.0;

const borderColor = Colors.white;
const textColor = Colors.white;

const contentPadding = EdgeInsets.symmetric(horizontal: horizontalPadding);

final endTime = DateTime.now();
final startTime = DateTime.now().subtract(const Duration(days: 360));
