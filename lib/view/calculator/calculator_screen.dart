import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuyumcu_stok_v2/model/enum/my_route.dart';
import 'package:kuyumcu_stok_v2/model/extension/extension_route_name.dart';
import 'package:kuyumcu_stok_v2/view/widget/my_app_bar.dart';
import 'package:kuyumcu_stok_v2/view/widget/my_drawer/my_drawer.dart';

import '../../theme/theme_controller.dart';
import 'calculator_controller.dart';
import 'constant.dart';

class CalculatorScreen extends StatelessWidget {
  CalculatorScreen({super.key});
  final _calculatorController = Get.put(CalculatorController());
  final _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _calculatorController,
      builder: (_) => buildScaffold(context),
      id: RouteName.calculator.stringDefinition,
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('Has Hesaplama'),
      drawer: const MyDrawer(),
      body: Center(
        child: Obx(
          () => Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: _themeController.canvasColor.value,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: 420,
                  height: 75,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _calculatorController.caratController.value,
                        enabled: false,
                        decoration: buildInputDecoration('Ayar'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 200,
                        height: 75,
                        child: DropdownButton(
                          icon: dropDownIcon,
                          iconSize: dropdownIconSize,
                          isExpanded: dropdownIsExpanded,
                          dropdownColor: dropdownColor,
                          hint: const Text(
                            'Ayar Seçiniz',
                            style: dropdownHintTextStyle,
                          ),
                          style: dropdownButtonTextStyle,
                          padding: dropdownPadding,
                          underline: Container(
                            height: dropdownButtonUnderlineHeight,
                            color: underLineColor,
                          ),
                          items: buildDropDownMenuItemList(),
                          onChanged: (value) => _calculatorController
                              .onChangedDropDownButton(value),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 420,
                  child: TextFormField(
                    controller:
                        _calculatorController.purityRateController.value,
                    decoration: buildInputDecoration('Saflık'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    onChanged: _calculatorController.onChangedTextFormField,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 420,
                  child: TextFormField(
                    controller: _calculatorController.laborCostController.value,
                    decoration: buildInputDecoration('İşçilik'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    onChanged: _calculatorController.onChangedTextFormField,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 420,
                  child: TextFormField(
                    controller: _calculatorController.gramController.value,
                    decoration: buildInputDecoration('Gram'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    onChanged: _calculatorController.onChangedTextFormField,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 420,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _calculatorController.costController.value,
                        decoration: buildInputDecoration('Maliyet'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        onChanged: _calculatorController.onChangedTextFormField,
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        'Adet İşçilik',
                        style: TextStyle(fontSize: 28),
                      ),
                      IconButton(
                        icon: _calculatorController.icon.value,
                        iconSize: 50,
                        onPressed: _calculatorController.changeIcon,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      border: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      disabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      constraints: const BoxConstraints(
        maxWidth: 200,
        minHeight: 50,
      ),
    );
  }

  List<DropdownMenuItem> buildDropDownMenuItemList() {
    return carats.map(
      (value) {
        return DropdownMenuItem(
          value: value.split(' ')[0],
          child: Text(value.toString(), style: dropdownItemTextStyle),
        );
      },
    ).toList();
  }
}
