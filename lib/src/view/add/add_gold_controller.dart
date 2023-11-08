import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/data/gold_db_controller.dart';
import '../../controller/service/barcode_service.dart';
import '../../model/data/gold.dart';

class AddGoldController extends GetxController {
  static final AddGoldController _instance = AddGoldController._internal();

  factory AddGoldController() {
    return _instance;
  }

  AddGoldController._internal();

  final _goldDbController = GoldDbController();
  final formKey = GlobalKey<FormState>().obs;
  final barcodeController = TextEditingController().obs;
  final pieceController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final caratController = TextEditingController().obs;
  final purityRateController = TextEditingController().obs;
  final laborCostController = TextEditingController().obs;
  final gramController = TextEditingController().obs;
  final costController = TextEditingController().obs;
  final salesGramController = TextEditingController().obs;

  final isValidateFailed = false.obs;
  final pieceList = <String>['1', '2', '3', '4', '5', '6', '7', '8', '9'];
  final nameList = <String>[];
  final caratList = <String>[
    '8 Ayar',
    '10 Ayar',
    '14 Ayar',
    '18 Ayar',
    '22 Ayar',
    '24 Ayar',
  ];
  final laborCostList = <String>[];

  Future<void> init() async {
    await _goldDbController.getAll();

    for (Gold element in _goldDbController.golds) {
      if (nameList.contains(element.name) == false) {
        nameList.add(element.name);
      }
      if (laborCostList.contains(element.laborCost.toString()) == false) {
        laborCostList.add(element.laborCost.toString());
      }
    }
  }

  void onChangedDropDownButton(String value, TextEditingController controller) {
    controller.text = value.toString();

    buildPurityRateForm(controller);
  }

  void onChangedTextFormField(String? value) {
    double? purityRate = double.tryParse(purityRateController.value.text);
    double? laborCost = double.tryParse(laborCostController.value.text);
    double? gram = double.tryParse(gramController.value.text);

    if (purityRate != null && laborCost != null && gram != null) {
      String cost = ((purityRate + laborCost) * gram).toStringAsFixed(3);
      costController.value.text = cost;
    }
  }

  Future<void> onPressedSaveButton() async {
    isValidateFailed.value = !formKey.value.currentState!.validate();

    if (!isValidateFailed.value) {
      Get.dialog(const CircularProgressIndicator());
      //await addProduct();
    }
  }

  void onGenerateBarcode() {
    barcodeController.value.text = BarcodeService().generateCode();
  }

  void buildPurityRateForm(TextEditingController controller) {
    if (controller == caratController.value) {
      switch (caratController.value.text) {
        case '8 Ayar':
          purityRateController.value.text = '0.333';
          break;
        case '10 Ayar':
          purityRateController.value.text = '0.417';
          break;
        case '14 Ayar':
          purityRateController.value.text = '0.585';
          break;
        case '18 Ayar':
          purityRateController.value.text = '0.750';
          break;
        case '22 Ayar':
          purityRateController.value.text = '0.916';
          break;
        case '24 Ayar':
          purityRateController.value.text = '0.995';
          break;
        default:
          purityRateController.value.text = '';
      }
    }
  }

  AutovalidateMode isAutoValidateMode() => isValidateFailed.value
      ? AutovalidateMode.always
      : AutovalidateMode.disabled;
}
