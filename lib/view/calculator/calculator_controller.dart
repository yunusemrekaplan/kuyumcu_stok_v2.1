import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/calculator.dart';

class CalculatorController extends GetxController {
  final _calculator = Calculator();
  final caratController = TextEditingController().obs;
  final purityRateController = TextEditingController().obs;
  final gramController = TextEditingController().obs;
  final laborCostController = TextEditingController().obs;
  final costController = TextEditingController().obs;

  Rx<Icon> icon = Icon(
    Icons.toggle_off,
    color: Colors.white.withOpacity(0.5),
  ).obs;
  bool isWeddingRing = false;

  void onChangedDropDownButton(String value) {
    caratController.value.text = value;

    buildPurityRateForm();
  }

  void changeIcon() {
    if (isWeddingRing) {
      icon.value = Icon(
        Icons.toggle_off,
        color: Colors.white.withOpacity(0.5),
      );
      isWeddingRing = false;
    } else {
      icon.value = const Icon(
        Icons.toggle_on,
        color: Colors.white,
      );
      isWeddingRing = true;
    }
    onChangedTextFormField(null);
  }

  // cost calculation
  void onChangedTextFormField(String? value) {
    double? purityRate = double.tryParse(purityRateController.value.text);
    double? laborCost = double.tryParse(laborCostController.value.text);
    double? gram = double.tryParse(gramController.value.text);

    if (purityRate != null && laborCost != null && gram != null) {
      String cost = isWeddingRing
          ? _calculator
              .calculateWeddingRingCost(gram, laborCost, purityRate)
              .toStringAsFixed(3)
          : _calculator
              .calculateCost(gram, laborCost, purityRate)
              .toStringAsFixed(3);
      costController.value.text = cost;
    }
  }

  void buildPurityRateForm() {
    switch (caratController.value.text) {
      case '8':
        purityRateController.value.text = '0.333';
        break;
      case '10':
        purityRateController.value.text = '0.417';
        break;
      case '14':
        purityRateController.value.text = '0.585';
        break;
      case '18':
        purityRateController.value.text = '0.750';
        break;
      case '22':
        purityRateController.value.text = '0.916';
        break;
      case '24':
        purityRateController.value.text = '0.995';
        break;
      default:
        purityRateController.value.text = '';
    }
  }
}
