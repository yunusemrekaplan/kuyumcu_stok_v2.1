import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../model/data/sale.dart';
import '../../model/enum/my_route.dart';
import '../theme/theme_controller.dart';
import '../widget/date_picker_row/date_picker_row.dart';
import '../widget/my_app_bar.dart';
import '../widget/my_drawer/my_drawer.dart';
import '../../model/extension/extension_route_name.dart';
import 'constant.dart';
import 'sales_controller.dart';

class SalesScreen extends StatelessWidget {
  SalesScreen({super.key});
  final _salesController = Get.find<SalesController>();
  final _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _salesController,
      builder: (_) => buildScaffold(context),
      id: RouteName.sales,
      initState: (_) => () {
        initializeDateFormatting('tr_TR', null);
      },
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('Satışlar'),
      body: FutureBuilder(
        future: _salesController.init(),
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
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        buildDateRow(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Expanded(child: buildSalesTable()),
      ],
    );
  }

  Row buildDateRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          width: 10,
        ),
        Padding(
          padding: datePickerRowPadding,
          child: DatePickerRow(
            label: 'Başlangıç Tarihi:',
            selectedTime: _salesController.selectedStartTime,
            dateController: _salesController.startDateController.value,
            isSales: true,
          ),
        ),
        Padding(
          padding: datePickerRowPadding,
          child: DatePickerRow(
            label: 'Bitiş Tarihi:',
            selectedTime: _salesController.selectedEndTime,
            dateController: _salesController.endDateController.value,
            isSales: true,
          ),
        ),
        Padding(
          padding: datePickerRowPadding,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius,
              ),
            ),
            onPressed: _salesController.onTimeFilter,
            child: const Text(
              'Tarihi Onayla',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Row(
          children: [
            Text(
              'Toplam Kar (TL): ${NumberFormat(',###,###.#', 'en_US').format(
                _salesController.totalProfitTL,
              )} TL',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 20),
            Text(
              'Toplam Kar (Gr): ${NumberFormat.decimalPattern('en_US').format(
                _salesController.totalProfitGram,
              )} Gr',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ],
    );
  }

  Row buildSalesTable() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Obx(
              () => Container(
                decoration: BoxDecoration(
                  color: _themeController.canvasColor.value,
                  borderRadius: borderRadius,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    showCheckboxColumn: false,
                    columns: buildColumns(),
                    rows: buildRows(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<DataColumn> buildColumns() {
    return [
      const DataColumn(label: Text('Tarihi')),
      const DataColumn(label: Text('İsim')),
      const DataColumn(label: Text('Satılan Adet'), numeric: true),
      const DataColumn(label: Text('Kar (TL)'), numeric: true),
      const DataColumn(label: Text('Kar (Gram)'), numeric: true),
    ];
  }

  RxList<DataRow> buildRows() {
    return _salesController.sales
        .map(
          (e) => DataRow(
            cells: buildCells(e),
            onSelectChanged: (selected) {
              Get.toNamed(
                RouteName.gold.stringDefinition,
                arguments: e.product,
              );
            },
          ),
        )
        .toList()
        .obs;
  }

  List<DataCell> buildCells(Sale sale) {
    String name = sale.product['name'].length > 26
        ? '${sale.product['name'].substring(0, 26)}...'
        : sale.product['name'];
    return [
      DataCell(
        Text(
          sale.soldDate.toString().substring(0, 16),
          style: const TextStyle(
            fontSize: 22,
            letterSpacing: 1.5,
          ),
        ),
      ),
      DataCell(Text(
        name,
        style: const TextStyle(
          fontSize: 22,
          letterSpacing: 1.5,
        ),
      )),
      DataCell(Text(sale.piece.toString())),
      DataCell(Text(sale.earnedProfitTL.toStringAsFixed(0))),
      DataCell(Text(sale.earnedProfitGram.toStringAsFixed(2))),
    ];
  }
}
