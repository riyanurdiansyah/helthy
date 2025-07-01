import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/models/instalasi_form_m.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> writeInstalasiFormsToExcel(RequestFormM data) async {
  try {
    var excel = Excel.createExcel();
    final Sheet sheet = excel['Sheet1'];

    // Write headers
    final headers = [
      'ID',
      'No Dokumen',
      'Tanggal',
      'Nama Lab',
      'Alamat',
      'Alat',
      'Merk',
      'No Telepon',
      'Kepala Lab',
      'Status Approval Terakhir',
      'Tanggal Approval Terakhir',
    ];

    for (var i = 0; i < headers.length; i++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
          .value = TextCellValue(headers[i]);
    }

    // Sort approvals by tanggal
    final sortedApprovals = [...data.approvals];
    sortedApprovals.sort((a, b) => a.tanggal.compareTo(b.tanggal));
    final lastApproval =
        sortedApprovals.isNotEmpty ? sortedApprovals.last : null;

    final rowData = [
      TextCellValue(data.id),
      TextCellValue(data.noDokumen),
      TextCellValue(
        data.tanggal != null
            ? DateTime.fromMillisecondsSinceEpoch(
              data.tanggal!.millisecondsSinceEpoch,
            ).toLocal().toString().split(' ')[0]
            : '',
      ),
      TextCellValue(data.namaLab),
      TextCellValue(data.alamat),
      TextCellValue(data.alat),
      TextCellValue(data.merk),
      TextCellValue(data.noTelepon),
      TextCellValue(data.namaKepalaLab),
      TextCellValue(lastApproval?.status ?? '-'),
      TextCellValue(
        lastApproval != null
            ? DateTime.fromMillisecondsSinceEpoch(
              lastApproval.tanggal.millisecondsSinceEpoch,
            ).toLocal().toString().split(' ')[0]
            : '',
      ),
    ];

    for (var j = 0; j < rowData.length; j++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: 1))
          .value = rowData[j];
    }

    final bytes = excel.encode();
    if (bytes == null) {
      Get.snackbar(
        'Error',
        'Failed to encode excel file',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorStyles.danger,
        margin: const EdgeInsets.all(14),
        colorText: Colors.white,
      );
      return null;
    }

    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/instalasi_form_${data.id}.xlsx');
    await file.writeAsBytes(bytes, flush: true);

    await OpenFile.open(file.path);

    return file.path;
  } catch (e) {
    Get.snackbar(
      'Error',
      'Error generating Excel file: $e',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ColorStyles.danger,
      margin: const EdgeInsets.all(14),
      colorText: Colors.white,
    );
    return null;
  }
}
