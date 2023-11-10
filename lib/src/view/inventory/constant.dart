import 'package:flutter/material.dart';

const IconData searchIcon = Icons.search;

const showCheckboxColumn = false;

const Color textColor = Colors.white;
const Color iconColor = Colors.white;
const Color borderSideColor = Colors.white;
const Color searchBoxColor = Colors.white30;
const Color cursorColor = Colors.white;
const snackBarTextColor = Colors.white;
const snackBarErrorBackgroundColor = Colors.red;
const snackBarSuccessBackgroundColor = Colors.green;

const double columnSpacing = 25.0;
const double borderSideWith = 0.7;
const double radius = 25.0;
const double searchBoxFontSize = 16.0;
const double searchBoxContentLeftPadding = 5.0;
const double searchBoxContentRightPadding = 5.0;
const double searchBoxContentTopPadding = 0.0;
const double searchBoxContentBottomPadding = 10.0;
const double searchIconLeftPadding = 5.0;
const double searchIconTopPadding = 6.0;
const double tablePaddingAll = 20.0;
const double searchBoxMinWidth = 210.0;
const double searchBoxMaxHeight = 35.0;

const TextStyle searchBoxTextStyle = TextStyle(
  color: textColor,
  fontSize: searchBoxFontSize,
);

const EdgeInsets tablePadding = EdgeInsets.all(tablePaddingAll);
const EdgeInsets searchBoxContentPadding = EdgeInsets.fromLTRB(
  searchBoxContentLeftPadding,
  searchBoxContentTopPadding,
  searchBoxContentRightPadding,
  searchBoxContentBottomPadding,
);
const EdgeInsets searchIconPadding = EdgeInsets.only(
  left: searchIconLeftPadding,
  top: searchIconTopPadding,
);

BorderRadius borderRadius = BorderRadius.circular(radius);
TableBorder tableBorder = TableBorder(
  horizontalInside: const BorderSide(
    width: borderSideWith,
    color: borderSideColor,
  ),
  verticalInside: const BorderSide(
    width: borderSideWith,
    color: borderSideColor,
  ),
  borderRadius: borderRadius,
);
