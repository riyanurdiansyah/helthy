import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/controllers/dashboard_controller.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/widgets/outlined_primary_button.dart';
import 'package:helthy/widgets/primary_button.dart';
import 'package:intl/intl.dart';

import '../../models/instalasi_form_m.dart';
import '../../styles/color_styles.dart';
import '../../styles/text_styles.dart';

// Ganti sesuai style kamu
final Calibri700 = TextStyle(
  fontFamily: 'Calibri',
  fontWeight: FontWeight.w700,
);

class DetailRequestView extends GetView<DashboardController> {
  final RequestFormM data;
  final bool isApproval;
  final Function()? onReject;
  final Function()? onApprove;

  const DetailRequestView({
    super.key,
    required this.data,
    required this.isApproval,
    required this.onReject,
    required this.onApprove,
  });

  String formatDate(Timestamp? ts) {
    if (ts == null) return "-";
    return DateFormat('dd MMM yyyy').format(ts.toDate());
  }

  String formatDateWithTime(Timestamp? ts) {
    if (ts == null) return "-";
    return DateFormat('dd MMM yyyy HH:mm:ss').format(ts.toDate());
  }

  Widget sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        title,
        style: Calibri700.copyWith(fontSize: 16, color: ColorStyles.primary),
      ),
    );
  }

  Widget infoRow(String label, String value) {
    if (value.isEmpty) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: Calibri700.copyWith(
                fontSize: 12.5,
                color: ColorStyles.disable,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              ": $value",
              style: Calibri700.copyWith(fontSize: 12.5, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget listItem(
    String title,
    String subtitle,
    IconData icon, {
    Color? iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: iconColor ?? ColorStyles.disable),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Calibri700.copyWith(
                    fontSize: 12.5,
                    color: Colors.black,
                  ),
                ),
                Text(
                  subtitle,
                  style: Calibri700.copyWith(
                    fontSize: 11,
                    color: ColorStyles.disable,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionBox(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [sectionHeader(title), ...children],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),

        title: Text(
          'Detail Request',
          textAlign: TextAlign.center,
          style: Roboto700.copyWith(fontSize: 24, color: ColorStyles.white),
        ),
        elevation: 0,
        backgroundColor: ColorStyles.genoa,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionBox("Informasi Requestor", [
              infoRow(
                "Email",
                controller.users
                        .firstWhereOrNull((e) => e.username == data.createdBy)
                        ?.email ??
                    "-",
              ),
              infoRow(
                "Username",
                controller.users
                        .firstWhereOrNull((e) => e.username == data.createdBy)
                        ?.username ??
                    "-",
              ),
              infoRow(
                "Full Name",
                controller.users
                        .firstWhereOrNull((e) => e.username == data.createdBy)
                        ?.fullname ??
                    "-",
              ),
              infoRow(
                "Email",
                controller.users
                        .firstWhereOrNull((e) => e.username == data.createdBy)
                        ?.email ??
                    "-",
              ),
            ]),

            sectionBox("Informasi Umum", [
              infoRow("Tipe Pengajuan", data.type),
              // infoRow("ID", data.id),
              infoRow("No Dokumen", data.noDokumen),
              infoRow("Revisi", data.noRevisi.toString()),
              infoRow("Nama RS/Lab", data.namaRS),
              infoRow("Tanggal", formatDate(data.tanggal)),
              infoRow("PIC", data.pic),
              infoRow("Nama Lab", data.namaLab),
              infoRow("Divisi RS Yang Meminta", data.divisi),
              infoRow("PIC", data.namaLab),
              infoRow("Alamat", data.alamat),
              infoRow("Telepon", data.noTelepon),
              infoRow("Alat", data.alat),
              infoRow("Merk", data.merk),
              infoRow("Serial", data.serialNumber),
              infoRow("No Invoice", data.noInvoice),
            ]),

            sectionBox("Penanggung Jawab", [
              infoRow("Kepala Lab", data.namaKepalaLab),
              infoRow("PJ Alat", data.penanggungJawabAlat),
              infoRow("Business Rep", data.businessRepresentivePerson),
              infoRow("Tech Support", data.technicalSupport),
              infoRow("Engineer", data.fieldServiceEngineer),
            ]),

            sectionBox("Tanggal", [
              infoRow("Pengajuan", formatDate(data.tanggalPengajuan)),
              infoRow(
                "Permintaan",
                formatDate(data.tanggalPermintaanPemasangan),
              ),
              infoRow("Pemasangan", formatDate(data.tanggalPemasangan)),
              infoRow("Training", formatDate(data.tanggalTraining)),
              infoRow("Dibuat", formatDate(data.dtCreated)),
              infoRow("Diupdate", formatDate(data.dtUpdated)),
            ]),

            if (data.catatan.isNotEmpty && data.praInstalasi.isNotEmpty)
              sectionBox("Catatan", [
                infoRow("Catatan", data.catatan),
                infoRow("Pra-Instalasi", data.praInstalasi),
              ]),

            sectionBox("Items", [
              ...data.items.map(
                (item) => listItem(
                  item.namaItem,
                  "${item.jumlah} ${item.satuan} - ${item.status}",
                  Icons.check_circle,
                  iconColor: Colors.green,
                ),
              ),
            ]),
            if (data.accesories.isNotEmpty)
              sectionBox("Accessories", [
                ...data.accesories.map(
                  (item) => listItem(
                    item.namaItem,
                    "${item.jumlah} ${item.satuan} - ${item.status}",
                    Icons.check_circle,
                    iconColor: Colors.green,
                  ),
                ),
              ]),
            if (data.approvals.isNotEmpty)
              sectionBox("Approvals", [
                ...data.approvals.map(
                  (a) => listItem(
                    a.nama,
                    "${a.status} - ${formatDateWithTime(a.tanggal)}",
                    a.status == "REJECTED"
                        ? Icons.highlight_remove_rounded
                        : Icons.check_circle_rounded,
                    iconColor:
                        a.status == "REJECTED"
                            ? ColorStyles.danger
                            : Colors.green,
                  ),
                ),
              ]),
            if (isApproval)
              Column(
                children: [
                  25.ph,
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedPrimaryButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 14,
                      ),
                      outlinedColor: ColorStyles.danger,
                      text: "REJECT",
                      borderRadius: 12,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textStyle: Calibri700.copyWith(
                        fontSize: 16,
                        color: ColorStyles.danger,
                      ),
                      onPressed: onReject,
                    ),
                  ),
                  12.ph,
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 14,
                      ),
                      backgroundColor: ColorStyles.genoa,
                      text: "Approve",
                      borderRadius: 12,
                      textStyle: Calibri700.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      onPressed: onApprove,
                    ),
                  ),
                  25.ph,
                ],
              ),
          ],
        ),
      ),
    );
  }
}
