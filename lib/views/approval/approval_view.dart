import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/controllers/approval_controller.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:helthy/views/history/tab_card.dart';
import 'package:helthy/views/request/detail_request_view.dart';

class ApprovalView extends GetView<ApprovalController> {
  const ApprovalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Need Your Approval',
          textAlign: TextAlign.center,
          style: Roboto700.copyWith(fontSize: 24, color: ColorStyles.genoa),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.requests.isEmpty) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                70.ph,
                Icon(CupertinoIcons.doc, size: 80, color: Colors.grey.shade500),
                25.ph,
                Text(
                  'Data is empty',
                  textAlign: TextAlign.center,
                  style: Roboto500.copyWith(
                    fontSize: 14.5,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          );
        }
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          children: List.generate(controller.requests.length, (i) {
            return TabCard(
              constStatus: "NEED APPROVAL ",
              ontap: () {
                Get.to(
                  () => DetailRequestView(
                    data: controller.requests[i],
                    isApproval: true,
                    onReject:
                        () => controller.rejectConfirmation(
                          controller.requests[i],
                        ),
                    onApprove:
                        () => controller.approveConfirmation(
                          controller.requests[i],
                        ),
                  ),
                );
              },
              data: controller.requests[i],
            );
          }),
        );
      }),
    );
  }
}
