import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/enum/my_route.dart';
import '../theme/theme_controller.dart';
import '../widget/form_row/form_row.dart';
import '../widget/my_app_bar.dart';
import '../widget/my_drawer/my_drawer.dart';
import 'constant.dart';
import 'add_gold_controller.dart';

class AddGoldScreen extends StatelessWidget {
  AddGoldScreen({super.key});

  final _addGoldController = Get.put(AddGoldController());
  final _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _addGoldController,
      builder: (_) => buildScaffold(context),
      id: MyRoute.addGold,
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(appBarTitle),
      body: FutureBuilder(
        future: _addGoldController.init(),
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

  Center buildBody(BuildContext context) {
    return Center(
      child: Obx(
        () => Container(
          width: MediaQuery.of(context).size.width * containerWidth,
          height: MediaQuery.of(context).size.height * containerHeight,
          decoration: BoxDecoration(
            color: _themeController.canvasColor.value,
            borderRadius: borderRadius,
          ),
          child: Center(
            child: buildForm(),
          ),
        ),
      ),
    );
  }

  Form buildForm() {
    return Form(
      key: _addGoldController.formKey.value,
      autovalidateMode: _addGoldController.isAutoValidateMode(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: buildFromChildren,
      ),
    );
  }

  List<Widget> get buildFromChildren {
    return [
      FormRow(
        controller: _addGoldController.barcodeController.value,
        text: barcodeText,
        hintText: barcodeHintText,
        isEnableDropDownButton: false,
        isEnabled: false,
        isInteger: true,
      ),
      const SizedBox(height: paddingBoxHeight),
      FormRow(
        controller: _addGoldController.pieceController.value,
        text: pieceText,
        hintText: pieceHintText,
        isEnableDropDownButton: false,
        isInteger: true,
      ),
      const SizedBox(height: paddingBoxHeight),
      FormRow(
        controller: _addGoldController.nameController.value,
        text: nameText,
        hintText: nameHintText,
        isEnableDropDownButton: true,
        dropdownHintText: nameDropdownHintText,
        dropdownList: _addGoldController.nameList,
      ),
      const SizedBox(height: paddingBoxHeight),
      FormRow(
        controller: _addGoldController.caratController.value,
        text: caratText,
        hintText: caratHintText,
        isInteger: true,
        isEnabled: false,
        isEnableDropDownButton: true,
        dropdownHintText: caratDropdownHintText,
        dropdownList: _addGoldController.caratList,
      ),
      const SizedBox(height: paddingBoxHeight),
      FormRow(
        controller: _addGoldController.purityRateController.value,
        text: purityRateText,
        hintText: purityRateHintText,
        isEnableDropDownButton: false,
        isDecimal: true,
      ),
      FormRow(
        controller: _addGoldController.laborCostController.value,
        text: laborCostText,
        hintText: laborCostHintText,
        isDecimal: true,
      ),
      const SizedBox(height: paddingBoxHeight),
      //buildAddProductButtonBox(),
    ];
  }
}
