import 'package:flutter/material.dart';
import 'package:helthy/styles/color_styles.dart';

class CustomContainerShadow extends StatelessWidget {
  const CustomContainerShadow({
    super.key,
    required this.child,
    this.customBorderRadius,
    this.alignment,
    this.border,
    this.borderColor,
    this.useBorder = false,
    this.onTap,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.width,
    this.height,
    this.hideShadow = false,
    this.margin,
  });

  final Widget child;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final double? borderRadius;
  final Function()? onTap;
  final bool useBorder;
  final Color? borderColor;
  final bool hideShadow;
  final Border? border;
  final Alignment? alignment;
  final EdgeInsets? margin;
  final BorderRadius? customBorderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius:
          border != null
              ? null
              : customBorderRadius ??
                  BorderRadius.circular((borderRadius ?? 6)),
      child: Container(
        alignment: alignment,
        width: width,
        height: height,
        margin: margin,
        padding: padding ?? EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius:
              border != null
                  ? null
                  : customBorderRadius ??
                      BorderRadius.circular((borderRadius ?? 6)),
          border:
              useBorder
                  ? border ??
                      Border.all(color: borderColor ?? ColorStyles.disableLight)
                  : null,
          boxShadow:
              useBorder || hideShadow
                  ? []
                  : [
                    BoxShadow(
                      color: Color(0xff1D1617).withOpacity(0.07),
                      offset: Offset(0, 10),
                      blurRadius: 20,
                      spreadRadius: 0,
                    ),
                  ],
        ),
        child: child,
      ),
    );
  }
}
