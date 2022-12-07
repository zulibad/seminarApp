import 'package:get/get.dart';

import '../controllers/detail_seminar_controller.dart';

class DetailSeminarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailSeminarController>(
      () => DetailSeminarController(),
    );
  }
}
