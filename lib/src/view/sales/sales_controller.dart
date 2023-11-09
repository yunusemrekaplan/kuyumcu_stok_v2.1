import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/data/sale_db_controller.dart';
import '../../model/data/sale.dart';

class SalesController extends GetxController {
  final _saleDbController = SaleDbController();

  RxList<Sale> get sales => _saleDbController.sales;

  Future<void> getSales() async {
    bool state = await _saleDbController.getAll();

    if (!state) {
      Get.snackbar(
        'ERROR',
        'Satışlar getirilemedi!!!',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
}
