import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/controllers/dashboard_controller.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/models/approval_m.dart';
import 'package:helthy/models/instalasi_form_m.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:helthy/utils/dialogs.dart';
import 'package:helthy/widgets/confirmation_dialog.dart';
import 'package:helthy/widgets/outlined_primary_button.dart';
import 'package:helthy/widgets/primary_button.dart';

class HistoryController extends GetxController {
  final dC = Get.find<DashboardController>();
  final RxList<RequestFormM> requests = <RequestFormM>[].obs;
  final RxBool isLoading = true.obs;
  @override
  void onInit() async {
    // await getProfile();
    super.onInit();
    await setup();
    await onChangeLoading(false);
  }

  Future onChangeLoading(bool val) async {
    isLoading.value = val;
  }

  Future setup() async {
    await getRequests();
  }

  Future getRequests() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final response =
          await firestore
              .collection("requests")
              .where("createdBy", isEqualTo: dC.profile.value?.username)
              .get();

      requests.clear();
      requests.value =
          response.docs.map((e) => RequestFormM.fromJson(e.data())).toList();
    } catch (e) {
      AppDialog.showErrorMessage("Failed get dokumen $e");
    }
  }

  void approve(String id) {
    Get.dialog(
      ConfirmationDialog(
        title: 'Approve',
        leftButtonText: 'No',
        rightButtonText: 'Yes, Approve',
        rightButtonAction: () {
          Get.back();
          getRequests();
        },
        content: Text(
          'Are you sure want to approve?',
          textAlign: TextAlign.center,
          style: Calibri400.copyWith(
            fontSize: 14,
            color: ColorStyles.disableBold,
          ),
        ),
      ),
    );
  }

  void reject(RequestFormM param) async {
    Get.dialog(
      ConfirmationDialog(
        title: 'Reject',
        leftButtonText: 'No',
        rightButtonText: 'Yes, Reject',
        customButtonConfirmation: Row(
          children: [
            Expanded(
              child: OutlinedPrimaryButton(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                outlinedColor: ColorStyles.danger,
                text: "No",
                borderRadius: 12,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textStyle: Calibri700.copyWith(
                  fontSize: 16,
                  color: ColorStyles.danger,
                ),
                onPressed: () => Get.back(),
              ),
            ),
            12.pw,
            Expanded(
              child: PrimaryButton(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                backgroundColor: ColorStyles.danger,
                text: "Yes, Reject",
                borderRadius: 12,
                textStyle: Calibri700.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.back();
                  submitReject(param);
                },
              ),
            ),
          ],
        ),
        rightButtonAction: () {
          Get.back();
          getRequests();
        },
        content: Text(
          'Are you sure want to approve?',
          textAlign: TextAlign.center,
          style: Calibri400.copyWith(
            fontSize: 14,
            color: ColorStyles.disableBold,
          ),
        ),
      ),
    );
  }

  void submitReject(RequestFormM param) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String superior = "";
      final user =
          await firestore
              .collection("users")
              .where("email", isEqualTo: dC.profile.value?.email)
              .limit(1)
              .get();
      if (user.docs.isNotEmpty) {
        superior = user.docs.first.data()["directSuperior"] ?? "";
      }
      final data = ApprovalM(
        nama: dC.profile.value!.username,
        tanggal: Timestamp.now(),
        status: "REJECTED",
        isFinalStatus: superior.isEmpty,
        signature: "",
      );
      await firestore.collection('requests').doc(param.id).update({
        'nextApproval': param.createdBy,
        'approvals': FieldValue.arrayUnion([
          data.toJson(), // satu atau lebih approval
        ]),
      });
      getRequests();
      AppDialog.showSuccessMessage("Success reject dokumen");
    } catch (e) {
      AppDialog.showErrorMessage("Failed reject dokumen $e");
    }
  }
}
