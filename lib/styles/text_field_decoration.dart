import 'package:flutter/material.dart';
import 'package:helthy/styles/color_styles.dart';

InputDecoration textFieldAuthDecoration({
  required double fontSize,
  required String hintText,
  double? radius,
  Color? borderColor,
}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
    hintStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      fontFamily: "OpenSauceSans",
      color: Colors.grey,
    ),
    hintText: hintText,
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red.shade300),
      borderRadius: BorderRadius.circular(5),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red.shade300),
      borderRadius: BorderRadius.circular(5),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: borderColor ?? ColorStyles.genoa),
      borderRadius: BorderRadius.circular(5),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400),
      borderRadius: BorderRadius.circular(radius ?? 6),
    ),
  );
}

InputDecoration textFieldPassDecoration({
  required double fontSize,
  required String hintText,
  double? radius,
  Function()? onTap,
}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
    hintStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: Colors.grey,
      fontFamily: "OpenSauceSans",
    ),
    hintText: hintText,
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red.shade300),
      borderRadius: BorderRadius.circular(5),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red.shade300),
      borderRadius: BorderRadius.circular(5),
    ),
    suffixIcon: IconButton(
      onPressed: onTap,
      icon: const Icon(Icons.remove_red_eye_rounded),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: ColorStyles.genoa),
      borderRadius: BorderRadius.circular(5),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400),
      borderRadius: BorderRadius.circular(radius ?? 6),
    ),
  );
}

InputDecoration textFieldApprovalDecoration({
  required double fontSize,
  required String hintText,
  double? radius,
  Widget? prefix,
  Function()? onTap,
}) {
  return InputDecoration(
    hintStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: Colors.black,
      fontFamily: "OpenSauceSans",
    ),
    hintText: hintText,
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red.shade300),
      borderRadius: BorderRadius.circular(5),
    ),
    prefixIcon: prefix,
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red.shade300),
      borderRadius: BorderRadius.circular(5),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: ColorStyles.genoa),
      borderRadius: BorderRadius.circular(5),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400),
      borderRadius: BorderRadius.circular(radius ?? 6),
    ),
  );
}
