// ignore_for_file: control_flow_in_finally, depend_on_referenced_packages

import 'dart:io';
import 'package:kuyumcu_stok_v2/model/data/log.dart';
import 'package:kuyumcu_stok_v2/model/enum/log_state.dart';
import 'package:kuyumcu_stok_v2/model/extension/extension_log_state.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'constant.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();

  factory DbHelper() {
    return _instance;
  }

  DbHelper._internal();

  late Database _db;

  Future<void> openDb() async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    String dbPath = p.join(
      appDocumentsDir.path,
      folderName,
      dbName,
    );

    try {
      _db = await databaseFactory.openDatabase(dbPath);

      await _createTable();
    } on Exception catch (e) {
      Log(
        dateTime: DateTime.now(),
        state: LogState.openDatabase.stringDefinition,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> close() async {
    await _db.close();
  }

  Future<void> _createTable() async {
    await _db.execute(goldTableCreateQuery);
    await _db.execute(entriesTableCreateQuery);
    await _db.execute(productSalesTableCreateQuery);
  }

  Future<List<Map<String, dynamic>>?> getAll(String tableName) async {
    List<Map<String, dynamic>>? result;
    try {
      result = await _db.query(tableName);
    } on Exception catch (e) {
      Log(
        dateTime: DateTime.now(),
        state: LogState.getAllData.stringDefinition,
        errorMessage: e.toString(),
      );
    } finally {
      return result;
    }
  }

  Future<int?> add(Map<String, dynamic> data, String tableName) async {
    int? id;
    try {
      id = await _db.insert(tableName, data);
    } on Exception catch (e) {
      Log(
        dateTime: DateTime.now(),
        state: LogState.addData.stringDefinition,
        errorMessage: e.toString(),
      );
    } finally {
      return id;
    }
  }

  Future<int?> update(
    Map<String, dynamic> data,
    String tableName,
    int id,
  ) async {
    int? count;
    try {
      count = await _db.update(
        tableName,
        data,
        where: 'id = ?',
        whereArgs: [id],
      );
    } on Exception catch (e) {
      Log(
        dateTime: DateTime.now(),
        state: LogState.updateData.stringDefinition,
        errorMessage: e.toString(),
      );
    } finally {
      return count;
    }
  }

  Future<int?> delete(String tableName, int id) async {
    int? count;
    try {
      count = await _db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    } on Exception catch (e) {
      Log(
        dateTime: DateTime.now(),
        state: LogState.deleteData.stringDefinition,
        errorMessage: e.toString(),
      );
    } finally {
      return count;
    }
  }
}
