import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/controllers/auth_controller.dart';
import 'package:helthy/models/profile_m.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:helthy/utils/prefs.dart';
import 'package:helthy/widgets/confirmation_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<ProfileM> profile = Rxn<ProfileM>();

  final RxString version = "".obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
    getVersion();
  }

  void getProfile() async {
    final prof = SharedPrefs().getString("profile");
    profile.value = ProfileM.fromJson(jsonDecode(prof!));
  }

  void getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
  }

  String getInitials(String name) {
    final words = name.trim().split(' ').where((w) => w.isNotEmpty).toList();

    if (words.length >= 2) {
      // Ambil huruf pertama dari dua kata pertama
      return (words[0][0] + words[1][0]).toUpperCase();
    } else if (words.length == 1 && words[0].length >= 2) {
      // Kalau cuma satu kata, ambil dua huruf pertama dari kata itu
      return words[0].substring(0, 2).toUpperCase();
    } else if (words.length == 1 && words[0].length == 1) {
      // Kalau satu huruf doang, duplikat hurufnya
      return (words[0][0] + words[0][0]).toUpperCase();
    }

    return '';
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      SharedPrefs().clear();
      Get.find<AuthController>().user.value = null;
      Get.offAllNamed("/login");
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal untuk keluar: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void doLogout() {
    Get.dialog(
      ConfirmationDialog(
        title: 'Keluar',
        leftButtonText: 'Tidak',
        rightButtonText: 'Ya',
        rightButtonAction: () {
          Get.back();
          logout();
        },
        content: Text(
          'Kamu yakin ingin keluar?',
          textAlign: TextAlign.center,
          style: Calibri400.copyWith(
            fontSize: 14,
            color: ColorStyles.disableBold,
          ),
        ),
      ),
    );
  }
}
