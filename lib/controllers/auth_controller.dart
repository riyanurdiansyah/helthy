import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.value = _auth.currentUser;
    _auth.authStateChanges().listen((User? user) {
      this.user.value = user;
    });
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      user.value = null;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to logout: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
} 