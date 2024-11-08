import 'package:catering_mobile/app/pages/modules/user/paket_makanan/controllers/paket_makanan_controller.dart';
import 'package:get/get.dart';


class PaketMakananBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaketMakananController>(
          () => PaketMakananController(),
    );
  }
}
