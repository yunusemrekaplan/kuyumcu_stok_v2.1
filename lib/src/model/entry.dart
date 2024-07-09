import 'dart:convert';

class Entry {
  late int id;
  late Map<String, dynamic> product;
  late DateTime enteredDate;
  late int piece;

  Entry({
    required this.product,
    required this.enteredDate,
    required this.piece,
  });

  Entry.fromJson({required Map<String, dynamic> json, required this.id}) {
    product = jsonDecode(json['product']);
    enteredDate = DateTime.parse(json['enteredDate']);
    piece = json['piece'];
  }

  Map<String, dynamic> toJson() {
    return {
      'product': jsonEncode(product),
      'enteredDate': enteredDate.toIso8601String(),
      'piece': piece,
    };
  }
}
