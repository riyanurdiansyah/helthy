import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/controllers/dashboard_controller.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/views/history/history_view.dart';
import 'package:helthy/views/home/home_view.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.indexTab.value,
          children: [HomeView(), HistoryView(), Container(), Container()],
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
          onPressed: () => Get.toNamed("/request"),
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
                          Icons.notifications_active_rounded,
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
