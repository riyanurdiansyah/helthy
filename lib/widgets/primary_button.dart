import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final double? borderRadius;
  final Color? borderColor;
  final Function()? onPressed;
  final String? text;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Widget? child;
  const PrimaryButton(
      {super.key,
      this.borderRadius,
      this.borderColor,
      this.onPressed,
      this.text,
      this.padding,
      this.backgroundColor,
      this.textStyle,
      this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: padding,
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: borderColor ?? Colors.transparent),
                borderRadius: BorderRadius.circular(borderRadius ?? 10))),
        onPressed: onPressed,
        child: child ??
            Text(
              text ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textStyle,
            ));
  }
}
