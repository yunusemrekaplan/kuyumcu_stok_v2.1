import '../carat.dart';

extension ToPurityRate on Carat {
  double get purityRateDefinition {
    switch (this) {
      case Carat.twentyFour:
        return 0.995;
      case Carat.twentyTwo:
        return 0.916;
      case Carat.eighteen:
        return 0.750;
      case Carat.fourteen:
        return 0.585;
      case Carat.ten:
        return 0.417;
      case Carat.eight:
        return 0.333;
    }
  }
}

extension ToInt on Carat {
  int get intDefinition {
    switch (this) {
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
}

extension ToCarat on int {
  Carat? get caratDefinition {
    switch (this) {
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
        return null;
    }
  }
}
