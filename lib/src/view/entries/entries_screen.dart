import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/enum/my_route.dart';
import 'entries_controller.dart';

class EntriesScreen extends StatelessWidget {
  EntriesScreen({super.key});
  final _entriesController = Get.put(EntriesController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _entriesController,
      builder: (_) => buildScaffold(),
      id: MyRoute.entries,
    );
  }
}
