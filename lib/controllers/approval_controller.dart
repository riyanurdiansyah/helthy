import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:helthy/controllers/dashboard_controller.dart';
import 'package:helthy/models/approval_m.dart';
import 'package:helthy/models/instalasi_form_m.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:helthy/utils/dialogs.dart';
import 'package:helthy/widgets/confirmation_dialog.dart';

class ApprovalController extends GetxController {
  final _dC = Get.find<DashboardController>();
  final RxList<InstalasiFormM> requests = <InstalasiFormM>[].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  void onInit() {
    super.onInit();
    setup();
  }

  Future setup() async {
    await getRequests();
  }

  Future getRequests() async {
    try {
      final usernames = _dC.users.map((u) => u.username).toList();

      if (usernames.isEmpty) {
        requests.clear();
        return;
      }

      final response =
          await firestore
              .collection("requests")
              .where("createdBy", whereIn: usernames)
              .get();

      requests.clear();
      final allRequests =
          response.docs.map((e) => InstalasiFormM.fromJson(e.data())).toList();

      final currentUsername = _dC.profile.value?.username ?? "";

      requests.value =
          allRequests.where((e) {
            final approvals = e.approvals;

            // 1. approvals kosong → ambil
            if (approvals.isEmpty) return false;

            final lastApproval = approvals.last;

            // 2. Jika REJECTED → buang
            if (lastApproval.status == "REJECTED") return false;

            // 3. Jika final status → buang
            if (lastApproval.isFinalStatus) return false;

            // 4. Cek apakah directSuperior cocok
            final lastUsername = lastApproval.nama;
            final user = _dC.users.firstWhereOrNull(
              (u) => u.username == lastUsername,
            );

            if (user == null) return false;

            return user.directSuperior == currentUsername;
          }).toList();
    } catch (e) {
      AppDialog.showErrorMessage("Failed get dokumen $e");
    }
  }

  void approveConfirmation(InstalasiFormM request) async {
    Get.dialog(
      ConfirmationDialog(
        title: 'Approval',
        leftButtonText: 'Batal',
        rightButtonText: 'Approve',
        rightButtonAction: () {
          Get.back();
          submitDocument(request, "APPROVED");
        },
        content: Text(
          'Kamu yakin ingin Approve ${request.noDokumen}?',
          textAlign: TextAlign.center,
          style: Calibri400.copyWith(
            fontSize: 14,
            color: ColorStyles.disableBold,
          ),
        ),
      ),
    );
  }

  void rejectConfirmation(InstalasiFormM request) async {
    Get.dialog(
      ConfirmationDialog(
        title: 'Reject',
        leftButtonText: 'Batal',
        rightButtonText: 'Reject',
        rightButtonAction: () {
          Get.back();
          submitDocument(request, "REJECTED");
        },
        rightButtonColor: ColorStyles.danger,
        content: Text(
          'Kamu yakin ingin reject ${request.noDokumen}?',
          textAlign: TextAlign.center,
          style: Calibri400.copyWith(
            fontSize: 14,
            color: ColorStyles.disableBold,
          ),
        ),
      ),
    );
  }

  void submitDocument(InstalasiFormM request, String status) async {
    try {
      final superior = _dC.getDirectSuperior(
        _dC.profile.value?.username ?? "-",
      );
      final data = ApprovalM(
        nama: _dC.profile.value!.username,
        tanggal: Timestamp.now(),
        status: status,
        isFinalStatus: superior != null && superior.directSuperior.isEmpty,
      );
      await firestore.collection('requests').doc(request.id).update({
        'approvals': FieldValue.arrayUnion([
          data.toJson(), // satu atau lebih approval
        ]),
      });
      Get.back();
      getRequests();
      AppDialog.showSuccessMessage("Document is $status");
    } catch (e) {
      AppDialog.showErrorMessage("Failed Approve : $e");
    }
  }
}
