/// ProductType is an enum class that represents the type of the product.
enum ProductType {
  /// Type of gold processed and made into jewelry.
  jewelry,

  /// Type of gold that is in the form of a bar or coin.
  bullion,

  /// Type of gold that is in the form of a scrap.
  scrap,
}

/// Converts the [ProductType] to a string.
String productTypeToString(ProductType type) {
  switch (type) {
    case ProductType.jewelry:
      return 'Jewelry';
    case ProductType.bullion:
      return 'Bullion';
    case ProductType.scrap:
      return 'Scrap';
    default:
      return 'Unknown';
  }
}

/// Converts the string to a [ProductType].
ProductType stringToProductType(String type) {
  switch (type) {
    case 'Jewelry':
      return ProductType.jewelry;
    case 'Bullion':
      return ProductType.bullion;
    case 'Scrap':
      return ProductType.scrap;
    default:
      return ProductType.jewelry;
  }
}

