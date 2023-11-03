import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant.dart';
import '../../controller/data/gold_db_controller.dart';
import '../../model/data/gold.dart';
import 'constant.dart';

class InventoryController extends GetxController {
  final _goldDbController = GoldDbController();
  final TextEditingController searchController = TextEditingController();

  Rx<Color> searchIconColor = iconColor.withOpacity(1).obs;
  FocusNode searchFocusNode = FocusNode();

  InventoryController() {
    searchFocusNode.addListener(
      () {
        if (searchFocusNode.hasFocus) {
          searchIconColor.value = iconColor.withOpacity(0);
        } else {
          searchIconColor.value = iconColor.withOpacity(1);
          searchController.clear();
        }
      },
    );
  }

  RxList<Gold> get golds => _goldDbController.golds;

  Future<void> getGolds() async {
    bool state = await _goldDbController.getAll();

    if (!state) {
      Get.snackbar(
        'ERROR',
        'Ürünler getirilemedi!!!',
        colorText: snackBarErrorTextColor,
        backgroundColor: snackBarErrorBackgroundColor,
      );
    }
  }
}
