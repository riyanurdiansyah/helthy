import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:helthy/widgets/custom_container_shadow.dart';

class AppDialog {
  static showDialogLoading({required bool dismissable, String? text}) {
    Get.dialog(
      WillPopScope(
        onWillPop: () => Future.value(dismissable),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              color: Colors.transparent,
              child: CustomContainerShadow(
                padding: EdgeInsets.all(20),
                borderRadius: 12,
                child: Column(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        color: ColorStyles.primary,
                      ),
                    ),
                    if (text != null) ...[
                      16.ph,
                      Text(
                        text,
                        style: Calibri400.copyWith(
                          fontSize: 14,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  static closeDialogLoading({bool useSimpleGetBack = false}) {
    if (Get.isDialogOpen ?? false) {
      Get.until((route) => !(Get.isDialogOpen ?? true));
    }
  }

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
