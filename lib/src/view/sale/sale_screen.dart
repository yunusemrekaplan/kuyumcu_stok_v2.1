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
      FilteringTextInputFormatter.allow(RegExp(r'^\d+,?\d{0,3}'));

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

  buildRightSide(BuildContext context) {
    return Container(
      color: Colors.black,
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: formRowPadding,
              child: FormRow(
                formRowController: _saleController.barcodeTextEditingController,
                hint: barkodFormRowHint,
                inputFormatters: [inputFormatOnlyDigits],
                maxWidth: barkodFormRowMaxWidth,
                onChanged: (String value) {},
              ),
            ),
            Padding(
              padding: formRowPadding,
              child: FormRow(
                formRowController:
                    _saleController.profitTlTextEditingController,
                hint: profitTlFormRowHint,
                inputFormatters: [inputFormatOnlyDigits],
                maxWidth: profitTlFormRowMaxWidth,
                onChanged: (String value) {},
              ),
            ),
            Padding(
              padding: formRowPadding,
              child: FormRow(
                formRowController:
                    _saleController.profitGramTextEditingController,
                hint: profitGramFormRowHint,
                inputFormatters: [inputFormatDouble],
                maxWidth: profitGramFormRowMaxWidth,
                onChanged: (String value) {},
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
        child: DataTable(
          columns: _saleController.tableColumns,
          rows: _saleController.tableRows,
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: formRowPadding,
              child: FormRow(
                formRowController:
                    _saleController.salesPriceTextEditingController,
                hint: salesPriceFormRowHint,
                inputFormatters: [inputFormatOnlyDigits],
                maxWidth: salesPriceFormRowMaxWidth,
                onChanged: (String value) {},
              ),
            ),
            Padding(
              padding: formRowPadding,
              child: FormRow(
                formRowController:
                    _saleController.salesGramTextEditingController,
                hint: salesGramFormRowHint,
                inputFormatters: [inputFormatOnlyDigits],
                maxWidth: salesGramFormRowMaxWidth,
                onChanged: (String value) {},
              ),
            ),
            Padding(
              padding: formRowPadding,
              child: FormRow(
                formRowController: _saleController.pieceTextEditingController,
                hint: pieceFormRowHint,
                inputFormatters: [inputFormatDouble],
                maxWidth: pieceFormRowMaxWidth,
                onChanged: (String value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
