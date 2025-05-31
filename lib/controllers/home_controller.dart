import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:helthy/widgets/confirmation_dialog.dart';

import '../controllers/auth_controller.dart';

class HomeController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var currentTime = DateTime.now().obs;
  late Timer _timer;

  // Observable variables for request counts
  final RxInt submittedCount = 0.obs;
  final RxInt rejectedCount = 0.obs;
  final RxInt approvedCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    setup();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  Future<void> setup() async {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      currentTime.value = DateTime.now();
    });
    fetchRequestCounts();
  }

  Future<void> fetchRequestCounts() async {
    try {
      // Get the current user's ID
      final String userId = Get.find<AuthController>().user.value?.uid ?? '';

      // Fetch counts from Firestore
      final QuerySnapshot submittedSnapshot =
          await _firestore
              .collection('requests')
              .where('userId', isEqualTo: userId)
              .where('status', isEqualTo: 'submitted')
              .get();

      final QuerySnapshot rejectedSnapshot =
          await _firestore
              .collection('requests')
              .where('userId', isEqualTo: userId)
              .where('status', isEqualTo: 'rejected')
              .get();

      final QuerySnapshot approvedSnapshot =
          await _firestore
              .collection('requests')
              .where('userId', isEqualTo: userId)
              .where('status', isEqualTo: 'approved')
              .get();

      // Update the counts
      submittedCount.value = submittedSnapshot.docs.length;
      rejectedCount.value = rejectedSnapshot.docs.length;
      approvedCount.value = approvedSnapshot.docs.length;
    } catch (e) {
      log('Error fetching request counts: $e');
      // You might want to show an error message to the user
    }
  }

  // ... existing code ...
  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.find<AuthController>().user.value = null;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal untuk keluar: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  // ... existing code ...

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
