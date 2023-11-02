import 'package:get/get.dart';

import '../model/data/entry.dart';
import 'constant.dart';
import 'db_helper.dart';

class EntryDbController {
  static final EntryDbController _instance = EntryDbController._internal();

  factory EntryDbController() {
    return _instance;
  }

  EntryDbController._internal();

  final _dbHelper = DbHelper();
  RxList<Entry> entries = <Entry>[].obs;

  Future<void> getAll() async {
    List<Map<String, dynamic>>? result =
        await _dbHelper.getAll(entriesTableName);
    if (result != null) {
      entries.value = result
          .map(
            (e) => Entry.fromJson(
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
    int? result = await _dbHelper.add(data, entriesTableName);
    if (result != null) {
      entries.add(
        Entry.fromJson(
          json: data,
          id: result,
        ),
      );
    }
    Get.snackbar(
      'ERROR',
      ' ',
      colorText: snackBarErrorTextColor,
      backgroundColor: snackBarErrorBackgroundColor,
    );
  }

  Future<void> update(Map<String, dynamic> data, int id) async {
    int? result = await _dbHelper.update(data, goldTableName, id);
    if (result != null) {
      entries[entries.indexWhere((element) => element.id == id)] =
          Entry.fromJson(
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
    int? result = await _dbHelper.delete(goldTableName, id);
    if (result != null) {
      entries.removeWhere((element) => element.id == id);
    }
    Get.snackbar(
      'ERROR',
      ' ',
      colorText: snackBarErrorTextColor,
      backgroundColor: snackBarErrorBackgroundColor,
    );
  }
}
