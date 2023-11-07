import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/data/gold_db_controller.dart';
import '../../controller/data/sale_db_controller.dart';
import '../../controller/service/currency_service.dart';
import '../../model/data/gold.dart';
import '../../model/data/sale.dart';

class SaleController extends GetxController {
  final _currencyService = CurrencyService();
  final _goldDbController = GoldDbController();
  final _saleDbController = SaleDbController();

  final barcodeTextEditingController = TextEditingController().obs;
  final profitTlTextEditingController = TextEditingController().obs;
  final profitGramTextEditingController = TextEditingController().obs;
  final salesPriceTextEditingController = TextEditingController().obs;
  final salesGramTextEditingController = TextEditingController().obs;
  final pieceTextEditingController = TextEditingController().obs;

  List<String> goldCells = ['İsim', 'Adet', 'Gram', 'Maliyet', 'S. Gramı'].obs;

  RxList<Gold> get golds => _goldDbController.golds;
  RxMap currencies = {}.obs;
  Gold? gold;

  Future<void> init() async {
    await getCurrency();
    await getGolds();

    currencies.value = _currencyService.currencies;
    /*
    barcodeTextEditingController.addListener(() {
      if (barcodeTextEditingController.text.length == 13) {
        Gold gold = golds.firstWhere(
          (element) => element.barcode == barcodeTextEditingController.text,
          orElse: () => null,
        );
        if (gold != null) {
          pieceTextEditingController.text = '1';
          salesPriceTextEditingController.text = gold.salesPrice.toString();
          salesGramTextEditingController.text = gold.salesGram.toString();
          profitTlTextEditingController.text = gold.profitTl.toString();
          profitGramTextEditingController.text = gold.profitGram.toString();
        } else {
          Get.snackbar(
            'ERROR',
            'Ürün bulunamadı',
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      }
    });
    */
  }

  Future<void> onRefresh() async {
    await getCurrency();

    barcodeTextEditingController.value.clear();
    profitTlTextEditingController.value.clear();
    profitGramTextEditingController.value.clear();
    salesPriceTextEditingController.value.clear();
    salesGramTextEditingController.value.clear();
    pieceTextEditingController.value.clear();

    goldCells[0] = 'İsim';
    goldCells[1] = 'Adet';
    goldCells[2] = 'Gram';
    goldCells[3] = 'Maliyet';
    goldCells[4] = 'S. Gramı';
  }

