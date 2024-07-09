import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kuyumcu_stok_v2/src/model/data/gold.dart';
import 'package:kuyumcu_stok_v2/src/model/extension/extension_route_name.dart';
import 'package:kuyumcu_stok_v2/src/view/inventory/inventory_controller.dart';

import '../../model/enum/app_route.dart';

class DataSource extends DataTableSource {
  final _inventoryController = Get.find<InventoryController>();
  // A list of people

  // The number of selected rows
  final int _selectedCount = 0;

  // Get the total number of rows
  @override
  int get rowCount => _inventoryController.golds.length;

  // Get whether the row count is approximate
  @override
  bool get isRowCountApproximate => false;

  // Get the number of selected rows
  @override
  int get selectedRowCount => _selectedCount;

  // Get the row at a given index
  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _inventoryController.golds.length) return null;
    return DataRow.byIndex(
      index: index,
      onSelectChanged: (value) {
        Get.toNamed(
          AppRoute.gold.stringDefinition,
          arguments: _inventoryController.golds[index].toJson(),
        );
      },
      cells: buildDataCells(_inventoryController.golds[index], Get.context),
    );
  }

  List<DataCell> buildDataCells(Gold e, BuildContext? context) {
    int len = e.name.length;
    String tripleDot = (len > 28 ? '...' : '');
    String name = e.name.substring(0, (len > 28 ? 28 : len)) + tripleDot;
    return [
      buildBarcodeDataCell(context!, e.barcodeText),
      DataCell(Text(e.piece.toString())),
      DataCell(Text(name)),
      DataCell(Text(e.carat.toString())),
      DataCell(Text(e.laborCost.toStringAsFixed(3))),
      DataCell(Text(e.gram.toStringAsFixed(3))),
      DataCell(Text(e.cost.toStringAsFixed(3))),
      DataCell(Text(e.salesGrams.toStringAsFixed(3))),
      buildActionsDataCell(context, e),
    ];
  }

  DataCell buildBarcodeDataCell(BuildContext context, String cell) {
    return DataCell(
      Text(cell),
      onTap: () {
        Clipboard.setData(ClipboardData(text: cell));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Barkod kopyalandı!'),
            duration: Duration(milliseconds: 500),
          ),
        );
      },
    );
  }

  DataCell buildActionsDataCell(BuildContext context, Gold gold) {
    return DataCell(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () => _inventoryController.printGold(gold),
            icon: const Icon(Icons.print),
            color: Colors.white70,
            iconSize: 30,
          ),
          IconButton(
            onPressed: () => _inventoryController.deleteGold(gold),
            icon: const Icon(Icons.delete),
            color: Colors.red,
            iconSize: 30,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit,
              color: Colors.white.withOpacity(0.2),
            ),
            color: Colors.white70,
            iconSize: 30,
          ),
        ],
      ),
    );
  }
}
