import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuyumcu_stok_v2/src/model/enum/extension/extension_my_route.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';

import 'src/controller/data/db_helper.dart';
import 'src/model/enum/my_route.dart';
import 'src/view/inventory/inventory_screen.dart';
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
      initialRoute: MyRoute.search.stringDefinition,
      getPages: [
        GetPage(
            name: MyRoute.inventory.stringDefinition,
            page: () => InventoryScreen()),
        GetPage(
            name: MyRoute.search.stringDefinition, page: () => SearchScreen()),
      ],
      themeMode: ThemeMode.light,
      theme: themeFirst,
      darkTheme: themeSec,
    );
  }
}
