import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/utils/dialogs.dart';

class ChangePasswordController extends GetxController {
  final tcOldPassword = TextEditingController();
  final tcNewPassword = TextEditingController();
  final tcConfirmPassword = TextEditingController();
  final _auth = FirebaseAuth.instance;

  final RxBool obs1 = true.obs;
  final RxBool obs2 = true.obs;
  final RxBool obs3 = true.obs;

  void changeObs(RxBool data) {
    data.value = !data.value;
  }

  Future<void> changePassword() async {
    final oldPassword = tcOldPassword.text.trim();
    final newPassword = tcNewPassword.text.trim();
    final confirmPassword = tcConfirmPassword.text.trim();

    if (newPassword != confirmPassword) {
      AppDialog.showErrorMessage("New password is not match");
      return;
    }

    try {
      User? user = _auth.currentUser;
      if (user != null && user.email != null) {
        // 1. Re-authenticate with old password
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: oldPassword,
        );

        await user.reauthenticateWithCredential(credential);

        // 2. Update password
        await user.updatePassword(newPassword);

        AppDialog.showSuccessMessage("Password has been changed");

        tcOldPassword.clear();
        tcNewPassword.clear();
        tcConfirmPassword.clear();
      }
    } on FirebaseAuthException catch (e) {
      AppDialog.showSuccessMessage(e.message ?? "Failed to change password");
    }
  }
}
