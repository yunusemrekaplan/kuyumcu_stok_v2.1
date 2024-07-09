import 'package:get/get.dart';

import '../../model/data/entry.dart';
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

  Future<bool> getAll() async {
    List<Map<String, dynamic>>? result =
        await _dbHelper.getAll(entriesTableName);

    if (result == null) return false;

    entries.value = result
        .map(
          (e) => Entry.fromJson(
            json: e,
            id: e['id'],
          ),
        )
        .toList();
    return true;
  }

  Future<bool> add(Map<String, dynamic> data) async {
    int? result = await _dbHelper.add(data, entriesTableName);

    if (result == null) return false;

    entries.add(
      Entry.fromJson(
        json: data,
        id: result,
      ),
    );
    return true;
  }

  Future<bool> update(Map<String, dynamic> data, int id) async {
    int? result = await _dbHelper.update(data, entriesTableName, id);

    if (result == null) return false;

    entries[entries.indexWhere((element) => element.id == id)] = Entry.fromJson(
      json: data,
      id: id,
    );
    return true;
  }

  Future<bool> delete(int id) async {
    int? result = await _dbHelper.delete(entriesTableName, id);

    if (result == null) return false;

    entries.removeWhere((element) => element.id == id);
    return true;
  }
}
