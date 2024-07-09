import 'package:kuyumcu_stok_v2/model/abstracts/abstract_base.dart';

/// Abstract class for product processes.
abstract class ProductProcess extends AbstractBase {
  /// Product ID.
  late final String _productId;

  /// Date and time of the process.
  late final DateTime _processDate;

  /// Type of the process.
  late final String _processType;

  /// Personnel ID.
  late final String _personnelId;

  /// Fine gold value.
  late final double _fineGoldValue;

  String get productId => _productId;

  DateTime get processDate => _processDate;

  String get processType => _processType;

  String get personnelId => _personnelId;

  double get fineGoldValue => _fineGoldValue;

  ProductProcess({
    required String id,
    required String productId,
    required DateTime processDate,
    required String processType,
    required String personnelId,
    required double fineGoldValue,
  })  : _productId = productId,
        _processDate = processDate,
        _processType = processType,
        _personnelId = personnelId,
        _fineGoldValue = fineGoldValue,
        super(id: id, createdAt: DateTime.now());

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'productId': _productId,
        'processDate': _processDate.toIso8601String(),
        'processType': _processType,
        'personnelId': _personnelId,
        'fineGoldValue': _fineGoldValue,
      });
  }

  ProductProcess.fromMap(Map<String, dynamic> map)
      : _productId = map['productId'],
        _processDate = DateTime.parse(map['processDate']),
        _processType = map['processType'],
        _personnelId = map['personnelId'],
        _fineGoldValue = map['fineGoldValue'],
        super.fromMap(map);
}
