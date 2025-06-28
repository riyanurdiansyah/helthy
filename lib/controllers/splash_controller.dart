import 'package:get/get.dart';
import 'package:helthy/utils/prefs.dart';

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
      final hasSession = SharedPrefs().getBool('hasSession') ?? false;

      if (hasSession) {
        Get.offAllNamed("/dashboard");
      } else {
        Get.offAllNamed("/login");
      }
    } finally {
      isLoading.value = false;
    }
  }
}
