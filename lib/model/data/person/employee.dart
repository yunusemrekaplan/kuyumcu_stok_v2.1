import 'package:kuyumcu_stok_v2/model/data/abstracts/abstract_db_base.dart';

class Employee extends AbstractDbBase {
  late String name;
  String? surname;
  String? phone;
  String? email;
  String? address;

  Employee({
    required super.id,
    required super.createdAt,
    required this.name,
    this.surname,
    this.phone,
    this.email,
    this.address,
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
      });
  }

  Employee.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        surname = map['surname'],
        phone = map['phone'],
        email = map['email'],
        address = map['address'],
        super.fromMap(map);
}
