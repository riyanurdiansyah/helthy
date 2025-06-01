import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';

class FilledPrimaryTextfield extends StatelessWidget {
  final String? initialValue;
  final TextStyle? style;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final String? labelText;
  final TextStyle? labelStyle;
  final String? errorText;
  final Widget? suffixIcon;
  final String? suffixText;
  final String? prefixText;
  final Widget? prefixIcon;
  final Color? fillColor;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final int? minLines;
  final int? maxLines;
  final bool? obscureText;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final Function()? onTap;
  final bool? readOnly;
  final bool? isRequired;
  final String? hint;
  final TextStyle? hintStyle;
  final TextInputAction? textInputAction;
  final double? opacityRequired;
  final bool enable;
  final int? maxLength;
  final bool withIntrinsicWidth;
  final bool useUppercase;

  const FilledPrimaryTextfield({
    super.key,
    this.initialValue,
    this.style,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textAlign,
    this.inputFormatters,
    this.minLines,
    this.maxLines,
    this.labelText,
    this.labelStyle,
    this.obscureText,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onTap,
    this.readOnly,
    this.isRequired,
    this.errorText,
    this.suffixIcon,
    this.suffixText,
    this.prefixText,
    this.prefixIcon,
    this.fillColor,
    this.enabledBorder,
    this.hint,
    this.hintStyle,
    this.textInputAction,
    this.opacityRequired,
    this.enable = true,
    this.disabledBorder,
    this.maxLength,
    this.withIntrinsicWidth = false,
    this.useUppercase = true,
  });

  Widget get fieldContent {
    return TextFormField(
      initialValue: initialValue,
      style: style ?? Calibri400.copyWith(fontSize: 18),
      controller: controller,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      textAlign: textAlign ?? TextAlign.start,
      inputFormatters: [
        ...inputFormatters ?? [],
        if (useUppercase) ...[UpperCaseTextFormatter()],
      ],
      minLines: minLines,
      maxLines: maxLines,
      textInputAction: textInputAction,
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      enabled: enable,
      maxLength: maxLength,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle:
            labelStyle ??
            Calibri400.copyWith(fontSize: 18, color: ColorStyles.disableBold),
        errorText: errorText,
        errorStyle: Calibri400.copyWith(
          fontSize: 12,
          color: ColorStyles.danger,
        ),
        suffixIcon: suffixIcon,
        hintText: hint ?? 'Silahkan isi ${labelText ?? ''}',
        prefixText: prefixText,
        prefixIcon: prefixIcon,
        suffixText: suffixText,
        suffixStyle: Calibri400.copyWith(
          fontSize: 18,
          color: ColorStyles.black,
        ),
        prefixStyle: Calibri400.copyWith(
          fontSize: 18,
          color: ColorStyles.black,
        ),
        fillColor: fillColor,
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorStyles.disableLight),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorStyles.primary),
        ),
        enabledBorder:
            enabledBorder ??
            UnderlineInputBorder(
              borderSide: BorderSide(color: ColorStyles.disableLight),
            ),
        disabledBorder:
            disabledBorder ??
            UnderlineInputBorder(
              borderSide: BorderSide(color: ColorStyles.disableLight),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isRequired ?? false) ...[
            Opacity(
              opacity: opacityRequired ?? 1,
              child: Text(
                '*',
                style: Calibri400.copyWith(
                  fontSize: 12,
                  color: ColorStyles.danger,
                ),
              ).marginOnly(top: 12.5),
            ),
            SizedBox(width: 4),
          ],
          Flexible(
            child:
                withIntrinsicWidth
                    ? IntrinsicWidth(child: fieldContent)
                    : fieldContent,
          ),
        ],
      ),
    );
  }
}
