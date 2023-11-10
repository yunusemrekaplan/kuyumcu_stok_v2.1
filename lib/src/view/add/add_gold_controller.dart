import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/data/gold_db_controller.dart';
import '../../controller/service/barcode_service.dart';
import '../../model/data/gold.dart';
import '../../model/enum/my_route.dart';

class AddGoldController extends GetxController {
  static final AddGoldController _instance = AddGoldController._internal();

  factory AddGoldController() {
    return _instance;
  }

  AddGoldController._internal();

  final _goldDbController = GoldDbController();
  final _barcodeService = BarcodeService();
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
    clear();
    await _goldDbController.getAll();

    buildList();
  }

  void buildList() {
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
    onChangedTextFormField(value);
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

  Future<void> onPressedSaveAndPrintButton() async {
    if (barcodeController.value.text.isEmpty) {
      barcodeController.value.text = _barcodeService.generateCode();
    }

    isValidateFailed.value = !formKey.value.currentState!.validate();

    if (!isValidateFailed.value) {
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
      );
      Gold gold = Gold(
        barcodeText: barcodeController.value.text,
        piece: int.parse(pieceController.value.text),
        name: nameController.value.text,
        carat: int.parse(caratController.value.text),
        purityRate: double.parse(purityRateController.value.text),
        laborCost: double.parse(laborCostController.value.text),
        gram: double.parse(gramController.value.text),
        cost: double.parse(costController.value.text),
        salesGrams: double.parse(salesGramController.value.text),
      );
      await _goldDbController.add(gold.toJson());
      Get.back();
      Get.snackbar(
        'Başarılı',
        'Altın Eklendi',
        colorText: Colors.white,
        backgroundColor: Colors.green,
        duration: const Duration(milliseconds: 1000),
      );
      bool state = await _barcodeService.printBarcode(gold);
      clear();
      update([MyRoute.addGold]);
      if (!state) {
        Get.snackbar(
          'HATA!',
          'Barkod yazdırılamadı.',
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } else if (caratController.value.text.isEmpty) {
      Get.snackbar(
        'HATA!',
        'Lütfen ayar seçiniz.',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> onPressedSaveButton() async {
    if (barcodeController.value.text.isEmpty) {
      barcodeController.value.text = _barcodeService.generateCode();
    }

    isValidateFailed.value = !formKey.value.currentState!.validate();

    if (!isValidateFailed.value) {
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
      );
      Gold gold = Gold(
        barcodeText: barcodeController.value.text,
        piece: int.parse(pieceController.value.text),
        name: nameController.value.text,
        carat: int.parse(caratController.value.text),
        purityRate: double.parse(purityRateController.value.text),
        laborCost: double.parse(laborCostController.value.text),
        gram: double.parse(gramController.value.text),
        cost: double.parse(costController.value.text),
        salesGrams: double.parse(salesGramController.value.text),
      );
      await _goldDbController.add(gold.toJson());
      Get.back();
      Get.snackbar(
        'Başarılı',
        'Altın Eklendi',
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
      clear();
      update([MyRoute.addGold]);
    } else if (caratController.value.text.isEmpty) {
      Get.snackbar(
        'HATA!',
        'Lütfen ayar seçiniz.',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  void onGenerateBarcode() {
    barcodeController.value.text = _barcodeService.generateCode();
  }

  void buildPurityRateForm(TextEditingController controller) {
    if (controller == caratController.value) {
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

  void clear() {
    barcodeController.value.clear();
    pieceController.value.clear();
    nameController.value.clear();
    caratController.value.clear();
    purityRateController.value.clear();
    laborCostController.value.clear();
    gramController.value.clear();
    costController.value.clear();
    salesGramController.value.clear();
  }

  AutovalidateMode isAutoValidateMode() => isValidateFailed.value
      ? AutovalidateMode.always
      : AutovalidateMode.disabled;
}
