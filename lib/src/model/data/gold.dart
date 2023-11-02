import 'package:kuyumcu_stok_v2/src/model/enum/extension/extension_carat.dart';

import '../enum/carat.dart';

class Gold {
  late int id;
  late String barcodeText;
  late int piece;
  late String name;
  late Carat carat; // x
  late double purityRate; // x => z
  late double laborCost; // k
  late double gram; // y
  late double cost; // s
  late double salesGrams;

  Gold({
    required this.barcodeText,
    required this.piece,
    required this.name,
    required this.carat,
    required this.gram,
    required this.purityRate,
    required this.laborCost,
    required this.cost,
    required this.salesGrams,
  });

  Gold.fromJson({required Map<String, dynamic> json, required this.id}) {
    barcodeText = json['barcodeText'];
    piece = json['piece'];
    name = json['name'];
    carat = int.parse(json['carat'].toString()).caratDefinition!;
    gram = json['gram']!.toDouble();
    purityRate = json['purityRate']!.toDouble();
    laborCost = json['laborCost']!.toDouble();
    cost = json['cost']!.toDouble();
    salesGrams = json['salesGrams']!.toDouble();
  }

  Map<String, dynamic> toJson() {
    return {
      'barcodeText': barcodeText,
      'piece': piece,
      'name': name,
      'carat': carat.intDefinition,
      'gram': gram,
      'purityRate': purityRate,
      'laborCost': laborCost,
      'cost': cost,
      'salesGrams': salesGrams,
    };
  }
}
