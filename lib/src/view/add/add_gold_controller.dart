import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/data/gold_db_controller.dart';
import '../../model/data/gold.dart';

class AddGoldController extends GetxController {
  final _goldDbController = GoldDbController();
  final formKey = GlobalKey<FormState>().obs;
  final barcodeController = TextEditingController().obs;
  final pieceController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final caratController = TextEditingController().obs;
  final purityRateController = TextEditingController().obs;
  final laborCostController = TextEditingController().obs;

  final isValidateFailed = false.obs;
  final nameList = <String>[];
  final caratList = <String>[
    '8 Ayar',
    '14 Ayar',
    '18 Ayar',
    '22 Ayar',
    '24 Ayar',
  ];

  Future<void> init() async {
    await _goldDbController.getAll();

    for (Gold element in _goldDbController.golds) {
      if (nameList.contains(element.name) == false) {
        nameList.add(element.name);
      }
    }
  }

  void onChangedDropDownButton(String value, TextEditingController controller) {
    controller.text = value.toString();
  }

  AutovalidateMode isAutoValidateMode() => isValidateFailed.value
      ? AutovalidateMode.always
      : AutovalidateMode.disabled;
}
