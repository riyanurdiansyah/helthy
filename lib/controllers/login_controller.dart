import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_pages.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool isFirebaseInitialized = false.obs;
  
  // Form validation
  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;

  // Text editing controllers
  final emailController = TextEditingController();
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
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  bool validateEmail(String email) {
    if (email.isEmpty) {
      emailError.value = 'Email is required';
      return false;
    }
    if (!GetUtils.isEmail(email)) {
      emailError.value = 'Please enter a valid email';
      return false;
    }
    emailError.value = '';
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

    if (!validateEmail(emailController.text) || 
        !validatePassword(passwordController.text)) {
      return;
    }

    try {
      isLoading.value = true;
      
      // Sign in with Firebase
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (userCredential.user != null) {
        // Save login state
        final prefs = await _prefs;
        await prefs.setBool('hasSession', true);
        
        // Navigate to home
        Get.offAllNamed(Routes.HOME);
      }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found with this email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided.';
          break;
        case 'invalid-email':
          message = 'The email address is invalid.';
          break;
        case 'user-disabled':
          message = 'This user account has been disabled.';
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
        'An unexpected error occurred. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
} 