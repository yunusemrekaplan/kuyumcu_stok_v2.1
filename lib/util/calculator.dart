class Calculator {
  static final Calculator _instance = Calculator._internal();

  factory Calculator() {
    return _instance;
  }

  Calculator._internal();

  double calculateCost(double gram, double laborCost, double purityRate) {
    return gram * (laborCost + purityRate);
  }

  double calculateWeddingRingCost(
      double gram, double laborCost, double purityRate) {
    return gram * purityRate + laborCost;
  }
}
