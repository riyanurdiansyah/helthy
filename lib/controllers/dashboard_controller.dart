import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:helthy/controllers/approval_controller.dart';
import 'package:helthy/controllers/history_controller.dart';
import 'package:helthy/controllers/home_controller.dart';
import 'package:helthy/models/profile_m.dart';
import 'package:helthy/utils/dialogs.dart';
import 'package:helthy/utils/prefs.dart';

class DashboardController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Rxn<ProfileM> profile = Rxn<ProfileM>();
  final RxList<ProfileM> users = <ProfileM>[].obs;
  RxInt indexTab = 0.obs;
  RxInt indexTypeRequest = 99.obs;

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
    super.onInit();
  }

  Future getProfile() async {
    final prof = SharedPrefs().getString("profile");
    profile.value = ProfileM.fromJson(jsonDecode(prof!));
  }

  Future getProfileOnline() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final userQuery =
        await firestore
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
}
