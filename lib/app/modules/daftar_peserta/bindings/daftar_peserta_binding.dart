import 'package:get/get.dart';

import '../controllers/daftar_peserta_controller.dart';

class DaftarPesertaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DaftarPesertaController>(
      () => DaftarPesertaController(),
    );
  }
}
