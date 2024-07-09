import 'package:kuyumcu_stok_v2/src/model/abstracts/abstract_base.dart';

class Brand extends AbstractBase {
  late final String _name;

  String get name => _name;

  Brand({
    required String id,
    required DateTime createdAt,
    required String name,
    DateTime? updatedAt,
    DateTime? deletedAt,
  })  : _name = name,
        super(
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'name': _name,
      });
  }

  Brand.fromMap(Map<String, dynamic> map)
      : _name = map['name'],
        super.fromMap(map);
}
