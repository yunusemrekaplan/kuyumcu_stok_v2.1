import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/data/entry_db_controller.dart';
import '../../model/data/entry.dart';
import '../../model/enum/my_route.dart';

class EntriesController extends GetxController {
  final _entryDbController = EntryDbController();
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

  late RxList<Entry> entries;

  Future<void> init() async {
    await getEntries();
    entries = _entryDbController.entries
        .where((entry) =>
            entry.enteredDate.isAfter(selectedStartTime) &&
            entry.enteredDate.isBefore(selectedEndTime))
        .toList()
        .obs;

    startDateController.value.text =
        DateFormat.yMd('tr-Tr').format(selectedStartTime);
    endDateController.value.text =
        DateFormat.yMd('tr-Tr').format(selectedEndTime);
  }

  Future<void> getEntries() async {
    bool state = await _entryDbController.getAll();

    if (!state) {
      Get.snackbar(
        'ERROR',
        'Girişler getirilemedi!!!',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } else {
      entries = _entryDbController.entries;
    }
  }

  void onTimeFilter() {
    entries = _entryDbController.entries
        .where((entry) =>
            entry.enteredDate.isAfter(selectedStartTime) &&
            entry.enteredDate.isBefore(selectedEndTime))
        .toList()
        .obs;
    update([MyRoute.entries]);
  }
}
