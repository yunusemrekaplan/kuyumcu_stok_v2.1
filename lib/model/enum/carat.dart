/// Level of purity of gold.
enum Carat {
  /// 24 carat gold.
  twentyFour,

  /// 22 carat gold.
  twentyTwo,

  /// 18 carat gold.
  eighteen,

  /// 14 carat gold.
  fourteen,

  /// 10 carat gold.
  ten,

  /// 8 carat gold.
  eight,
}

/// Converts [int] to [Carat] enum.
Carat intToCarat(int carat) {
  switch (carat) {
    case 24:
      return Carat.twentyFour;
    case 22:
      return Carat.twentyTwo;
    case 18:
      return Carat.eighteen;
    case 14:
      return Carat.fourteen;
    case 10:
      return Carat.ten;
    case 8:
      return Carat.eight;
    default:
      throw ArgumentError('Invalid carat value: $carat');
  }
}

/// Converts [Carat] enum to [int].
int caratToInt(Carat carat) {
  switch (carat) {
    case Carat.twentyFour:
      return 24;
    case Carat.twentyTwo:
      return 22;
    case Carat.eighteen:
      return 18;
    case Carat.fourteen:
      return 14;
    case Carat.ten:
      return 10;
    case Carat.eight:
      return 8;
  }
}

/// Converts [Carat] enum to purity rate.
double caratToPurity(Carat carat) {
  switch (carat) {
    case Carat.twentyFour:
      return 0.995;
    case Carat.twentyTwo:
      return 0.916;
    case Carat.eighteen:
      return 0.750;
    case Carat.fourteen:
      return 0.585;
    case Carat.ten:
      return 0.416;
    case Carat.eight:
      return 0.333;
  }
}
