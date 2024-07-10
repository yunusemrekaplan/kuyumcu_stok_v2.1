import 'package:kuyumcu_stok_v2/model/data/abstracts/abstract_db_base.dart';

/// Abstract class for product transaction.
abstract class ProductTransaction extends AbstractDbBase {
  /// Product ID.
  late final String _productId;

  /// Date and time of the transaction.
  late final DateTime _transactionDate;

  /// Type of the transaction.
  late final String _transactionType;

  /// Personnel ID.
  late final String _personnelId;

  /// Fine gold value.
  late final double _fineGoldValue;

  String get productId => _productId;

  DateTime get transactionDate => _transactionDate;

  String get transactionType => _transactionType;

  String get personnelId => _personnelId;

  double get fineGoldValue => _fineGoldValue;

  ProductTransaction({
    required String id,
    required String productId,
    required DateTime transactionDate,
    required String transactionType,
    required String personnelId,
    required double fineGoldValue,
  })  : _productId = productId,
        _transactionDate = transactionDate,
        _transactionType = transactionType,
        _personnelId = personnelId,
        _fineGoldValue = fineGoldValue,
        super(id: id, createdAt: DateTime.now());

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'productId': _productId,
        'transactionDate': _transactionDate.toIso8601String(),
        'transactionType': _transactionType,
        'personnelId': _personnelId,
        'fineGoldValue': _fineGoldValue,
      });
  }

  ProductTransaction.fromMap(Map<String, dynamic> map)
      : _productId = map['productId'],
        _transactionDate = DateTime.parse(map['transactionDate']),
        _transactionType = map['transactionType'],
        _personnelId = map['personnelId'],
        _fineGoldValue = map['fineGoldValue'],
        super.fromMap(map);
}
