import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/controllers/approval_controller.dart';
import 'package:helthy/controllers/history_controller.dart';
import 'package:helthy/controllers/home_controller.dart';
import 'package:helthy/models/profile_m.dart';
import 'package:helthy/utils/dialogs.dart';
import 'package:helthy/utils/prefs.dart';
import 'package:signature/signature.dart';

class DashboardController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Rxn<ProfileM> profile = Rxn<ProfileM>();
  final RxList<ProfileM> users = <ProfileM>[].obs;
  RxInt indexTab = 0.obs;
  RxInt indexTypeRequest = 99.obs;

  RxBool isUpdateSignature = false.obs;
  RxBool hasSignature = false.obs;

  SignatureController signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  List<String> typeRequests = [
    "Instalasi / Uji Fungsi Alat",
    "Training / Presentasi",
    "Sample",
    "Uji Coba / Trial Reagent & Consumable",
  ];

  @override
  void onInit() async {
    await getProfile();
    await getAllUser();
    await Future.delayed(const Duration(seconds: 1));
    signatureController.addListener(() {
      hasSignature.value = signatureController.isNotEmpty;
    });
    super.onInit();
  }

  Future getProfile() async {
    final prof = SharedPrefs().getString("profile");
    profile.value = ProfileM.fromJson(jsonDecode(prof!));
  }

  Future getProfileOnline() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final userQuery = await firestore
        .collection("users")
        .where("id", isEqualTo: uid)
        .limit(1)
        .get();

    if (userQuery.docs.isEmpty) {
      AppDialog.showErrorMessage("Username tidak ditemukan");
      return;
    }

    final userData = userQuery.docs.first.data();
    await SharedPrefs().setString(
      "profile",
      json.encode(ProfileM.fromJson(userData).toJson()),
    );
    getProfile();
  }

  Future getAllUser() async {
    final responseUser = await firestore.collection("users").get();

    users.value =
        responseUser.docs.map((e) => ProfileM.fromJson(e.data())).toList();
  }

  ProfileM? getDirectSuperior(String username) {
    return users.firstWhereOrNull((e) => e.username == username);
  }

  void onChangeTab(int i) {
    indexTab.value = i;

    switch (indexTab.value) {
      case 0:
        Get.find<HomeController>().setup();
      case 1:
        Get.find<HistoryController>().setup();
      case 2:
        Get.find<ApprovalController>().setup();
      default:
        break;
    }
  }

  Future<Uint8List?> compressSignatureImage(Uint8List imageBytes) async {
    // Decode PNG
    final codec = await ui.instantiateImageCodec(imageBytes);
    final frame = await codec.getNextFrame();
    final image = frame.image;

    // Redraw image to canvas (optionally resize here)
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint();

    // You can scale canvas here if needed (to reduce resolution)
    canvas.drawImage(image, Offset.zero, paint);

    final picture = recorder.endRecording();
    final finalImage = await picture.toImage(image.width, image.height);

    // Convert back to PNG (compressed)
    final compressedBytes = await finalImage.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return compressedBytes?.buffer.asUint8List();
  }

  Future<void> saveAndUploadSignature() async {
    if (signatureController.isEmpty) {
      AppDialog.showErrorMessage("Silahkan tulis tanda tangan terlebih dahulu");
      return;
    }

    AppDialog.showDialogLoading(dismissable: false);

    try {
      final rawBytes = await signatureController.toPngBytes();
      if (rawBytes == null) throw Exception('Failed to export signature');

      // Langsung upload tanpa kompres
      final ref = FirebaseStorage.instance.ref().child(
            'signatures/${profile.value?.id}.png',
          );
      final uploadTask = await ref.putData(rawBytes);

      final downloadUrl = await uploadTask.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(profile.value?.id)
          .update({"signature": downloadUrl});
      getProfileOnline();
      AppDialog.closeDialogLoading();
      signatureController.clear();
      isUpdateSignature.value = false;

      Get.back();
      AppDialog.showSuccessMessage("Berhasil mengunggah signature");
    } catch (e) {
      AppDialog.closeDialogLoading();
      AppDialog.showErrorMessage("Gagal mengunggah signature $e");
    }
  }
}
