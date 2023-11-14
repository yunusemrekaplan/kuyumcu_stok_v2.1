import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';

import 'src/controller/data/db_helper.dart';
import 'src/model/extension/extension_route_name.dart';
import 'src/model/enum/my_route.dart';
import 'src/view/add/add_screen.dart';
import 'src/view/calculator/calculator_screen.dart';
import 'src/view/entries/entries_controller.dart';
import 'src/view/entries/entries_screen.dart';
import 'src/view/information/gold_screen.dart';
import 'src/view/inventory/inventory_screen.dart';
import 'src/view/sale/sale_screen.dart';
import 'src/view/sales/sales_controller.dart';
import 'src/view/sales/sales_screen.dart';
import 'src/view/search/search_screen.dart';
import 'src/view/theme/theme_controller.dart';
import 'src/view/theme/theme_first.dart';
import 'src/view/theme/theme_sec.dart';
import 'src/window_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  final dbHelper = DbHelper();
  await dbHelper.openDb();
  initializeDateFormatting('tr_TR', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _themeController = Get.put(ThemeController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteName.inventory.stringDefinition,
      getPages: [
        GetPage(
          name: RouteName.inventory.stringDefinition,
          page: () => InventoryScreen(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RouteName.gold.stringDefinition,
          page: () => GoldScreen(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RouteName.search.stringDefinition,
          page: () => SearchScreen(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RouteName.calculator.stringDefinition,
          page: () => CalculatorScreen(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RouteName.sale.stringDefinition,
          page: () => SaleScreen(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RouteName.addGold.stringDefinition,
          page: () => AddGoldScreen(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RouteName.sales.stringDefinition,
          page: () => SalesScreen(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: RouteName.entries.stringDefinition,
          page: () => EntriesScreen(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
      ],
      themeMode: ThemeMode.light,
      theme: themeFirst,
      darkTheme: themeSec,
    );
  }
}
