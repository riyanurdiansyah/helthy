import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:helthy/widgets/outlined_primary_button.dart';
import 'package:helthy/widgets/primary_button.dart';

class DialogButtonAction extends StatelessWidget {
  const DialogButtonAction({
    super.key,
    required this.leftButtonContent,
    required this.rightButtonContent,
    required this.rightButtonFunction,
    this.leftButtonFunction,
  });

  final String leftButtonContent;
  final String rightButtonContent;
  final Function()? leftButtonFunction;
  final Function() rightButtonFunction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedPrimaryButton(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            outlinedColor: ColorStyles.genoa,
            text: leftButtonContent,
            borderRadius: 12,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textStyle: Calibri700.copyWith(
              fontSize: 16,
              color: ColorStyles.genoa,
            ),
            onPressed: leftButtonFunction ?? () => Get.back(),
          ),
        ),
        16.pw,
        Expanded(
          child: PrimaryButton(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            backgroundColor: ColorStyles.genoa,
            text: rightButtonContent,
            borderRadius: 12,
            textStyle: Calibri700.copyWith(fontSize: 16, color: Colors.white),
            onPressed: rightButtonFunction,
          ),
        ),
      ],
    );
  }
}
