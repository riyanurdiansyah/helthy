import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/controllers/history_controller.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/models/instalasi_form_m.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:intl/intl.dart';

import '../../widgets/outlined_primary_button.dart';
import '../../widgets/primary_button.dart';

class TabCard extends GetView<HistoryController> {
  const TabCard({super.key, this.ontap, required this.data, this.constStatus});

  final Function()? ontap;
  final RequestFormM data;
  final String? constStatus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: ontap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        width: 1,
                        color:
                            constStatus != null
                                ? Colors.grey
                                : data.approvals.isEmpty
                                ? Colors.grey.shade500
                                : data.approvals.last.status == "REJECTED"
                                ? Colors.red
                                : Colors.green,
                      ),
                    ),
                    child: Text(
                      constStatus ??
                          (data.approvals.isEmpty
                              ? "Submitted"
                              : data.approvals.last.status),
                      textAlign: TextAlign.center,
                      style: Calibri700.copyWith(
                        fontSize: 12.5,
                        color:
                            constStatus != null
                                ? Colors.grey
                                : data.approvals.isEmpty
                                ? Colors.grey.shade500
                                : data.approvals.last.status == "REJECTED"
                                ? Colors.red
                                : Colors.green,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0.0),
                    child: Text(
                      data.tanggalPengajuan == null
                          ? "-"
                          : DateFormat(
                            "E, d MMM yyyy",
                          ).format(data.tanggalPengajuan!.toDate()),
                      textAlign: TextAlign.center,
                      style: Calibri700.copyWith(
                        fontSize: 12.5,
                        color: ColorStyles.disable,
                      ),
                    ),
                  ),
                ],
              ),
              14.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.noDokumen,
                        textAlign: TextAlign.center,
                        style: Calibri700.copyWith(
                          fontSize: 16.5,
                          color: ColorStyles.black,
                        ),
                      ),
                      4.ph,
                      Text(
                        data.type,
                        textAlign: TextAlign.center,
                        style: Calibri700.copyWith(
                          fontSize: 12.5,
                          color: ColorStyles.atlantis100,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade300,
                    ),
                    child: Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  ),
                ],
              ),
              if (data.approvals.isNotEmpty &&
                  data.approvals.last.status == "REJECTED")
                16.ph,

              if (data.approvals.isNotEmpty &&
                  data.approvals.last.status == "REJECTED")
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                        backgroundColor: ColorStyles.genoa,
                        text: "Revise",
                        borderRadius: 6,
                        textStyle: Calibri700.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        onPressed:
                            () => Get.toNamed(
                              "/request",
                              arguments: {"data": data},
                            )?.then((_) {
                              controller.getRequests();
                            }),
                      ),
                    ),
                  ],
                ),
              if (data.approvals.isNotEmpty &&
                  data.approvals.last.status != "REJECTED" &&
                  data.approvals.last.status != "APPROVED" &&
                  data.approvals.last.status != "REVISED")
                Row(
                  children: [
                    Expanded(
                      child: OutlinedPrimaryButton(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                        outlinedColor: ColorStyles.danger,
                        text: "Reject",
                        borderRadius: 6,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textStyle: Calibri700.copyWith(
                          fontSize: 16,
                          color: ColorStyles.danger,
                        ),
                        onPressed: () => controller.reject(data),
                      ),
                    ),
                    10.pw,
                    Expanded(
                      child: PrimaryButton(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                        backgroundColor: ColorStyles.genoa,
                        text: "Approve",
                        borderRadius: 6,
                        textStyle: Calibri700.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        onPressed: () => controller.approve(data.id),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
