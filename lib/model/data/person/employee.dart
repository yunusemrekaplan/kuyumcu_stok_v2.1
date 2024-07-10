import 'package:kuyumcu_stok_v2/model/data/abstracts/abstract_db_base.dart';

class Employee extends AbstractDbBase {
  late String name;
  String? surname;
  String? phone;
  String? email;
  String? address;
  late List<String> productSalesIds;
}