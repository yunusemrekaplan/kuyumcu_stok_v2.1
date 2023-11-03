import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/my_app_bar.dart';
import 'search_screen_controller.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final _searchController = SearchScreenController();

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
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Center(
      child: Text('Arama'),
    );
  }
}
