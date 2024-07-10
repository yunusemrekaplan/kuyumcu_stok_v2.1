import 'package:kuyumcu_stok_v2/model/data/abstracts/abstract_db_base.dart';

class Customer extends AbstractDbBase {
  late String name;
  late String surname;
  late String identityNumber;
  String? phone;
  String? email;
  String? address;
  List<String>? productSalesIds;

  Customer({
    required super.id,
    required super.createdAt,
    required this.name,
    required this.surname,
    required this.phone,
    required this.email,
    required this.address,
    this.productSalesIds,
    super.updatedAt,
    super.deletedAt,
  });

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'name': name,
        'surname': surname,
        'phone': phone,
        'email': email,
        'address': address,
        'productSalesIds': productSalesIds,
      });
  }

  Customer.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        surname = map['surname'],
        phone = map['phone'],
        email = map['email'],
        address = map['address'],
        productSalesIds = List<String>.from(map['productSalesIds']),
        super.fromMap(map);
}
