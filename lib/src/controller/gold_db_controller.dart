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

  Future<bool> getAll() async {
    List<Map<String, dynamic>>? result = await _dbHelper.getAll(goldTableName);

    if (result == null) return false;

    golds.value = result
        .map(
          (e) => Gold.fromJson(
            json: e,
            id: e['id'],
          ),
        )
        .toList();
    return true;
  }

  Future<bool> add(Map<String, dynamic> data) async {
    int? result = await _dbHelper.add(data, goldTableName);

    if (result == null) return false;

    golds.add(
      Gold.fromJson(
        json: data,
        id: result,
      ),
    );
    return true;
  }

  Future<bool> update(Map<String, dynamic> data, int id) async {
    int? result = await _dbHelper.update(data, goldTableName, id);

    if (result == null) return false;

    golds[golds.indexWhere((element) => element.id == id)] = Gold.fromJson(
      json: data,
      id: id,
    );
    return true;
  }

  Future<bool> delete(int id) async {
    int? result = await _dbHelper.delete(goldTableName, id);

    if (result == null) return false;

    golds.removeWhere((element) => element.id == id);
    return true;
  }
}
