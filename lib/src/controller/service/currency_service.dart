import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:kuyumcu_stok_v2/src/model/extension/extension_log_state.dart';

import '../../model/data/log.dart';
import '../../model/enum/log_state.dart';
import 'constant.dart';

class CurrencyService {
  static final CurrencyService _instance = CurrencyService._internal();

  factory CurrencyService() {
    return _instance;
  }

  CurrencyService._internal();

  Map<String, double> currencies = {};

  final hakanAltin = Uri.parse(hakanAltinUrl);

  final saglamoglu = Uri.parse(saglamogluUrl);

  Future<bool> getCurrenciesHakanAltin() async {
    try {
      final res = await http.get(hakanAltin);
      final body = res.body;
      final document = parser.parse(body);

      buildCurrenciesHakanAltin(document);
    } on Exception catch (e) {
      Log(
        dateTime: DateTime.now(),
        state: LogState.getCurrenciesHakanAltin.stringDefinition,
        errorMessage: e.toString(),
      );
      return false;
    }

    return true;
  }

  Map<String, double> buildCurrenciesHakanAltin(Document document) {
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

    currencies = {
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
