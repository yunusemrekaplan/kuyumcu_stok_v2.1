import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kuyumcu_stok_v2/model/data/entry.dart';
import 'package:kuyumcu_stok_v2/model/enum/app_route.dart';
import 'package:kuyumcu_stok_v2/theme/theme_controller.dart';
import 'package:kuyumcu_stok_v2/view/entries/constant.dart';
import 'package:kuyumcu_stok_v2/view/entries/entries_controller.dart';
import 'package:kuyumcu_stok_v2/view/widget/date_picker_row/date_picker_row.dart';
import 'package:kuyumcu_stok_v2/view/widget/my_app_bar.dart';
import 'package:kuyumcu_stok_v2/view/widget/my_drawer/my_drawer.dart';

class EntriesScreen extends StatelessWidget {
  EntriesScreen({super.key});
  final _entriesController = Get.put(EntriesController());
  final _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _entriesController,
      builder: (_) => buildScaffold(context),
      id: AppRoute.entries,
      initState: (_) => () {
        initializeDateFormatting('tr_TR', null);
      },
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('Girişler'),
      body: FutureBuilder(
        future: _entriesController.init(),
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
        Expanded(child: buildEntriesTable()),
      ],
    );
  }

  Row buildDateRow() {
    return Row(
      children: [
        Padding(
          padding: datePickerRowPadding,
          child: DatePickerRow(
            label: 'Başlangıç Tarihi:',
            selectedTime: _entriesController.selectedStartTime,
            dateController: _entriesController.startDateController.value,
            onDateChanged: (state, selectedTime) {
              state
                  ? _entriesController.selectedEndTime = selectedTime
                  : _entriesController.selectedStartTime = selectedTime;
            },
          ),
        ),
        Padding(
          padding: datePickerRowPadding,
          child: DatePickerRow(
            label: 'Bitiş Tarihi:',
            selectedTime: _entriesController.selectedEndTime,
            dateController: _entriesController.endDateController.value,
            onDateChanged: (state, selectedTime) {
              state
                  ? _entriesController.selectedEndTime = selectedTime
                  : _entriesController.selectedStartTime = selectedTime;
            },
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
            onPressed: _entriesController.onTimeFilter,
            child: const Text(
              'Tarihi Onayla',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildEntriesTable() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: _themeController.canvasColor.value,
                borderRadius: borderRadius,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Obx(
                  () => DataTable(
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
      const DataColumn(label: Text('Giriş Tarihi')),
      const DataColumn(label: Text('İsim')),
      const DataColumn(label: Text('Girilen Adet'), numeric: true),
    ];
  }

  RxList<DataRow> buildRows() {
    return _entriesController.entries
        .map(
          (e) => DataRow(
            cells: buildCells(e),
            onSelectChanged: (selected) {},
          ),
        )
        .toList()
        .obs;
  }

  List<DataCell> buildCells(Entry entry) {
    String name = entry.product['name'].length > 26
        ? '${entry.product['name'].substring(0, 26)}...'
        : entry.product['name'];
    return [
      DataCell(
        Text(
          entry.enteredDate.toString().substring(0, 16),
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
      DataCell(Text(entry.piece.toString())),
    ];
  }
}
