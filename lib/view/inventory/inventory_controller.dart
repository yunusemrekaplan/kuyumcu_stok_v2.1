import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuyumcu_stok_v2/model/enum/my_route.dart';

import '../../controller/data/gold_db_controller.dart';
import '../../controller/service/barcode_service.dart';
import '../../model/data/gold.dart';
import 'constant.dart';

class InventoryController extends GetxController {
  final _goldDbController = GoldDbController();
  final _barcodeService = BarcodeService();

  late RxList<Gold> golds;

  double get totalGold {
    double sum = 0.0;
    for (var element in golds) {
      sum += element.piece * element.cost;
    }
    return sum;
  }

  double get totalNumberOfEight {
    double sum = 0.0;
    for (var gold in golds) {
      if (gold.carat == 8) {
        sum += gold.piece;
      }
    }
    return sum;
  }

  double get totalNumberOfTen {
    double sum = 0.0;
    for (var gold in golds) {
      if (gold.carat == 10) {
        sum += gold.piece;
      }
    }
    return sum;
  }

  double get totalNumberOfFourteen {
    double sum = 0.0;
    for (var gold in golds) {
      if (gold.carat == 14) {
        sum += gold.piece;
      }
    }
    return sum;
  }

  double get totalNumberOfEighteen {
    double sum = 0.0;
    for (var gold in golds) {
      if (gold.carat == 18) {
        sum += gold.piece;
      }
    }
    return sum;
  }

  double get totalNumberOfTwentyTwo {
    double sum = 0.0;
    for (var gold in golds) {
      if (gold.carat == 22) {
        sum += gold.piece;
      }
    }
    return sum;
  }

  double get totalNumberOfTwentyFour {
    double sum = 0.0;
    for (var gold in golds) {
      if (gold.carat == 24) {
        sum += gold.piece;
      }
    }
    return sum;
  }

  Future<void> init() async {
    await getGolds();
    golds = _goldDbController.golds
        .where(
          (p0) => p0.piece > 0,
        )
        .toList()
        .obs;
  }

  Future<void> getGolds() async {
    bool state = await _goldDbController.getAll();

    if (!state) {
      Get.snackbar(
        'ERROR',
        'Ürünler getirilemedi!!!',
        colorText: snackBarTextColor,
        backgroundColor: snackBarErrorBackgroundColor,
      );
    }
  }

  Future<void> deleteGold(Gold gold) async {
    bool state = false;
    await Get.dialog(
      AlertDialog(
        title: const Text(
          'Uyarı',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        content: const Text(
          'Ürünü silmek istediğinize emin misiniz?',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Hayır'),
          ),
          TextButton(
            onPressed: () async {
              state = await _goldDbController.delete(gold.id);
              Get.back();

              if (state) {
                Get.snackbar(
                  'Başarılı',
                  'Ürün silindi!!!',
                  colorText: snackBarTextColor,
                  backgroundColor: snackBarSuccessBackgroundColor,
                  duration: const Duration(milliseconds: 600),
                );
              } else {
                Get.snackbar(
                  'Hata',
                  'Ürün silinemedi!!!',
                  colorText: snackBarTextColor,
                  backgroundColor: snackBarErrorBackgroundColor,
                  duration: const Duration(seconds: 1),
                );
              }

              update([RouteName.inventory]);
            },
            child: const Text('Evet'),
          ),
        ],
      ),
      transitionDuration: const Duration(milliseconds: 0),
    );
  }

  /*
  void editGold(Gold gold) {
    Get.toNamed(
      MyRoute.editGold,
      arguments: gold,
    );
  }
  */

  Future<void> printGold(Gold gold) async {
    bool state = await _barcodeService.printBarcode(gold.toJson());

    if (state) {
      Get.snackbar(
        'Başarılı',
        'Barkod yazdırıldı!!!',
        colorText: snackBarTextColor,
        backgroundColor: snackBarSuccessBackgroundColor,
        duration: const Duration(seconds: 1),
      );
    } else {
      Get.snackbar(
        'Hata',
        'Barkod yazdırılamadı!!!',
        colorText: snackBarTextColor,
        backgroundColor: snackBarErrorBackgroundColor,
        duration: const Duration(seconds: 1),
      );
    }
  }
}
