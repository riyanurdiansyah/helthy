import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/styles/color_styles.dart';

class AppDialog {
  static Future<DateTime?> datePicker({
    required DateTime firstDate,
    required DateTime backDates,
    DateTime? lastDate,
    DateTime? initialDate,
    String? helpText,
  }) async {
    return await showDatePicker(
      context: Get.context!,
      firstDate: backDates,
      lastDate: lastDate ?? DateTime.now().add(const Duration(days: 365)),
      initialDate: initialDate ?? firstDate,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      helpText: helpText ?? "Tanggal",
      selectableDayPredicate: (DateTime date) {
        return true;
      },
    );
  }

  static showSuccessMessage(String msg) {
    return Get.snackbar(
      'Success',
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ColorStyles.genoa,
      margin: const EdgeInsets.all(14),
      colorText: Colors.white,
    );
  }

  static showErrorMessage(String msg) {
    return Get.snackbar(
      'Error',
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ColorStyles.danger,
      margin: const EdgeInsets.all(14),
      colorText: Colors.white,
    );
  }
}
