import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme_first.dart';
import 'theme_sec.dart';
import 'constant.dart';

class ThemeController extends GetxController {
  RxBool isFirstTheme = true.obs;
  Rx<Color> containerColor = firstThemeContainerColor.obs;

  void changeTheme() {
    isFirstTheme.value = !isFirstTheme.value;
    if (isFirstTheme.value) {
      Get.changeTheme(themeFirst);
      containerColor.value = firstThemeContainerColor;
    } else {
      containerColor.value = secThemeContainerColor;
      Get.changeTheme(themeSec);
    }
    update();
  }
}
