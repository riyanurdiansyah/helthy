import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/controllers/dashboard_controller.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:helthy/views/approval/approval_view.dart';
import 'package:helthy/views/history/history_view.dart';
import 'package:helthy/views/home/home_view.dart';
import 'package:helthy/views/profile/profile_view.dart';
import 'package:helthy/widgets/primary_button.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.indexTab.value,
          children: [HomeView(), HistoryView(), ApprovalView(), ProfileView()],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 30),
        height: 65,
        width: 65,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
        ),
        child: FloatingActionButton(
          onPressed: () {
            Get.bottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  ),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      12.ph,
                      Text(
                        'Choose Request Type',
                        style: Calibri700.copyWith(fontSize: 16),
                      ),
                      16.ph,
                      Obx(
                        () => Column(
                          children: List.generate(
                            controller.typeRequests.length,
                            (index) {
                              return ListTile(
                                onTap: () {
                                  controller.indexTypeRequest.value = index;
                                },
                                minLeadingWidth: 0,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                leading: Text(
                                  controller.typeRequests[index],
                                  style: Calibri400.copyWith(fontSize: 16),
                                ),
                                trailing: Radio(
                                  value: index,
                                  groupValue: controller.indexTypeRequest.value,
                                  onChanged: (val) {
                                    controller.indexTypeRequest.value = index;
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      18.ph,
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: PrimaryButton(
                          onPressed: () {
                            Get.back();
                            if (controller.indexTypeRequest.value == 0) {
                              Get.toNamed("/request");
                            }
                            if (controller.indexTypeRequest.value == 1) {
                              Get.toNamed("/request-training");
                            }
                            controller.indexTypeRequest.value = 99;
                          },
                          textStyle: Calibri700.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          backgroundColor: ColorStyles.genoa,
                          text: "Create a new Request",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ).then((_) {});
          },
          elevation: 0,
          backgroundColor: ColorStyles.genoa,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: const BorderSide(width: 5, color: Colors.white),
          ),
          child: const Icon(
            CupertinoIcons.add,
            color: Colors.white,
            weight: 10,
            size: 30,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 60,
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                child: Column(
                  children: [
                    Container(
                      height: 2,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        // color: colorPrimaryDark,
                      ),
                    ),
                    Obx(
                      () => IconButton(
                        onPressed: () => controller.onChangeTab(0),
                        icon: Icon(
                          CupertinoIcons.house_fill,
                          size: controller.indexTab.value == 0 ? 24 : 20,
                          color:
                              controller.indexTab.value == 0
                                  ? ColorStyles.genoa
                                  : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                child: Column(
                  children: [
                    Container(
                      height: 2,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        // color: colorPrimaryDark,
                      ),
                    ),
                    Obx(
                      () => IconButton(
                        onPressed: () => controller.onChangeTab(1),
                        icon: Icon(
                          Icons.history_rounded,
                          size: controller.indexTab.value == 1 ? 24 : 20,
                          color:
                              controller.indexTab.value == 1
                                  ? ColorStyles.genoa
                                  : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 80),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                child: Column(
                  children: [
                    Container(
                      height: 2,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        // color: colorPrimaryDark,
                      ),
                    ),
                    Obx(
                      () => IconButton(
                        onPressed: () => controller.onChangeTab(2),
                        icon: Icon(
                          Icons.approval_rounded,
                          size: controller.indexTab.value == 2 ? 24 : 20,
                          color:
                              controller.indexTab.value == 2
                                  ? ColorStyles.genoa
                                  : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                child: Column(
                  children: [
                    Container(
                      height: 2,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    Obx(
                      () => IconButton(
                        onPressed: () => controller.onChangeTab(3),
                        icon: Icon(
                          CupertinoIcons.profile_circled,
                          size: controller.indexTab.value == 3 ? 24 : 20,
                          color:
                              controller.indexTab.value == 3
                                  ? ColorStyles.genoa
                                  : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
