import 'package:kuyumcu_stok_v2/model/abstracts/product_process.dart';

/// A class that represents a product sales process.
class ProductSalesProcess extends ProductProcess {
  /// The cost of the fine gold used in the process.
  late final double _fineGoldCost;

  /// The profit of the fine gold used in the process.
  late final double _fineGoldProfit;

  /// The payment type of the process.
  late final PaymentType _paymentType;

  double get fineGoldCost => _fineGoldCost;
  double get fineGoldProfit => _fineGoldProfit;
  PaymentType get paymentType => _paymentType;

  ProductSalesProcess({
    required String id,
    required String productId,
    required DateTime processDate,
    required String processType,
    required String personnelId,
    required double fineGoldValue,
    required double fineGoldCost,
    required double fineGoldProfit,
    required PaymentType paymentType,
  })  : _fineGoldCost = fineGoldCost,
        _fineGoldProfit = fineGoldProfit,
        _paymentType = paymentType,
        super(
          id: id,
          productId: productId,
          processDate: processDate,
          processType: processType,
          personnelId: personnelId,
          fineGoldValue: fineGoldValue,
        );

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'fineGoldCost': _fineGoldCost,
        'fineGoldProfit': _fineGoldProfit,
        'paymentType': _paymentType.index,
      });
  }

  ProductSalesProcess.fromMap(Map<String, dynamic> map)
      : _fineGoldCost = map['fineGoldCost'],
        _fineGoldProfit = map['fineGoldProfit'],
        _paymentType = PaymentType.values[map['paymentType']],
        super.fromMap(map);
}

/// An enum that represents the payment type of a product sales process.
enum PaymentType {
  /// The payment type is cash.
  currency,

  /// The payment type is fine gold.
  fineGold,

  /// The payment type is credit card.
  creditCard,

  /// The payment type is bullion.
  bullion,
}
