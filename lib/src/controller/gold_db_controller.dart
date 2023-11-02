import 'package:get/get.dart';

import '../model/data/gold.dart';
import 'constant.dart';
import 'db_helper.dart';

class GoldDbController {
  static final GoldDbController _instance = GoldDbController._internal();

  factory GoldDbController() {
    return _instance;
  }

  GoldDbController._internal();

  final _dbHelper = DbHelper();
  RxList<Gold> golds = <Gold>[].obs;

  Future<void> getAll() async {
    List<Map<String, dynamic>>? result = await _dbHelper.getAll(goldTableName);
    if (result != null) {
      golds.value = result
          .map(
            (e) => Gold.fromJson(
              json: e,
              id: e['id'],
            ),
          )
          .toList();
    }
    Get.snackbar(
      'ERROR',
      'Ürünler getirilemedi!!!',
      colorText: snackBarErrorTextColor,
      backgroundColor: snackBarErrorBackgroundColor,
    );
  }

  Future<void> add(Map<String, dynamic> data) async {
    int? result = await _dbHelper.add(data, goldTableName);
    if (result != null) {
      golds.add(
        Gold.fromJson(
          json: data,
          id: result,
        ),
      );
    }
    Get.snackbar(
      'ERROR',
      'Ürün Kayıt Edilemedi!!!',
      colorText: snackBarErrorTextColor,
      backgroundColor: snackBarErrorBackgroundColor,
    );
  }

  Future<void> update(Map<String, dynamic> data, int id) async {
    int? result = await _dbHelper.update(data, goldTableName, id);
    if (result != null) {
      golds[golds.indexWhere((element) => element.id == id)] = Gold.fromJson(
        json: data,
        id: id,
      );
    }
    Get.snackbar(
      'ERROR',
      'Ürün Güncellenemedi!!!',
      colorText: snackBarErrorTextColor,
      backgroundColor: snackBarErrorBackgroundColor,
    );
  }

  Future<void> delete(int id) async {
    int? result = await _dbHelper.delete(goldTableName, id);
    if (result != null) {
      golds.removeWhere((element) => element.id == id);
    }
    Get.snackbar(
      'ERROR',
      'Ürün Silinemedi!!!',
      colorText: snackBarErrorTextColor,
      backgroundColor: snackBarErrorBackgroundColor,
    );
  }
}
