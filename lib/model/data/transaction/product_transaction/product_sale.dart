import 'package:kuyumcu_stok_v2/model/data/abstracts/product_transaction.dart';
import 'package:kuyumcu_stok_v2/model/enum/payment_type.dart';

/// A class that represents a product sales transaction.
class ProductSale extends ProductTransaction {
  /// The cost of the fine gold used in the transaction.
  late final double fineGoldCost;

  /// The profit of the fine gold used in the transaction.
  late final double fineGoldProfit;

  /// The payment type of the transaction.
  late final PaymentType paymentType;

  String? customerName;

  ProductSale({
    required super.id,
    required super.productId,
    required super.transactionDate,
    required super.transactionType,
    required super.personnelId,
    required super.fineGoldValue,
    required this.fineGoldCost,
    required this.fineGoldProfit,
    required this.paymentType,
    this.customerName,
  });

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'fineGoldCost': fineGoldCost,
        'fineGoldProfit': fineGoldProfit,
        'paymentType': paymentType.index,
        'customerName': customerName,
      });
  }

  ProductSale.fromMap(Map<String, dynamic> map)
      : fineGoldCost = map['fineGoldCost'],
        fineGoldProfit = map['fineGoldProfit'],
        paymentType = PaymentType.values[map['paymentType']],
        customerName = map['customerName'],
        super.fromMap(map);

  @override
  String toString() {
    return 'ProductSale{id: $id, productId: $productId, transactionDate: $transactionDate, transactionType: $transactionType, personnelId: $personnelId, fineGoldValue: $fineGoldValue, fineGoldCost: $fineGoldCost, fineGoldProfit: $fineGoldProfit, paymentType: $paymentType, customerName: $customerName}';
  }
}
