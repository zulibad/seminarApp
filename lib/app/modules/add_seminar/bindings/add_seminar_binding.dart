import 'package:get/get.dart';

import '../controllers/add_seminar_controller.dart';

class AddSeminarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddSeminarController>(
      () => AddSeminarController(),
    );
  }
}
