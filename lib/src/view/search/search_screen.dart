import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/theme_controller.dart';
import '../widget/my_app_bar.dart';
import '../widget/my_drawer/my_drawer.dart';
import 'constant.dart';
import 'search_screen_controller.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final _searchController = SearchScreenController();
  final _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _searchController,
      builder: (_) => buildScfaold(context),
    );
  }

  Scaffold buildScfaold(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('Arama'),
      body: FutureBuilder(
        future: _searchController.init(),
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

  Widget buildBody(BuildContext context) {
    return Center(
      child: Obx(
        () => Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: _themeController.canvasColor.value,
            borderRadius: const BorderRadius.all(Radius.circular(25)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(width: 10),
                  Container(
                    width: 240,
                    decoration: const BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        const Icon(Icons.search, color: Colors.white),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            Container(
                              width: 150,
                              decoration: const BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                              child: TextField(
                                controller: _searchController.barcodeController,
                                decoration: InputDecoration(
                                  hintText: 'Barkod Ara',
                                  hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.7)),
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () =>
                              _searchController.barcodeController.clear(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 240,
                    decoration: const BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        const Icon(Icons.search, color: Colors.white),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            Container(
                              width: 150,
                              decoration: const BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                              child: TextField(
                                controller: _searchController.nameController,
                                decoration: InputDecoration(
                                  hintText: 'İsim Ara',
                                  hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.7)),
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () =>
                              _searchController.nameController.clear(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 150,
                    child: Obx(
                      () => DropdownButtonFormField(
                        value: _searchController.dropdownValue.value,
                        icon: dropDownIcon,
                        iconSize: dropdownIconSize,
                        isExpanded: dropdownIsExpanded,
                        dropdownColor: dropdownColor,
                        items: buildDropDownMenuItemList(),
                        onChanged: _searchController.changeDropdownValue,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _searchController.onSearch,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: borderRadius,
                      ),
                    ),
                    child: const Text(
                      'Onayla',
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _searchController.clear,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: borderRadius,
                      ),
                    ),
                    child: const Text(
                      'Temizle',
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                alignment: Alignment.topCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Obx(
                            () => DataTable(
                              showCheckboxColumn: false,
                              columns: const [
                                DataColumn(label: Text('Barkod')),
                                DataColumn(label: Text('İsim')),
                                DataColumn(label: Text('Ayar')),
                                DataColumn(label: Text('Gram')),
                              ],
                              rows: _searchController.dataRows.toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem> buildDropDownMenuItemList() {
    return [
      'Hepsi',
      '8 Ayar',
      '10 Ayar',
      '14 Ayar',
      '18 Ayar',
      '22 Ayar',
      '24 Ayar',
    ].map(
      (value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value.toString(), style: dropdownItemTextStyle),
        );
      },
    ).toList();
  }
}
