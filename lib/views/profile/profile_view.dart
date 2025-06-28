import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/controllers/profile_controller.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:helthy/widgets/custom_container_shadow.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Profile',
          textAlign: TextAlign.center,
          style: Roboto700.copyWith(fontSize: 24, color: ColorStyles.white),
        ),
        elevation: 0,
        backgroundColor: ColorStyles.genoa,
      ),
      body: Obx(() {
        if (controller.profile.value == null) {
          return Text("da");
        }
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ColorStyles.genoa,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    controller.getInitials(controller.profile.value!.fullname),
                    textAlign: TextAlign.center,
                    style: Roboto900.copyWith(
                      fontSize: 22,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                12.pw,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.profile.value!.fullname.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: Roboto700.copyWith(
                        fontSize: 18,
                        color: ColorStyles.black,
                      ),
                    ),
                    8.ph,
                    Text(
                      controller.profile.value!.email,
                      style: Roboto400.copyWith(
                        fontSize: 14,
                        color: ColorStyles.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            25.ph,
            CustomContainerShadow(
              borderRadius: 0,
              onTap: () {},
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.symmetric(vertical: 14),
              hideShadow: true,
              child: Row(
                children: [
                  Icon(CupertinoIcons.person),
                  SizedBox(width: 16),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        "Profile info",
                        style: Calibri400.copyWith(fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward_ios_rounded, size: 18),
                ],
              ),
            ),
            Divider(height: 1, color: ColorStyles.disableLight),
            6.ph,

            CustomContainerShadow(
              borderRadius: 0,
              onTap: () {},
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.symmetric(vertical: 14),
              hideShadow: true,
              child: Row(
                children: [
                  Icon(CupertinoIcons.person),
                  SizedBox(width: 16),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        "Version",
                        style: Calibri400.copyWith(fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "v${controller.version}",
                    textAlign: TextAlign.end,
                    style: Calibri400.copyWith(
                      fontSize: 14,
                      color: ColorStyles.disableBold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: ColorStyles.disableLight),
            6.ph,
            CustomContainerShadow(
              borderRadius: 0,
              onTap: controller.doLogout,
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.symmetric(vertical: 14),
              hideShadow: true,
              child: Row(
                children: [
                  Icon(Icons.logout_rounded, color: Colors.red),
                  SizedBox(width: 16),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        "Logout",
                        style: Calibri400.copyWith(
                          fontSize: 18,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
