import 'package:get/get.dart';

import '../controllers/seminar_controller.dart';

class SeminarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeminarController>(
      () => SeminarController(),
    );
  }
}
