import 'package:catering_mobile/app/pages/modules/user/menu_makanan/controllers/menu_makanan_controller.dart';
import 'package:get/get.dart';


class MenuMakananBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuMakananController>(
          () => MenuMakananController(),
    );
  }
}
