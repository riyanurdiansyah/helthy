import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/models/profile_m.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool isFirebaseInitialized = false.obs;

  // Form validation
  final RxString usernameError = ''.obs;
  final RxString passwordError = ''.obs;

  // Text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final _prefs = SharedPreferences.getInstance();

  @override
  void onInit() {
    super.onInit();
    _checkFirebaseAuth();
  }

  Future<void> _checkFirebaseAuth() async {
    try {
      // First check if Firebase Auth instance is available
      // if (_auth == null) {
      //   throw Exception('Firebase Auth instance is not available');
      // }

      // Try to get current user to verify auth is working
      // final currentUser = _auth.currentUser;

      // Listen to auth state changes to verify the channel is working
      _auth.authStateChanges().listen((User? user) {
        // This is just to verify the channel is working
        log('Auth state changed: ${user?.email ?? 'No user'}');
      });

      isFirebaseInitialized.value = true;
      log('Firebase Auth initialized successfully');
    } catch (e) {
      log('Firebase Auth initialization error: $e');
      isFirebaseInitialized.value = false;
      Get.snackbar(
        'Error',
        'Failed to initialize authentication. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  bool validateUsername(String email) {
    if (email.isEmpty) {
      usernameError.value = 'Username is required';
      return false;
    }
    usernameError.value = '';
    return true;
  }

  bool validatePassword(String password) {
    if (password.isEmpty) {
      passwordError.value = 'Password is required';
      return false;
    }
    if (password.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      return false;
    }
    passwordError.value = '';
    return true;
  }

  Future<void> login() async {
    if (!isFirebaseInitialized.value) {
      Get.snackbar(
        'Error',
        'Authentication service is not available. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isEmpty || !validatePassword(password)) {
      return;
    }

    try {
      isLoading.value = true;

      // Cari email berdasarkan username di Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final userQuery =
          await firestore
              .collection("users")
              .where("username", isEqualTo: username)
              .limit(1)
              .get();

      if (userQuery.docs.isEmpty) {
        Get.snackbar(
          "Login Failed",
          "Username tidak ditemukan.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      final userData = userQuery.docs.first.data();
      final email = userData["email"];

      // Lakukan login menggunakan email yang ditemukan
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        // Simpan state login
        final prefs = await _prefs;
        await prefs.setString(
          "profile",
          json.encode(ProfileM.fromJson(userData).toJson()),
        );
        await prefs.setBool('hasSession', true);

        // Navigasi ke dashboard
        Get.offAllNamed("/dashboard");
      }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'User tidak ditemukan.';
          break;
        case 'wrong-password':
          message = 'Password salah.';
          break;
        case 'invalid-email':
          message = 'Alamat email tidak valid.';
          break;
        case 'user-disabled':
          message = 'Akun pengguna telah dinonaktifkan.';
          break;
        default:
          log("ERROR $e");
          message = '$e';
      }
      Get.snackbar(
        'Login Failed',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan tidak terduga. Silakan coba lagi. $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
