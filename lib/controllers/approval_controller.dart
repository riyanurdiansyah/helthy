import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
import 'package:signature/signature.dart';

class ApprovalController extends GetxController {
  final _dC = Get.find<DashboardController>();
  final RxList<RequestFormM> requests = <RequestFormM>[].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Rx<bool> updateSignature = false.obs;

  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

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
          response.docs.map((e) => RequestFormM.fromJson(e.data())).toList();

      // final currentUsername = _dC.profile.value?.username ?? "";
      final currentUserID = _dC.profile.value?.id ?? "";

      requests.value =
          allRequests.where((e) {
            final approvals = e.approvals;

            // 1. approvals kosong → ambil
            if (approvals.isEmpty) {
              final userRequestor = _dC.users.firstWhereOrNull(
                (x) => x.username == e.createdBy,
              );
              if (userRequestor == null) return false;
              return userRequestor.directSuperior == currentUserID;
            }

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

            return user.directSuperior == currentUserID;
          }).toList();
    } catch (e) {
      AppDialog.showErrorMessage("Failed get dokumen $e");
    }
  }

  void approveConfirmation(RequestFormM request) async {
    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) {
          return ConfirmationDialog(
            title: 'Approval',
            leftButtonText: 'Batal',
            rightButtonText: 'Approve',
            rightButtonAction: () async {
              Get.back(); // close dialog
              try {
                submitDocument(request, "APPROVED");
              } catch (e) {
                AppDialog.showErrorMessage(e.toString());
              }
            },
            content: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Kamu yakin ingin Approve ${request.noDokumen}?',
                    textAlign: TextAlign.center,
                    style: Calibri400.copyWith(
                      fontSize: 14,
                      color: ColorStyles.disableBold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Signature display or capture
                  if ((_dC.profile.value?.signature ?? "").isNotEmpty &&
                      !updateSignature.value)
                    Column(
                      children: [
                        Text(
                          'Tanda tangan anda:',
                          textAlign: TextAlign.center,
                          style: Roboto500.copyWith(
                            fontSize: 10.5,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Image.network(
                          _dC.profile.value!.signature,
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                        TextButton(
                          onPressed: () {
                            updateSignature.value = true;
                          },
                          child: Text(
                            'Update signature',
                            textAlign: TextAlign.center,
                            style: Roboto500.copyWith(
                              fontSize: 14.5,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Silakan tanda tangan di bawah:"),
                        const SizedBox(height: 8),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Signature(
                            controller: signatureController,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () => signatureController.clear(),
                              child: const Text("Clear"),
                            ),
                            if ((_dC.profile.value?.signature ?? "").isNotEmpty)
                              TextButton(
                                onPressed: () {
                                  updateSignature.value = false;
                                },
                                child: const Text("Cancel Update"),
                              ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void rejectConfirmation(RequestFormM request) async {
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

  Future<void> submitDocument(RequestFormM request, String status) async {
    try {
      String downloadUrl = "";
      final profile = _dC.profile.value;
      final username = profile?.username ?? '-';
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null || profile == null) throw Exception('User belum login');

      final superior = _dC.getDirectSuperior(username);
      final isFinal = superior != null && superior.directSuperior.isEmpty;

      final timestamp = Timestamp.now();

      // Upload signature dulu jika ada
      final rawBytes = await signatureController.toPngBytes();
      if (rawBytes == null) throw Exception('Gagal konversi tanda tangan');

      // Compress image (PNG redraw)
      final compressedBytes = await compressSignatureImage(rawBytes);
      if (compressedBytes == null) {
        throw Exception('Gagal kompress tanda tangan');
      }

      if (updateSignature.value) {
        final ref = FirebaseStorage.instance.ref().child(
          'signatures/${generateUuidV4()}.png',
        );
        final uploadTask = await ref.putData(compressedBytes);

        downloadUrl = await uploadTask.ref.getDownloadURL();
      } else {
        downloadUrl = _dC.profile.value?.signature ?? "";
      }
      final approvalData = ApprovalM(
        nama: username,
        tanggal: timestamp,
        status: status,
        isFinalStatus: isFinal,
        signature: downloadUrl,
      );

      final docRef = FirebaseFirestore.instance
          .collection('requests')
          .doc(request.id);

      final usersRef = FirebaseFirestore.instance.collection('users').doc(uid);

      // Gunakan transaction untuk update Firestore
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(docRef);

        if (!snapshot.exists) {
          throw Exception("Request document not found");
        }

        final currentApprovals =
            snapshot.get('approvals') as List<dynamic>? ?? [];

        // Tambahkan approval baru ke list approvals
        currentApprovals.add(approvalData.toJson());

        transaction.update(docRef, {'approvals': currentApprovals});
        transaction.update(usersRef, {'signature': downloadUrl});
      });

      // Jika sampai sini berarti sukses
      Get.back();
      getRequests();
      if (updateSignature.value) {
        await _dC.getProfile();
      }
      AppDialog.showSuccessMessage("Document is $status");
    } catch (e) {
      AppDialog.showErrorMessage("Failed Approve: $e");
    }
  }

  Future<String?> saveAndUploadSignature() async {
    if (signatureController.isEmpty) {
      throw Exception('Gagal mendapatkan tanda tangan');
    }

    try {
      // Convert signature to bytes
      final rawBytes = await signatureController.toPngBytes();
      if (rawBytes == null) throw Exception('Gagal konversi tanda tangan');

      // Compress image (PNG redraw)
      final compressedBytes = await compressSignatureImage(rawBytes);
      if (compressedBytes == null) {
        throw Exception('Gagal kompress tanda tangan');
      }

      final ref = FirebaseStorage.instance.ref().child(
        'signatures/${generateUuidV4()}.png',
      );
      final uploadTask = await ref.putData(compressedBytes);

      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Gagal mengunggah tanda tangan');
    }
  }
}
