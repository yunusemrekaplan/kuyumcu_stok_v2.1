import 'package:kuyumcu_stok_v2/model/abstracts/product_base.dart';
import 'package:kuyumcu_stok_v2/model/enum/carat.dart';
import 'package:kuyumcu_stok_v2/model/enum/product_type.dart';

class JewelryProduct extends ProductBase {
  /// Level of purity of gold. [Carat] enum.
  late final Carat _carat;

  /// Purity of the product.
  late final double _purity;

  /// Scale weight of the product.
  late final double _weight;

  /// Labor cost of the product.
  late final double _laborCost;

  /// Brand of the product. [Brand] class.
  late final String _brandId;

  /// Image URL of the product.
  late final String _imageUrl;

  /// Gram profit to be made from the product.
  late final double _profitGram;

  //////////////////////////////////////////////////////////////////////////////

  Carat get carat => _carat;

  double get purity => _purity;

  double get weight => _weight;

  double get laborCost => _laborCost;

  String get brandId => _brandId;

  String get imageUrl => _imageUrl;

  double get profitGram => _profitGram;

  /// Fine gold in the product.
  double get fineGold => _weight * _purity;

  /// Product cost.
  double get cost => (_laborCost + _purity) * _weight;

  /// Sales price of the product.
  double get salesGrams => cost + _profitGram;

  JewelryProduct({
    required String id,
    required DateTime createdAt,
    required String name,
    required String barcode,
    required Carat carat,
    required double purity,
    required double weight,
    required double laborCost,
    required String brandId,
    required String imageUrl,
    required double profitGram,
    DateTime? updatedAt,
    DateTime? deletedAt,
  })  : _carat = carat,
        _purity = purity,
        _weight = weight,
        _laborCost = laborCost,
        _brandId = brandId,
        _imageUrl = imageUrl,
        _profitGram = profitGram,
        super(
          id: id,
          createdAt: createdAt,
          name: name,
          barcode: barcode,
          type: ProductType.jewelry,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'carat': caratToInt(carat),
        'purity': _purity,
        'weight': _weight,
        'laborCost': _laborCost,
        'brandId': _brandId,
        'imageUrl': _imageUrl,
        'profitGram': _profitGram,
      });
  }

  JewelryProduct.fromMap(Map<String, dynamic> map)
      : _carat = intToCarat(map['carat']),
        _purity = map['purity'],
        _weight = map['weight'],
        _laborCost = map['laborCost'],
        _brandId = map['brandId'],
        _imageUrl = map['imageUrl'],
        _profitGram = map['profitGram'],
        super.fromMap(map);
}
