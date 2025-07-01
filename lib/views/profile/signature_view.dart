import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/controllers/dashboard_controller.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:helthy/widgets/outlined_primary_button.dart';
import 'package:helthy/widgets/primary_button.dart';
import 'package:signature/signature.dart';

class SignatureView extends GetView<DashboardController> {
  const SignatureView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draw Signature'),
        actions: [
          TextButton(
            onPressed: controller.signatureController.clear,
            child: const Text("Clear", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if ((controller.profile.value?.signature ?? "").isNotEmpty &&
                  controller.isUpdateSignature.isFalse) {
                return Image.network(
                  controller.profile.value!.signature,
                  fit: BoxFit.fill,
                );
              }

              return Signature(
                controller: controller.signatureController,
                backgroundColor: Colors.grey[200]!,
              );
            }),
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: Row(
                  children: [
                    if (controller.hasSignature.value)
                      Expanded(
                        child: OutlinedPrimaryButton(
                          text: "H A P U S",
                          textStyle: Roboto900.copyWith(
                            fontSize: 16,
                            color: ColorStyles.genoa,
                          ),
                          onPressed: () {
                            controller.signatureController.clear();
                          },
                          borderRadius: 12,
                        ),
                      ),
                    if (controller.hasSignature.value) 10.pw,
                    Expanded(
                      child: PrimaryButton(
                        onPressed: () {
                          if ((controller.profile.value?.signature ?? "")
                                  .isNotEmpty &&
                              controller.isUpdateSignature.isFalse) {
                            controller.isUpdateSignature.value = true;
                          } else {
                            controller.saveAndUploadSignature();
                          }
                        },
                        text:
                            (controller.profile.value?.signature ?? "")
                                        .isNotEmpty &&
                                    controller.isUpdateSignature.isFalse
                                ? "U P D A T E"
                                : "S I M P A N",
                        textStyle: Roboto900.copyWith(
                          fontSize: 16,
                          color: ColorStyles.white,
                        ),
                        backgroundColor: ColorStyles.genoa,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
