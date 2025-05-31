import 'package:get/get.dart';
import 'package:helthy/controllers/home_controller.dart';

class DashboardController extends GetxController {
  RxInt indexTab = 0.obs;

  void onChangeTab(int i) {
    indexTab.value = i;

    switch (indexTab.value) {
      case 0:
        Get.find<HomeController>().setup();
      default:
        break;
    }
  }
}
