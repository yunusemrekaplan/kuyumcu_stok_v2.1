import 'dart:math';
import 'package:barcode/barcode.dart';
import 'package:kuyumcu_stok_v2/model/data/log.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../data/gold_db_controller.dart';

class BarcodeService {
  static final BarcodeService _instance = BarcodeService._internal();

  factory BarcodeService() {
    return _instance;
  }

  BarcodeService._internal();

  final _goldDbController = GoldDbController();

  final pageFormat = const PdfPageFormat(270, 36);
  final barcodeFileName = 'barcode.pdf';
  final bc = Barcode.isbn();
  var pdf = pw.Document();

  String generateCode() {
    const numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
    String res = '978';

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

  Future<bool> printBarcode(Map<String, dynamic> gold) async {
    try {
      await buildBarcode(gold, pdf);
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async =>
            await pdf.save(), // pdf.document.documentID,
        name: barcodeFileName,
      );
      pdf = pw.Document();
      return true;
    } on Exception catch (e) {
      Log(
        dateTime: DateTime.now(),
        state: 'Print Barcode',
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<void> buildBarcode(Map<String, dynamic> gold, pw.Document pdf) async {
    String data = gold['barcodeText'];

    final svg = bc.toSvg(
      data,
      width: 60, // 75
      height: 30, // 30
      fontHeight: 6,
    );

    pdf.addPage(
      pw.Page(
        pageFormat: pageFormat,
        build: (pw.Context context) => pw.Row(
          children: [
            pw.SizedBox(
              width: 56,
              height: 30,
              child: pw.SvgImage(svg: svg),
            ),
            pw.SizedBox(width: 15),
            pw.Column(
              children: [
                pw.SizedBox(height: 12),
                pw.Text(
                  gold['laborCost'].toString(),
                  style: const pw.TextStyle(
                    fontSize: 5,
                  ),
                ),
                pw.Text(
                  gold['gram'].toStringAsFixed(2),
                  style: const pw.TextStyle(
                    fontSize: 5,
                  ),
                ),
              ],
            ),
            pw.SizedBox(width: 4.5),
            pw.Column(children: [
              pw.SizedBox(height: 12),
              pw.Text(
                '${gold['cost'].toStringAsFixed(2)} Mgr',
                style: const pw.TextStyle(
                  fontSize: 5,
                ),
              ),
              pw.Text(
                '${gold['salesGrams'].toStringAsFixed(2)} Sgr',
                style: const pw.TextStyle(
                  fontSize: 5,
                ),
              ),
            ]),
            pw.SizedBox(width: 4.5),
            pw.Text(
              '${gold['carat']}K',
              style: const pw.TextStyle(
                fontSize: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
