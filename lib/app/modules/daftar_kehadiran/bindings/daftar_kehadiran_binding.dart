import 'package:get/get.dart';

import '../controllers/daftar_kehadiran_controller.dart';

class DaftarKehadiranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DaftarKehadiranController>(
      () => DaftarKehadiranController(),
    );
  }
}
