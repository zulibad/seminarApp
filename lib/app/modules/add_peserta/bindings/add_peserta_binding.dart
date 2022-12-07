import 'package:get/get.dart';

import '../controllers/add_peserta_controller.dart';

class AddPesertaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPesertaController>(
      () => AddPesertaController(),
    );
  }
}
