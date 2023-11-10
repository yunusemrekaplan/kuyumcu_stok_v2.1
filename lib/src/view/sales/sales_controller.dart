import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/data/sale_db_controller.dart';
import '../../model/data/sale.dart';
import '../../model/enum/my_route.dart';

class SalesController extends GetxController {
  final _saleDbController = SaleDbController();
  final startDateController = TextEditingController().obs;
  final endDateController = TextEditingController().obs;

  DateTime selectedEndTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    23,
    59,
    59,
  );
  DateTime selectedStartTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    0,
    0,
    0,
  );

  late RxList<Sale> sales;

  Future<void> init() async {
    await getSales();
    sales = _saleDbController.sales
        .where((sale) =>
            sale.soldDate.isAfter(selectedStartTime) &&
            sale.soldDate.isBefore(selectedEndTime))
        .toList()
        .obs;

    startDateController.value.text =
        DateFormat.yMd('tr-Tr').format(selectedStartTime);
    endDateController.value.text =
        DateFormat.yMd('tr-Tr').format(selectedEndTime);
  }

  Future<void> getSales() async {
    bool state = await _saleDbController.getAll();

    if (!state) {
      Get.snackbar(
        'ERROR',
        'Satışlar getirilemedi!!!',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } else {
      sales = _saleDbController.sales;
    }
  }

  void onTimeFilter() {
    sales = _saleDbController.sales
        .where((sale) =>
            sale.soldDate.isAfter(selectedStartTime) &&
            sale.soldDate.isBefore(selectedEndTime))
        .toList()
        .obs;
    update([MyRoute.sales]);
  }
}
