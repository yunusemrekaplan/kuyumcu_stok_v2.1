import 'package:get/get.dart';

import '../../controller/service/barcode_service.dart';
import 'constant.dart';

class GoldController extends GetxController {
  GoldController({required this.gold});
  final _barcodeService = BarcodeService();

  late Map<String, dynamic> gold;

  Future<void> printGold() async {
    bool state = await _barcodeService.printBarcode(gold);

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
