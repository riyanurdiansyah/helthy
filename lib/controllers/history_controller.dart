import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/models/instalasi_form_m.dart';
import 'package:helthy/styles/color_styles.dart';

class HistoryController extends GetxController {
  final RxList<InstalasiFormM> requests = <InstalasiFormM>[].obs;
  @override
  void onInit() async {
    await setup();
    super.onInit();
  }

  Future setup() async {
    await getRequests();
  }

  Future getRequests() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final response = await firestore.collection("requests").get();
      requests.clear();
      for (var e in response.docs) {
        requests.add(InstalasiFormM.fromJson(e.data()));
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get requests: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorStyles.danger,
        margin: const EdgeInsets.all(14),
        colorText: Colors.white,
      );
    }
  }
}
