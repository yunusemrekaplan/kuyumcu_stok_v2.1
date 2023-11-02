import 'package:get/get.dart';

import '../model/data/sale.dart';
import 'constant.dart';
import 'db_helper.dart';

class SaleDbController {
  static final SaleDbController _instance = SaleDbController._internal();

  factory SaleDbController() {
    return _instance;
  }

  SaleDbController._internal();

  final _dbHelper = DbHelper();
  RxList<Sale> sales = <Sale>[].obs;

  Future<void> getAll() async {
    List<Map<String, dynamic>>? result = await _dbHelper.getAll(salesTableName);
    if (result != null) {
      sales.value = result
          .map(
            (e) => Sale.fromJson(
              json: e,
              id: e['id'],
            ),
          )
          .toList();
    }
    Get.snackbar(
      'ERROR',
      'Veriler getirilemedi!!!',
      colorText: snackBarErrorTextColor,
      backgroundColor: snackBarErrorBackgroundColor,
    );
  }

  Future<void> add(Map<String, dynamic> data) async {
    int? result = await _dbHelper.add(data, salesTableName);
    if (result != null) {
      sales.add(
        Sale.fromJson(
          json: data,
          id: result,
        ),
      );
    }
    Get.snackbar(
      'ERROR',
      'Satış Kayıt Edilemedi!!!',
      colorText: snackBarErrorTextColor,
      backgroundColor: snackBarErrorBackgroundColor,
    );
  }

  Future<void> update(Map<String, dynamic> data, int id) async {
    int? result = await _dbHelper.update(data, salesTableName, id);
    if (result != null) {
      sales[sales.indexWhere((element) => element.id == id)] = Sale.fromJson(
        json: data,
        id: id,
      );
    }
    Get.snackbar(
      'ERROR',
      ' ',
      colorText: snackBarErrorTextColor,
      backgroundColor: snackBarErrorBackgroundColor,
    );
  }

  Future<void> delete(int id) async {
    int? result = await _dbHelper.delete(salesTableName, id);
    if (result != null) {
      sales.removeWhere((element) => element.id == id);
    }
    Get.snackbar(
      'ERROR',
      ' ',
      colorText: snackBarErrorTextColor,
      backgroundColor: snackBarErrorBackgroundColor,
    );
  }
}
