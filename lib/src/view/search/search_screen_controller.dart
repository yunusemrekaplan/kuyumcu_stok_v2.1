import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuyumcu_stok_v2/src/model/extension/extension_route_name.dart';

import '../../controller/data/gold_db_controller.dart';
import '../../model/data/gold.dart';
import '../../model/enum/my_route.dart';

class SearchScreenController extends GetxController {
  final barcodeController = TextEditingController();
  final nameController = TextEditingController();
  final goldDbController = GoldDbController();

  RxString dropdownValue = 'Hepsi'.obs;
  List<Gold> golds = [];
  RxList<DataRow> dataRows = <DataRow>[].obs;

  Future<void> init() async {
    bool state = await goldDbController.getAll();

    if (state) {
      golds = goldDbController.golds;
    } else {
      Get.snackbar(
        'HATA',
        'Altınlar getirilemedi.',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  void onSearch() {
    golds = goldDbController.golds;
    dataRows.clear();
    if (dropdownValue.value == 'Hepsi') {
      if (barcodeController.value.text.isNotEmpty) {
        if (nameController.value.text.isNotEmpty) {
          golds = golds.where((gold) {
            return gold.barcodeText.contains(barcodeController.value.text) &&
                gold.name.contains(nameController.value.text);
          }).toList();
        } else {
          golds = golds.where((gold) {
            return gold.barcodeText.contains(barcodeController.value.text);
          }).toList();
        }
      }
    } else {
      if (barcodeController.value.text.isNotEmpty) {
        if (nameController.value.text.isNotEmpty) {
          golds = golds.where((gold) {
            return gold.barcodeText.contains(barcodeController.value.text) &&
                gold.name.contains(nameController.value.text) &&
                gold.carat == int.parse(dropdownValue.value.split(' ')[0]);
          }).toList();
        } else {
          golds = golds.where((gold) {
            return gold.barcodeText.contains(barcodeController.value.text) &&
                gold.carat == int.parse(dropdownValue.value.split(' ')[0]);
          }).toList();
        }
      }
    }
    for (var gold in golds) {
      dataRows.add(
        DataRow(
          onSelectChanged: (value) {
            Get.toNamed(
              RouteName.gold.stringDefinition,
              arguments: gold.toJson(),
            );
          },
          cells: [
            DataCell(Text(gold.barcodeText)),
            DataCell(Text(gold.name)),
            DataCell(Text('${gold.carat} Ayar')),
            DataCell(Text('${gold.gram} gr')),
          ],
        ),
      );
    }
  }

  void changeDropdownValue(dynamic value) {
    dropdownValue.value = value.toString();
  }

  void clear() {
    dataRows.clear();
    barcodeController.clear();
    nameController.clear();
    dropdownValue.value = 'Hepsi';
  }
}
