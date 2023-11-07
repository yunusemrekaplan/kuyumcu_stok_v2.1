import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../theme/theme_controller.dart';
import '../widget/form_row/form_row.dart';
import '../widget/my_app_bar.dart';
import '../widget/my_drawer/my_drawer.dart';
import 'constant.dart';
import 'sale_controller.dart';

class SaleScreen extends StatelessWidget {
  SaleScreen({super.key});

  final _saleController = Get.put(SaleController());
  final _themeController = Get.find<ThemeController>();

  final inputFormatDouble =
      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'));

  final inputFormatOnlyDigits =
      FilteringTextInputFormatter.allow(RegExp(r'\d'));

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _saleController,
      builder: (_) => buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(appBarTitle),
      body: FutureBuilder(
        future: _saleController.init(),
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

  Row buildBody(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: leftSideFlex,
          child: buildLeftSide(context),
        ),
        Expanded(
          flex: rightSideFlex,
          child: buildRightSide(context),
        ),
      ],
    );
  }

  Column buildLeftSide(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: leftSideRowsFlex,
          child: buildFirstRow(),
        ),
        Expanded(
          flex: leftSideRowsFlex,
          child: buildSecondRow(),
        ),
        Expanded(
          flex: leftSideRowsFlex,
          child: buildThirdRow(),
        ),
      ],
    );
  }

  Padding buildFirstRow() {
    return Padding(
      padding: formRowMargin,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadiusCircular,
          color: _themeController.containerColor.value,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: formRowPadding,
              child: FormRow(
                formRowController:
                    _saleController.barcodeTextEditingController.value,
                hint: barkodFormRowHint,
                inputFormatters: [inputFormatOnlyDigits],
                maxWidth: barkodFormRowMaxWidth,
                onChanged: (value) => _saleController.onSearch(),
              ),
            ),
            Padding(
              padding: formRowPadding,
              child: Row(
                children: [
                  const Text(
                    profitTlText,
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                  FormRow(
                    formRowController:
                        _saleController.profitTlTextEditingController.value,
                    hint: profitTlFormRowHint,
                    inputFormatters: [inputFormatOnlyDigits],
                    maxWidth: profitTlFormRowMaxWidth,
                    onChanged: _saleController.onChangedProfitTl,
                  ),
                ],
              ),
            ),
            Padding(
              padding: formRowPadding,
              child: Row(
                children: [
                  const Text(
                    profitGramText,
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                  FormRow(
                    formRowController:
                        _saleController.profitGramTextEditingController.value,
                    hint: profitGramFormRowHint,
                    maxWidth: profitGramFormRowMaxWidth,
                    inputFormatters: [inputFormatDouble],
                    onChanged: _saleController.onChangedProfitGram,
                    isDecimal: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildSecondRow() {
    return Padding(
      padding: formRowMargin,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadiusCircular,
          color: _themeController.containerColor.value,
        ),
        child: Center(
          child: Obx(
            () => DataTable(
              columns: goldTableColumns,
              rows: goldTableRows,
              headingRowColor: MaterialStateColor.resolveWith(
                (states) => tableHeadingRowColor,
              ),
              border: TableBorder.symmetric(
                inside: const BorderSide(
                  color: tableBorderColor,
                  width: tableBorderWidth,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding buildThirdRow() {
    return Padding(
      padding: formRowMargin,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadiusCircular,
          color: _themeController.containerColor.value,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: formRowPadding,
              child: FormRow(
                formRowController:
                    _saleController.salesPriceTextEditingController.value,
                hint: salesPriceFormRowHint,
                inputFormatters: [inputFormatOnlyDigits],
                maxWidth: salesPriceFormRowMaxWidth,
                onChanged: _saleController.onChangedSalesPrice,
              ),
            ),
            Padding(
              padding: formRowPadding,
              child: FormRow(
                formRowController:
                    _saleController.salesGramTextEditingController.value,
                hint: salesGramFormRowHint,
                inputFormatters: [inputFormatOnlyDigits],
                maxWidth: salesGramFormRowMaxWidth,
                onChanged: null,
                isEnbaled: false,
              ),
            ),
            Padding(
              padding: formRowPadding,
              child: FormRow(
                formRowController:
                    _saleController.pieceTextEditingController.value,
                hint: pieceFormRowHint,
                inputFormatters: [inputFormatOnlyDigits],
                maxWidth: pieceFormRowMaxWidth,
                onChanged: (String value) {},
              ),
            ),
            Padding(
              padding: formRowPadding,
              child: ElevatedButton(
                onPressed: _saleController.onSale,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadiusCircular,
                  ),
                ),
                child: const Text(
                  confirmButton,
                  style: TextStyle(
                    fontSize: buttonFontSize,
                    letterSpacing: letterSpacing,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildRightSide(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => Padding(
            padding: currenciesTablePadding,
            child: DataTable(
              border: TableBorder.symmetric(
                inside: const BorderSide(
                  color: tableBorderColor,
                  width: tableBorderWidth,
                ),
              ),
              headingRowColor: MaterialStateColor.resolveWith(
                (states) => tableHeadingRowColor,
              ),
              columns: currenciesTableColumn,
              rows: currenciesTableRows,
            ),
          ),
        ),
        buildRefreshButton(),
      ],
    );
  }

  Padding buildRefreshButton() {
    return Padding(
      padding: formRowPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: _saleController.onRefresh,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: borderRadiusCircular,
              ),
            ),
            child: const Text(
              refreshButtonText,
              style: TextStyle(
                fontSize: buttonFontSize,
                letterSpacing: letterSpacing,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DataColumn> get currenciesTableColumn {
    return const [
      DataColumn(label: Text('')),
      DataColumn(
        label: Text(
          currencyTableColumn1,
          style: TextStyle(
            fontSize: currencyTableColumnFontSize,
            fontWeight: FontWeight.bold,
            letterSpacing: letterSpacing,
          ),
        ),
      ),
      DataColumn(
        label: Text(
          currencyTableColumn2,
          style: TextStyle(
            fontSize: currencyTableColumnFontSize,
            fontWeight: FontWeight.bold,
            letterSpacing: letterSpacing,
          ),
        ),
      ),
    ];
  }

  List<DataRow> get currenciesTableRows {
    return [
      DataRow(
        cells: [
          const DataCell(
            Text(
              currencyTableCell1,
              style: TextStyle(
                fontSize: currencyTableCellFontSize,
                letterSpacing: letterSpacing,
              ),
            ),
          ),
          DataCell(
            Text(
              _saleController.currencies['fineGoldBuy'].toString(),
              style: const TextStyle(
                fontSize: currencyTableCellFontSize,
              ),
            ),
          ),
          DataCell(
            Text(
              _saleController.currencies['fineGoldSale'].toString(),
              style: const TextStyle(
                fontSize: currencyTableCellFontSize,
              ),
            ),
          ),
        ],
      ),
      DataRow(
        cells: [
          const DataCell(
            Text(
              currencyTableCell2,
              style: TextStyle(
                fontSize: currencyTableCellFontSize,
                letterSpacing: letterSpacing,
              ),
            ),
          ),
          DataCell(
            Text(
              _saleController.currencies['usdBuy'].toString(),
              style: const TextStyle(
                fontSize: currencyTableCellFontSize,
              ),
            ),
          ),
          DataCell(
            Text(
              _saleController.currencies['usdSale'].toString(),
              style: const TextStyle(
                fontSize: currencyTableCellFontSize,
              ),
            ),
          ),
        ],
      ),
      DataRow(
        cells: [
          const DataCell(
            Text(
              currencyTableCell3,
              style: TextStyle(
                fontSize: currencyTableCellFontSize,
                letterSpacing: letterSpacing,
              ),
            ),
          ),
          DataCell(
            Text(
              _saleController.currencies['eurBuy'].toString(),
              style: const TextStyle(
                fontSize: currencyTableCellFontSize,
              ),
            ),
          ),
          DataCell(
            Text(
              _saleController.currencies['eurSale'].toString(),
              style: const TextStyle(
                fontSize: currencyTableCellFontSize,
              ),
            ),
          ),
        ],
      ),
    ];
  }

  List<DataColumn> get goldTableColumns => [
        const DataColumn(
          label: Text(
            nameColumn,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: goldTableColumnFontSize,
            ),
          ),
        ),
        const DataColumn(
          numeric: true,
          label: Text(
            pieceColumn,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: goldTableColumnFontSize,
            ),
          ),
        ),
        const DataColumn(
          numeric: true,
          label: Text(
            gramColumn,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: goldTableColumnFontSize,
            ),
          ),
        ),
        const DataColumn(
          numeric: true,
          label: Text(
            costColumn,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: goldTableColumnFontSize,
            ),
          ),
        ),
        const DataColumn(
          numeric: true,
          label: Text(
            salesGramColumn,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: goldTableColumnFontSize,
            ),
          ),
        ),
      ];

  List<DataRow> get goldTableRows => [
        DataRow(
          cells: [
            DataCell(
              Text(
                _saleController.goldCells[0],
                style: const TextStyle(
                  color: textColor,
                  fontSize: goldTableCellFontSize,
                ),
              ),
            ),
            DataCell(
              Text(
                _saleController.goldCells[1],
                style: const TextStyle(
                  color: textColor,
                  fontSize: goldTableCellFontSize,
                ),
              ),
            ),
            DataCell(
              Text(
                _saleController.goldCells[2],
                style: const TextStyle(
                  color: textColor,
                  fontSize: goldTableCellFontSize,
                ),
              ),
            ),
            DataCell(
              Text(
                _saleController.goldCells[3],
                style: const TextStyle(
                  color: textColor,
                  fontSize: goldTableCellFontSize,
                ),
              ),
            ),
            DataCell(
              Text(
                _saleController.goldCells[4],
                style: const TextStyle(
                  color: textColor,
                  fontSize: goldTableCellFontSize,
                ),
              ),
            ),
          ],
        ),
      ];
}
