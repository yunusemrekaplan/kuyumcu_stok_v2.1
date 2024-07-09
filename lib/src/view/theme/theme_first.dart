import 'package:flutter/material.dart';

import 'constant.dart';

final themeFirst = ThemeData(
  appBarTheme: appBarTheme(),
  elevatedButtonTheme: elevatedButtonThemeData(),
  dataTableTheme: dataTableThemeData(),
  scrollbarTheme: scrollbarThemeData(),
  textTheme: const TextTheme(
    displayLarge: textStyle,
    displayMedium: textStyle,
    displaySmall: textStyle,
    headlineMedium: textStyle,
    headlineSmall: textStyle,
    titleLarge: textStyle,
    titleMedium: textStyle,
    titleSmall: textStyle,
    bodyLarge: textStyle,
    bodyMedium: textStyle,
    labelLarge: buttonTextStyle,
    bodySmall: textStyle,
    labelSmall: textStyle,
  ),
  scaffoldBackgroundColor: firstThemeScaffoldBackgroundColor,
);

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    backgroundColor: firstThemeAppBarColor,
    titleTextStyle: appBarTitleTextStyle,
  );
}

ElevatedButtonThemeData elevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(firstThemeButtonColor),
      textStyle: MaterialStateProperty.all<TextStyle>(buttonTextStyle),
    ),
  );
}

DataTableThemeData dataTableThemeData() {
  return DataTableThemeData(
    headingRowColor:
        MaterialStateProperty.all<Color>(firstThemeDataTableHeadingRowColor),
    dataRowColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered)) {
          return firstThemeScaffoldBackgroundColor;
        } else if (states.contains(MaterialState.pressed)) {
          return firstThemeDataTableHeadingRowColor;
        }
        return null;
      },
    ),
    headingTextStyle: tableHeadingTextStyle,
    dataTextStyle: tableDataTextStyle,
  );
}

ScrollbarThemeData scrollbarThemeData() {
  return ScrollbarThemeData(
    thumbColor: MaterialStateProperty.all<Color>(scrollbarThumbColor),
  );
}
