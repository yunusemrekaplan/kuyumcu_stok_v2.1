import 'package:kuyumcu_stok_v2/model/data/abstracts/abstract_db_base.dart';
import 'package:kuyumcu_stok_v2/model/enum/product_type.dart';

/// Base class for products.
abstract class ProductBase extends AbstractDbBase {
  /// Name of the product.
  final String _name;

  /// Barcode of the product.
  late final String _barcode;

  /// Type of the product.
  late final ProductType _type;

  //////////////////////////////////////////////////////////////////////////////

  String get name => _name;

  String get barcode => _barcode;

  ProductType get type => _type;

  ProductBase({
    required String id,
    required DateTime createdAt,
    required String name,
    required String barcode,
    required ProductType type,
    DateTime? updatedAt,
    DateTime? deletedAt,
  })  : _name = name,
        _barcode = barcode,
        _type = type,
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
        'barcode': _barcode,
        'type': productTypeToString(_type),
      });
  }

  ProductBase.fromMap(Map<String, dynamic> map)
      : _name = map['name'],
        _barcode = map['barcode'],
        _type = stringToProductType(map['type']),
        super.fromMap(map);
}
