import 'package:flutter/material.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:helthy/widgets/action_button_dialog.dart';
import 'package:helthy/widgets/custom_container_shadow.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.leftButtonText,
    required this.rightButtonText,
    required this.rightButtonAction,
    required this.content,
    this.leftButtonFunction,
    this.singleButtonConfirmation,
    this.customButtonConfirmation,
  });

  final String title;
  final Widget content;
  final String leftButtonText;
  final String rightButtonText;
  final Function()? leftButtonFunction;
  final Function() rightButtonAction;
  final Widget? singleButtonConfirmation;
  final Widget? customButtonConfirmation;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: CustomContainerShadow(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        borderRadius: 12,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Calibri700.copyWith(fontSize: 16),
            ),
            SizedBox(height: 12),
            content,
            SizedBox(height: 8),
            if (singleButtonConfirmation != null) ...[
              singleButtonConfirmation!,
            ] else if (customButtonConfirmation != null) ...[
              customButtonConfirmation!,
            ] else ...[
              DialogButtonAction(
                leftButtonFunction: leftButtonFunction,
                leftButtonContent: leftButtonText,
                rightButtonContent: rightButtonText,
                rightButtonFunction: rightButtonAction,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
