import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_pages.dart';

class SplashController extends GetxController {
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkSession();
  }

  Future<void> checkSession() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final prefs = await SharedPreferences.getInstance();
      final hasSession = prefs.getBool('hasSession') ?? false;
      
      if (hasSession) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    } finally {
      isLoading.value = false;
    }
  }
} 