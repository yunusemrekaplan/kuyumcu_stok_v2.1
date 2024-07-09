import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kuyumcu_stok_v2/controller/data/db_helper.dart';
import 'package:kuyumcu_stok_v2/model/enum/app_route.dart';
import 'package:kuyumcu_stok_v2/model/extension/extension_app_route.dart';
import 'package:kuyumcu_stok_v2/theme/theme_controller.dart';
import 'package:kuyumcu_stok_v2/theme/theme_first.dart';
import 'package:kuyumcu_stok_v2/theme/theme_sec.dart';
import 'package:kuyumcu_stok_v2/view/add/add_screen.dart';
import 'package:kuyumcu_stok_v2/view/calculator/calculator_screen.dart';
import 'package:kuyumcu_stok_v2/view/entries/entries_screen.dart';
import 'package:kuyumcu_stok_v2/view/information/gold_screen.dart';
import 'package:kuyumcu_stok_v2/view/inventory/inventory_screen.dart';
import 'package:kuyumcu_stok_v2/view/sale/sale_screen.dart';
import 'package:kuyumcu_stok_v2/view/sales/sales_screen.dart';
import 'package:kuyumcu_stok_v2/view/search/search_screen.dart';
import 'package:kuyumcu_stok_v2/window_options.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';

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

  final themeController = Get.put(ThemeController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.inventory.stringDefinition,
      getPages: [
        GetPage(
          name: AppRoute.inventory.stringDefinition,
          page: () => InventoryScreen(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: AppRoute.gold.stringDefinition,
          page: () => GoldScreen(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: AppRoute.search.stringDefinition,
          page: () => SearchScreen(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: AppRoute.calculator.stringDefinition,
          page: () => CalculatorScreen(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: AppRoute.sale.stringDefinition,
          page: () => SaleScreen(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: AppRoute.addGold.stringDefinition,
          page: () => AddGoldScreen(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: AppRoute.sales.stringDefinition,
          page: () => SalesScreen(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: AppRoute.entries.stringDefinition,
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
