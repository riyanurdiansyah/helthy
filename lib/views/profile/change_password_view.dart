import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:helthy/controllers/change_password_controller.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:helthy/widgets/filled_primary_textfield.dart';
import 'package:helthy/widgets/primary_button.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Change Password',
          textAlign: TextAlign.center,
          style: Roboto700.copyWith(fontSize: 24, color: ColorStyles.white),
        ),
        elevation: 0,
        backgroundColor: ColorStyles.genoa,
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fill the field for change Password',
                style: Calibri700.copyWith(fontSize: 16),
              ),
              14.ph,
              FilledPrimaryTextfield(
                useUppercase: false,
                style: Calibri400.copyWith(
                  fontSize: 18,
                  color: ColorStyles.disableBold,
                ),
                labelText: 'Old Password',
                isRequired: true,
                obscureText: controller.obs1.value,
                controller: controller.tcOldPassword,
                maxLines: 1,
              ),
              14.ph,
              FilledPrimaryTextfield(
                useUppercase: false,
                style: Calibri400.copyWith(
                  fontSize: 18,
                  color: ColorStyles.disableBold,
                ),
                labelText: 'New Password',
                isRequired: true,
                obscureText: controller.obs2.value,
                controller: controller.tcNewPassword,
                maxLines: 1,
              ),
              14.ph,
              FilledPrimaryTextfield(
                useUppercase: false,
                style: Calibri400.copyWith(
                  fontSize: 18,
                  color: ColorStyles.disableBold,
                ),
                maxLines: 1,
                obscureText: controller.obs3.value,
                labelText: 'Confirm Password',
                isRequired: true,
                controller: controller.tcConfirmPassword,
              ),
              35.ph,
              SizedBox(
                height: 50,
                width: double.infinity,
                child: PrimaryButton(
                  onPressed: () {
                    controller.changePassword();
                  },
                  backgroundColor: ColorStyles.genoa,
                  text: "Submit",
                  textStyle: Calibri400.copyWith(
                    fontSize: 18,
                    color: ColorStyles.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
