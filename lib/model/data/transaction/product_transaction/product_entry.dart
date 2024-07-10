import 'package:kuyumcu_stok_v2/model/data/abstracts/product_transaction.dart';

/// A class that represents a product entry transaction.
class ProductEntry extends ProductTransaction {
  /// The ID of the supplier.
  String? supplierId;

  /// The name of the supplier.
  String? supplierName;

  ProductEntry({
    required super.id,
    required super.productId,
    required super.transactionDate,
    required super.transactionType,
    required super.personnelId,
    required super.fineGoldValue,
    this.supplierId,
    this.supplierName,
  });

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'supplierId': supplierId,
        'supplierName': supplierName,
      });
  }

  ProductEntry.fromMap(Map<String, dynamic> map)
      : supplierId = map['supplierId'],
        supplierName = map['supplierName'],
        super.fromMap(map);
}
