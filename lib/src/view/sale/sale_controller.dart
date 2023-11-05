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

  List<String> cells = ['İsim', 'Adet', 'Gram', 'Maliyet', 'S. Gramı'].obs;

  RxList<Gold> get golds => _goldDbController.golds;
  Map<String, double> get currencies => _currencyService.currencies;

  List<DataColumn> get tableColumns => [
        const DataColumn(
          label: Text(
            'İsim',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: goldTableColumnFontSize,
            ),
          ),
        ),
        const DataColumn(
          numeric: true,
          label: Text(
            'Adet',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: goldTableColumnFontSize,
            ),
          ),
        ),
        const DataColumn(
          numeric: true,
          label: Text(
            'Gram',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: goldTableColumnFontSize,
            ),
          ),
        ),
        const DataColumn(
          numeric: true,
          label: Text(
            'Maliyet',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: goldTableColumnFontSize,
            ),
          ),
        ),
        const DataColumn(
          numeric: true,
          label: Text(
            'S. Gramı',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: goldTableColumnFontSize,
            ),
          ),
        ),
      ];

  List<DataRow> get tableRows => [
        DataRow(
          cells: [
            DataCell(
              Text(
                cells[0],
                style: const TextStyle(
                  color: textColor,
                  fontSize: goldTableCellFontSize,
                ),
              ),
            ),
            DataCell(
              Text(
                cells[1],
                style: const TextStyle(
                  color: textColor,
                  fontSize: goldTableCellFontSize,
                ),
              ),
            ),
            DataCell(
              Text(
                cells[2],
                style: const TextStyle(
                  color: textColor,
                  fontSize: goldTableCellFontSize,
                ),
              ),
            ),
            DataCell(
              Text(
                cells[3],
                style: const TextStyle(
                  color: textColor,
                  fontSize: goldTableCellFontSize,
                ),
              ),
            ),
            DataCell(
              Text(
                cells[4],
                style: const TextStyle(
                  color: textColor,
                  fontSize: goldTableCellFontSize,
                ),
              ),
            ),
          ],
        ),
      ];

  Future<void> init() async {
    await getCurrency();
    await getGolds();
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
