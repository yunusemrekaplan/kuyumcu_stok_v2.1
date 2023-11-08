import 'dart:math';

import '../data/gold_db_controller.dart';

class BarcodeService {
  static final BarcodeService _instance = BarcodeService._internal();

  factory BarcodeService() {
    return _instance;
  }

  BarcodeService._internal();

  final _goldDbController = GoldDbController();

  String firstCode = '978';
  List<String> numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];

  String generateCode() {
    String res = firstCode;
    int sum = 38; // 9*1 + 7*3 + 8*1

    var random = Random();

    for (int i = 0; i < 9; i++) {
      int temp = random.nextInt(9);
      res += numbers[temp];
      if (i % 2 == 0) {
        sum += int.tryParse(numbers[temp])! * 3;
      } else {
        sum += int.tryParse(numbers[temp])!;
      }
    }

    int checkDigit = (sum % 10 == 0) ? 0 : (10 - sum % 10);

    res += checkDigit.toString();

    _goldDbController.golds
            .where((element) => element.barcodeText == res)
            .isEmpty
        ? res
        : generateCode();

    return res;
  }
}
