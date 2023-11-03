import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

import 'constant.dart';

class CurrencyService {
  static final CurrencyService _instance = CurrencyService._internal();

  factory CurrencyService() {
    return _instance;
  }

  CurrencyService._internal();

  final hakanAltin = Uri.parse(hakanAltinUrl);

  final saglamoglu = Uri.parse(saglamogluUrl);

  Future<Map<String, double>> getCurrenciesOfHakanAltin() async {
    final res = await http.get(hakanAltin);
    final body = res.body;
    final document = parser.parse(body);

    Map<String, double> currencies = buildCurrenciesOfHakanAltin(document);

    return currencies;
  }

  Map<String, double> buildCurrenciesOfHakanAltin(Document document) {
    final tableGold =
        document.getElementById(elementId)!.children[0].children[1].children[1];
    final tableCurrency =
        document.getElementById(elementId)!.children[1].children[1].children[1];

    final fineGoldBuyTemp = tableGold.children[0].children[3].children[0].text;
    final fineGoldSaleTemp = tableGold.children[0].children[4].children[0].text;
    final usdBuyTemp = tableCurrency.children[0].children[3].children[0].text;
    final usdSaleTemp = tableCurrency.children[0].children[4].children[0].text;
    final eurBuyTemp = tableCurrency.children[1].children[3].children[0].text;
    final eurSaleTemp = tableCurrency.children[1].children[4].children[0].text;

    Map<String, double> currencies = {
      'fineGoldBuy': double.parse(swapDotAndComma(fineGoldBuyTemp)),
      'fineGoldSale': double.parse(swapDotAndComma(fineGoldSaleTemp)),
      'usdBuy': double.parse(swapDotAndComma(usdBuyTemp)),
      'usdSale': double.parse(swapDotAndComma(usdSaleTemp)),
      'eurBuy': double.parse(swapDotAndComma(eurBuyTemp)),
      'eurSale': double.parse(swapDotAndComma(eurSaleTemp)),
    };

    return currencies;
  }

  String swapDotAndComma(String input) {
    return input
        .split('')
        .map((char) => char == '.'
            ? ''
            : char == ','
                ? '.'
                : char)
        .join('');
  }
}
