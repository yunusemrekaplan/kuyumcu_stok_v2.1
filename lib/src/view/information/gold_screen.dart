import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuyumcu_stok_v2/src/view/widget/my_app_bar.dart';

import '../../model/enum/my_route.dart';
import '../theme/theme_controller.dart';
import 'gold_controller.dart';

class GoldScreen extends StatelessWidget {
  GoldScreen({super.key});

  final _goldController = Get.put(GoldController(gold: Get.arguments));
  final _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _goldController,
      builder: (_) => buildScaffold(),
      id: RouteName.gold,
    );
  }

  Scaffold buildScaffold() {
    return Scaffold(
      appBar: myAppBar('Gold'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(
              () => Container(
                decoration: BoxDecoration(
                  color: _themeController.canvasColor.value,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: DataTable(
                        columns: buildColumns,
                        rows: [
                          DataRow(
                            cells: buildCells,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DataColumn> get buildColumns {
    return const <DataColumn>[
      DataColumn(label: Text('Barkod')),
      DataColumn(label: Text('İsim')),
      DataColumn(label: Text('Ayar')),
      DataColumn(label: Text('Gram')),
      DataColumn(label: Text('Saflık')),
      DataColumn(label: Text('İşçilik')),
      DataColumn(label: Text('Maliyet')),
      DataColumn(label: Text('Satış Gramı')),
      DataColumn(label: Text('')),
    ];
  }

  List<DataCell> get buildCells {
    return <DataCell>[
      DataCell(Text(_goldController.gold['barcodeText'])),
      DataCell(Text(_goldController.gold['name'])),
      DataCell(Text(_goldController.gold['carat'].toString())),
      DataCell(Text(_goldController.gold['gram'].toString())),
      DataCell(Text(_goldController.gold['purityRate'].toString())),
      DataCell(Text(_goldController.gold['laborCost'].toString())),
      DataCell(Text(_goldController.gold['cost'].toString())),
      DataCell(Text(_goldController.gold['salesGrams'].toString())),
      buildActionsDataCell(),
    ];
  }

  DataCell buildActionsDataCell() {
    return DataCell(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: _goldController.printGold,
            icon: const Icon(Icons.print),
            color: Colors.white70,
            iconSize: 30,
          ),
        ],
      ),
    );
  }
}
