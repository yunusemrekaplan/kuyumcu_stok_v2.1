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

  Future<bool> getAll() async {
    List<Map<String, dynamic>>? result = await _dbHelper.getAll(salesTableName);

    if (result == null) return false;

    sales.value = result
        .map(
          (e) => Sale.fromJson(
            json: e,
            id: e['id'],
          ),
        )
        .toList();
    return true;
  }

  Future<bool> add(Map<String, dynamic> data) async {
    int? result = await _dbHelper.add(data, salesTableName);

    if (result == null) return false;

    sales.add(
      Sale.fromJson(
        json: data,
        id: result,
      ),
    );
    return true;
  }

  Future<bool> update(Map<String, dynamic> data, int id) async {
    int? result = await _dbHelper.update(data, salesTableName, id);

    if (result == null) return false;

    sales[sales.indexWhere((element) => element.id == id)] = Sale.fromJson(
      json: data,
      id: id,
    );
    return true;
  }

  Future<bool> delete(int id) async {
    int? result = await _dbHelper.delete(salesTableName, id);

    if (result == null) return false;

    sales.removeWhere((element) => element.id == id);
    return true;
  }
}
