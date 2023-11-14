import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuyumcu_stok_v2/src/model/extension/extension_route_name.dart';

import '../../../model/enum/my_route.dart';
import 'constant.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<StatefulWidget> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.house),
            iconSize: iconSize,
            alignment: Alignment.center,
          ),
          ListTile(
            title: const Text(
              drawerInventory,
              style: TextStyle(color: textColor, fontSize: fontSize),
            ),
            onTap: () {
              Get.offNamed(RouteName.inventory.stringDefinition);
            },
          ),
          ListTile(
            title: const Text(
              drawerSale,
              style: TextStyle(color: textColor, fontSize: fontSize),
            ),
            onTap: () {
              Get.offNamed(RouteName.sale.stringDefinition);
            },
          ),
          ListTile(
            title: const Text(
              drawerAddGold,
              style: TextStyle(color: textColor, fontSize: fontSize),
            ),
            onTap: () {
              Get.offNamed(RouteName.addGold.stringDefinition);
            },
          ),
          ListTile(
            title: const Text(
              drawerSales,
              style: TextStyle(color: textColor, fontSize: fontSize),
            ),
            onTap: () {
              Get.offNamed(RouteName.sales.stringDefinition);
            },
          ),
          ListTile(
            title: const Text(
              drawerEntries,
              style: TextStyle(color: textColor, fontSize: fontSize),
            ),
            onTap: () {
              Get.offNamed(RouteName.entries.stringDefinition);
            },
          ),
        ],
      ),
    );
  }
}
