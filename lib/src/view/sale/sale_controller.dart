import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/data/gold_db_controller.dart';
import '../../controller/service/currency_service.dart';
import '../../model/data/gold.dart';
import 'constant.dart';

class SaleController extends GetxController {
  final _currencyService = CurrencyService();
  final _goldDbController = GoldDbController();

  final barcodeTextEditingController = TextEditingController();
  final profitTlTextEditingController = TextEditingController();
  final profitGramTextEditingController = TextEditingController();
  final salesPriceTextEditingController = TextEditingController();
  final salesGramTextEditingController = TextEditingController();
  final pieceTextEditingController = TextEditingController();

  List<String> goldCells = ['İsim', 'Adet', 'Gram', 'Maliyet', 'S. Gramı'].obs;

  RxList<Gold> get golds => _goldDbController.golds;
  RxMap currencies = {}.obs;

  Future<void> init() async {
    await getCurrency();
    await getGolds();

    currencies.value = _currencyService.currencies;
    print(currencies);
    /*
    barcodeTextEditingController.addListener(() {
      if (barcodeTextEditingController.text.length == 13) {
        Gold gold = golds.firstWhere(
          (element) => element.barcode == barcodeTextEditingController.text,
          orElse: () => null,
        );
        if (gold != null) {
          pieceTextEditingController.text = '1';
          salesPriceTextEditingController.text = gold.salesPrice.toString();
          salesGramTextEditingController.text = gold.salesGram.toString();
          profitTlTextEditingController.text = gold.profitTl.toString();
          profitGramTextEditingController.text = gold.profitGram.toString();
        } else {
          Get.snackbar(
            'ERROR',
            'Ürün bulunamadı',
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      }
    });
    */
  }

  Future<void> onRefresh() async {
    await getCurrency();

    currencies.value = _currencyService.currencies;

    barcodeTextEditingController.clear();
    profitTlTextEditingController.clear();
    profitGramTextEditingController.clear();
    salesPriceTextEditingController.clear();
    salesGramTextEditingController.clear();
    pieceTextEditingController.clear();
  }

  Future<void> getCurrency() async {
    bool state = await _currencyService.getCurrenciesHakanAltin();
    if (!state) {
      //await _currencyService.getCurrenciesSaglamoglu();
      Get.snackbar(
        'ERROR',
        'Döviz kurları alınamadı',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> getGolds() async {
    bool state = await _goldDbController.getAll();
    if (!state) {
      Get.snackbar(
        'ERROR',
        'Kayıtlı ürünler getirilemedi',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
}
