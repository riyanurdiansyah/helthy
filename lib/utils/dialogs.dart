import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
}
