import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/theme_controller.dart';
import 'constant.dart';

final _themeController = Get.find<ThemeController>();

AppBar myAppBar(String title) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    actions: [
      Obx(
        () => IconButton(
          onPressed: () {
            _themeController.changeTheme();
          },
          icon: _themeController.isFirstTheme.value
              ? lightModeIcon
              : darkModeIcon,
          iconSize: iconSize,
        ),
      ),
      const SizedBox(width: 10.0),
    ],
  );
}
