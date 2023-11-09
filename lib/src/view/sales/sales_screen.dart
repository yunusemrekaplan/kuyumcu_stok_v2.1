import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../model/enum/my_route.dart';
import '../theme/theme_controller.dart';
import '../widget/date_picker_row/date_picker_row.dart';
import '../widget/my_app_bar.dart';
import '../widget/my_drawer/my_drawer.dart';
import 'constant.dart';
import 'sales_controller.dart';

class SalesScreen extends StatelessWidget {
  SalesScreen({super.key});

  final _salesController = Get.put(SalesController());
  final _themeController = Get.find<ThemeController>();

  DateTime endTime = DateTime.now();
  DateTime startTime = DateTime.now().subtract(const Duration(days: 360));

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _salesController,
      builder: (_) => buildScaffold(),
      id: MyRoute.sales,
      initState: (_) => () {
        initializeDateFormatting('tr_TR', null);
      },
    );
  }

  Scaffold buildScaffold() {
    return Scaffold(
      appBar: myAppBar('Satışlar'),
      body: FutureBuilder(
        future: _salesController.getSales(),
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
        buildDateRow(),
        //Expanded(child: buildDataTable(context)),
      ],
    );
  }

  Row buildDateRow() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: DatePickerRow(
            label: 'Başlangıç Tarihi:',
            startTime: startTime,
            endTime: endTime,
            selectedTime: endTime,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: DatePickerRow(
            label: 'Bitiş Tarihi:',
            startTime: startTime,
            endTime: endTime,
            selectedTime: endTime,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius,
              ),
            ),
            child: const Text(
              'Tarihi Onayla',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            onPressed: () {
              /*
              setState(() {
                startTime = startDatePickerRow.initialTime;
                endTime = endDatePickerRow.initialTime;
                sales;
              });
              buildTotals();
              */
            },
          ),
        ),
      ],
    );
  }

  /*
  Container buildDataTable(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _themeController.canvasColor.value,
        borderRadius: borderRadius,
      ),
      child: SingleChildScrollView(
        child: DataTable(
          columns: buildDataColumns(),
          rows: buildDataRow(),
        ),
      ),
    );
  }

  List<DataColumn> buildDataColumns() {
    return [
      const DataColumn(label: Text('Tarihh')),
      const DataColumn(label: Text('İsim')),
      const DataColumn(label: Text('Satılan Adet')),
      const DataColumn(label: Text('Kar (TL)')),
      const DataColumn(label: Text('Kar (Gram)')),
    ];
  }
  */
}
