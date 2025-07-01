import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/controllers/request_controller.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:helthy/views/request/item_section_request_builder.dart';
import 'package:helthy/widgets/confirmation_dialog.dart';

class RequestTrainingView extends GetView<RequestController> {
  const RequestTrainingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (controller.step.value == 1) {
              Get.back();
            } else {
              controller.step.value = controller.step.value - 1;
              controller.autoScrollController.scrollToIndex(
                controller.step.value - 1,
              );
              controller.pageController?.jumpToPage(controller.step.value - 1);
            }
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (controller.isBasicInfoTrainingValid.value ||
                  controller.step.value > 1) {
                if (controller.step.value <
                    controller.listTrainingPage.length) {
                  controller.step(controller.step.value + 1);
                  controller.autoScrollController.scrollToIndex(
                    controller.step.value,
                  );
                  controller.pageController?.jumpToPage(
                    controller.step.value - 1,
                  );
                } else {
                  Get.dialog(
                    ConfirmationDialog(
                      title:
                          controller.oldRequest.value != null
                              ? 'Update a Request'
                              : 'Create a new request Training',
                      leftButtonText: 'Back',
                      rightButtonText: 'Save',
                      rightButtonAction: () {
                        Get.back();
                        controller.submitRequest("TRAINING/PRESENTASI");
                      },
                      content: Text(
                        'Are you sure want to save?',
                        textAlign: TextAlign.center,
                        style: Calibri400.copyWith(
                          fontSize: 14,
                          color: ColorStyles.disableBold,
                        ),
                      ),
                    ),
                  );
                }
              }
            },
            child: Obx(
              () => Container(
                width: 50,
                height: 40,
                margin: EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      controller.step.value ==
                                  controller.listSectionTraining.length ||
                              (controller.step.value == 1 &&
                                  controller.isBasicInfoTrainingValid.value) ||
                              controller.step.value > 1
                          ? ColorStyles.atlantis100
                          : ColorStyles.disableLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:
                    controller.step.value !=
                            controller.listSectionTraining.length
                        ? Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                          color:
                              controller.step.value ==
                                          controller
                                              .listSectionTraining
                                              .length ||
                                      (controller.step.value == 1 &&
                                          controller
                                              .isBasicInfoTrainingValid
                                              .value) ||
                                      controller.step.value > 1
                                  ? Colors.white
                                  : ColorStyles.disableBold,
                        )
                        : Icon(
                          Icons.save_outlined,
                          size: 24,
                          color: Colors.white,
                        ),
              ),
            ),
          ),
        ],
        title: Obx(
          () => Text(
            controller.oldRequest.value != null ? 'Edit Request' : 'Request',
            textAlign: TextAlign.center,
            style: Roboto700.copyWith(fontSize: 24, color: ColorStyles.white),
          ),
        ),
        elevation: 0,
        backgroundColor: ColorStyles.genoa,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 48,
            color: Colors.white,
            child: ListView.builder(
              controller: controller.autoScrollController,
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.listSectionTraining.length,
              itemBuilder: (context, index) {
                return Obx(
                  () => ItemSectionRequestBuilder(
                    controller: controller,
                    index: index,
                    step: controller.step.value,
                    itemSection: controller.listSectionTraining[index],
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.listTrainingPage.length,
              itemBuilder: (context, index) {
                return controller.listTrainingPage[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}
