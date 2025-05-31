import 'package:flutter/material.dart';
import 'package:helthy/styles/color_styles.dart';

class OutlinedPrimaryButton extends StatelessWidget {
  final Function()? onPressed;
  final ButtonStyle? style;
  final Widget? child;
  final String? text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final Color? outlinedColor;
  final EdgeInsets? padding;
  final double? borderRadius;
  final double? borderWidth;

  const OutlinedPrimaryButton({
    super.key,
    required this.onPressed,
    this.style,
    this.child,
    this.text,
    this.textStyle,
    this.textAlign,
    this.maxLines,
    this.outlinedColor,
    this.padding,
    this.borderRadius,
    this.borderWidth,
    this.overflow,
  });
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      // style: style?? ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(6))),
      style:
          style ??
          OutlinedButton.styleFrom(
            padding: padding,
            fixedSize: Size.fromWidth(double.infinity),
            backgroundColor: Colors.white,
            foregroundColor: ColorStyles.primary,
            side: BorderSide(
              color: outlinedColor ?? ColorStyles.primary,
              width: borderWidth ?? 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 5.0),
            ),
          ),
      onPressed: onPressed,
      child:
          child ??
          Text(
            text ?? '',
            style:
                textStyle ??
                TextStyle(color: ColorStyles.primary, fontSize: 12),
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
          ),
    );
  }
}
