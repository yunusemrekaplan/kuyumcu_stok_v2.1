import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kuyumcu_stok_v2/util/dimensions.dart';

import '../../model/enum/my_route.dart';
import '../../theme/theme_controller.dart';
import '../widget/my_app_bar.dart';
import '../widget/my_drawer/my_drawer.dart';
import 'constant.dart';
import 'data_source.dart';
import 'inventory_controller.dart';

class InventoryScreen extends StatelessWidget {
  InventoryScreen({super.key});
  final _inventoryController = Get.put(InventoryController());
  final _themeController = Get.find<ThemeController>();
  final _data = DataSource();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _inventoryController,
      builder: (_) => buildScaffold(),
      id: RouteName.inventory,
    );
  }

  Scaffold buildScaffold() {
    return Scaffold(
      appBar: myAppBar('Envanter'),
      body: FutureBuilder(
        future: _inventoryController.init(),
        builder: builder,
      ),
      drawer: const MyDrawer(),
    );
  }

  Widget builder(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      return buildBody(context);
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Column buildBody(BuildContext context) {
    return Column(
      children: [
        buildDataTableRow(context),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Toplam Has:  ${getFormattedNumber(_inventoryController.totalGold)} Gr',
                  style: const TextStyle(fontSize: Dimension.fontSizeLarge),
                ),
                Text(
                  '24 Ayar:  ${getFormattedNumber(_inventoryController.totalNumberOfTwentyFour)} Adet',
                  style: const TextStyle(fontSize: Dimension.fontSizeLarge),
                ),
                Text(
                  '22 Ayar:  ${getFormattedNumber(_inventoryController.totalNumberOfTwentyTwo)} Adet',
                  style: const TextStyle(fontSize: Dimension.fontSizeLarge),
                ),
                Text(
                  '18 Ayar:  ${getFormattedNumber(_inventoryController.totalNumberOfEighteen)} Adet',
                  style: const TextStyle(fontSize: Dimension.fontSizeLarge),
                ),
                Text(
                  '14 Ayar:  ${getFormattedNumber(_inventoryController.totalNumberOfFourteen)} Adet',
                  style: const TextStyle(fontSize: Dimension.fontSizeLarge),
                ),
                Text(
                  '10 Ayar:  ${getFormattedNumber(_inventoryController.totalNumberOfTen)} Adet',
                  style: const TextStyle(fontSize: Dimension.fontSizeLarge),
                ),
                Text(
                  '8 Ayar:  ${getFormattedNumber(_inventoryController.totalNumberOfEight)} Adet',
                  style: const TextStyle(fontSize: Dimension.fontSizeLarge),
                ),
                SizedBox(width: 25),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String getFormattedNumber(double number) {
    return NumberFormat(',###,###', 'en_US').format(number);
  }

  Row buildDataTableRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: tablePadding,
            child: buildDataTableContainer(context),
          ),
        ),
      ],
    );
  }

  SingleChildScrollView buildDataTableContainer(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Theme(
          data: Theme.of(context).copyWith(
            cardColor: _themeController.canvasColor.value,
            dividerColor: Colors.white38,
            textTheme: const TextTheme(
              bodySmall: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          child: buildDataTable(context),
        ),
      ),
    );
  }

  PaginatedDataTable buildDataTable(BuildContext context) {
    return PaginatedDataTable(
      source: _data,
      columns: buildColumns(context),
      columnSpacing: columnSpacing,
      showCheckboxColumn: showCheckboxColumn,
      rowsPerPage: (MediaQuery.of(context).size.height - 100) ~/ 60,
      dataRowMinHeight: 45,
      dataRowMaxHeight: 45,
      showFirstLastButtons: true,
      arrowHeadColor: Colors.white,
    );
  }

  List<DataColumn> buildColumns(BuildContext context) {
    return [
      const DataColumn(numeric: false, label: Text('Barkod')),
      //onSort: (columnIndex, ascending) => _sortData(columnIndex, ascending),
      const DataColumn(numeric: true, label: Text('Adet')),
      //onSort: (columnIndex, ascending) => _sortData(columnIndex, ascending),
      const DataColumn(numeric: false, label: Text('İsim')),
      //onSort: (columnIndex, ascending) => _sortData(columnIndex, ascending),
      const DataColumn(numeric: true, label: Text('Ayar')),
      //onSort: (columnIndex, ascending) => _sortData(columnIndex, ascending),
      const DataColumn(numeric: true, label: Text('İşçilik')),
      //onSort: (columnIndex, ascending) => _sortData(columnIndex, ascending),
      const DataColumn(numeric: true, label: Text('Gram')),
      //onSort: (columnIndex, ascending) => _sortData(columnIndex, ascending),
      const DataColumn(numeric: true, label: Text('Maliyet')),
      //onSort: (columnIndex, ascending) => _sortData(columnIndex, ascending),
      const DataColumn(numeric: true, label: Text('S. Gramı')),
      //onSort: (columnIndex, ascending) => _sortData(columnIndex, ascending),
      //buildActionsDataColumn(context),
      const DataColumn(label: Text('')),
    ];
  }
}
