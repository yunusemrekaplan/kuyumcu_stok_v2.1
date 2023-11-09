import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/enum/my_route.dart';
import '../theme/theme_controller.dart';
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
      id: MyRoute.inventory,
    );
  }

  Scaffold buildScaffold() {
    return Scaffold(
      appBar: myAppBar('Envanter'),
      body: FutureBuilder(
        future: _inventoryController.getGolds(),
        builder: builder,
      ),
      drawer: const MyDrawer(),
    );
  }

  Widget builder(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      return buildDataTableRow(context);
    } else {
      return const Center(child: CircularProgressIndicator());
    }
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
      rowsPerPage: MediaQuery.of(context).size.height ~/ 60,
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

  /*
  DataColumn buildActionsDataColumn(BuildContext context) {
    return DataColumn(
      label: Stack(
        children: [
          buildTextFormField(context),
          buildSearchIcon(),
        ],
      ),
    );
  }

  
  Container buildTextFormField(BuildContext context) {
    return Container(
      color: searchBoxColor,
      child: TextFormField(
        focusNode: _inventoryController.searchFocusNode,
        controller: _inventoryController.searchController,
        style: searchBoxTextStyle,
        decoration: InputDecoration(
          contentPadding: searchBoxContentPadding,
          constraints: BoxConstraints(
            maxHeight: searchBoxMaxHeight,
            minWidth: searchBoxMinWidth,
            maxWidth: MediaQuery.of(context).size.width * 0.167,
          ),
        ),
        cursorColor: cursorColor,
        onChanged: _inventoryController.onSearch,
        //onFieldSubmitted: _inventoryController.onSearch,
      ),
    );
  }

  Padding buildSearchIcon() {
    return Padding(
      padding: searchIconPadding,
      child: Obx(
        () => Icon(
          searchIcon,
          color: _inventoryController.searchIconColor.value,
        ),
      ),
    );
  }

  */
}