  Future<void> getCurrency() async {
    bool state = await _currencyService.getCurrenciesHakanAltin();
    if (state) {
      currencies.value = _currencyService.currencies;
    } else {
      Get.snackbar(
        'ERROR',
        'Döviz kurları alınamadı',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> getGolds() async {
    bool state = await _goldDbController.getAll();
    if (!state) {
      Get.snackbar(
        'ERROR',
        'Kayıtlı ürünler getirilemedi',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  void onSearch() async {
    gold = null;
    if (barcodeTextEditingController.value.text.length == 13) {
      await getCurrency();
      for (Gold element in golds) {
        if (element.barcodeText == barcodeTextEditingController.value.text) {
          gold = element;
          break;
        }
      }
      if (gold != null) {
        goldCells[0] = gold!.name.length > 26
            ? '${gold!.name.substring(0, 26)}...'
            : gold!.name;
        goldCells[1] = gold!.piece.toString();
        goldCells[2] = gold!.gram.toString();
        goldCells[3] = gold!.cost.toString();
        goldCells[4] = gold!.salesGrams.toString();
        profitTlTextEditingController.value.text =
            ((gold!.salesGrams - gold!.cost) * currencies['fineGoldSale'])
                .toStringAsFixed(0);
        profitGramTextEditingController.value.text =
            (gold!.salesGrams - gold!.cost).toStringAsFixed(3);
        salesPriceTextEditingController.value.text =
            (gold!.salesGrams * currencies['fineGoldSale']).toStringAsFixed(0);
        salesGramTextEditingController.value.text =
            gold!.salesGrams.toStringAsFixed(3);
      } else {
        Get.snackbar(
          'ERROR',
          'Ürün bulunamadı',
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    }
  }

  void onChangedProfitTl(String? value) {
    if (gold != null) {
      int? profitTl = int.tryParse(value!);
      if (profitTl != null) {
        double profitGram = profitTl / currencies['fineGoldSale'];
        profitGramTextEditingController.value.text =
            profitGram.toStringAsFixed(3);
        salesGramTextEditingController.value.text =
            (gold!.cost + profitGram).toStringAsFixed(3);
        salesPriceTextEditingController.value.text =
            ((gold!.cost + profitGram) * currencies['fineGoldSale'])
                .toStringAsFixed(0);
      } else if (value.isEmpty) {
        double profitGram = 0;
        profitGramTextEditingController.value.text =
            profitGram.toStringAsFixed(3);
        salesGramTextEditingController.value.text =
            (gold!.cost + profitGram).toStringAsFixed(3);
        salesPriceTextEditingController.value.text =
            ((gold!.cost + profitGram) * currencies['fineGoldSale'])
                .toStringAsFixed(0);
      }
    }
  }

  void onChangedProfitGram(String? value) {
    if (gold != null) {
      double? profitGram = double.tryParse(value!);
      if (profitGram != null) {
        double salesGram = gold!.cost + profitGram;
        int salesPrice = (salesGram * currencies['fineGoldSale']).toInt();
        salesPriceTextEditingController.value.text = salesPrice.toString();
        salesGramTextEditingController.value.text =
            salesGram.toStringAsFixed(3);
      } else if (value.isEmpty) {
        double salesGram = gold!.cost;
        int salesPrice = (salesGram * currencies['fineGoldSale']).toInt();
        salesPriceTextEditingController.value.text = salesPrice.toString();
        salesGramTextEditingController.value.text =
            salesGram.toStringAsFixed(3);
      }
    }
  }

  void onChangedSalesPrice(String? value) {
    if (gold != null) {
      int? salesPrice = int.tryParse(value!);
      if (salesPrice != null) {
        double salesGram = salesPrice / currencies['fineGoldSale'];
        double profitGram = salesGram - gold!.cost;
        profitGramTextEditingController.value.text =
            profitGram.toStringAsFixed(3);
        salesGramTextEditingController.value.text =
            salesGram.toStringAsFixed(3);
      } else if (value.isEmpty) {
        double salesGram = gold!.cost;
        int salesPrice = (salesGram * currencies['fineGoldSale']).toInt();
        salesPriceTextEditingController.value.text = salesPrice.toString();
        salesGramTextEditingController.value.text =
            salesGram.toStringAsFixed(3);
      }
    }
  }

  Future<void> onSale() async {
    if (gold != null) {
      int? piece = int.tryParse(pieceTextEditingController.value.text);
      if (piece != null) {
        if (!pieceControl(piece)) return;
        if (await addSale(piece)) {
          await updateGold(piece);
          onRefresh();
          Get.snackbar(
            'SUCCESS',
            'Ürün satıldı',
            colorText: Colors.white,
            backgroundColor: Colors.green,
          );
        } else {
          _saleDbController.sales.removeLast();
          Get.snackbar(
            'ERROR',
            'Ürün satılamadı',
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      } else {
        Get.snackbar(
          'ERROR',
          'Adet girilmedi',
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } else {
      Get.snackbar(
        'ERROR',
        'Ürün bulunamadı',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  bool pieceControl(int piece) {
    if (gold!.piece < piece) {
      Get.snackbar(
        'ERROR',
        'Adet fazla',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return false;
    } else if (piece == 0) {
      Get.snackbar(
        'ERROR',
        'Adet 0\'dan büyük olmalı',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return false;
    }
    return true;
  }

  Future<bool> addSale(int piece) async {
    double costPrice = gold!.cost * currencies['fineGoldSale'];
    double soldPrice = double.parse(
      salesPriceTextEditingController.value.text,
    );
    double soldGram = double.parse(
      salesGramTextEditingController.value.text,
    );
    double earnedProfitTl = soldPrice - costPrice;
    double earnedProfitGram = soldGram - gold!.cost;
    Sale sale = Sale(
      product: gold!.toJson(),
      soldDate: DateTime.now(),
      piece: piece,
      costPrice: costPrice,
      soldPrice: soldPrice,
      soldGram: soldGram,
      earnedProfitTL: earnedProfitTl,
      earnedProfitGram: earnedProfitGram,
    );
    _saleDbController.sales.add(sale);
    return await _saleDbController.add(sale.toJson());
  }

  Future<void> updateGold(int piece) async {
    gold!.piece -= piece;
    bool state = await _goldDbController.update(gold!.toJson(), gold!.id);
    if (state) {
      _goldDbController.golds[_goldDbController.golds.indexWhere(
        (element) => element.id == gold!.id,
      )] = gold!;
    } else {
      Get.snackbar(
        'ERROR',
        'Ürün güncellenemedi',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
}
