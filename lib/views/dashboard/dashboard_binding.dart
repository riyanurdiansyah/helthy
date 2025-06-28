import 'package:get/get.dart';
import 'package:helthy/controllers/approval_controller.dart';
import 'package:helthy/controllers/dashboard_controller.dart';
import 'package:helthy/controllers/history_controller.dart';
import 'package:helthy/controllers/profile_controller.dart';

import '../../controllers/home_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HistoryController>(() => HistoryController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<ApprovalController>(() => ApprovalController());
  }
}
