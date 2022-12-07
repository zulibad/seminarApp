import 'package:get/get.dart';
import 'package:seminar/app/routes/app_pages.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;

  void pindahHalaman(int i) async {
    switch (i) {
      case 1:
        pageIndex.value = i;
        Get.offAllNamed(Routes.SEMINAR);
        break;
      case 2:
        pageIndex.value = i;
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        pageIndex.value = i;
        Get.offAllNamed(Routes.HOME);
    }
  }
}
