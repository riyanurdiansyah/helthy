import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/controllers/history_controller.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:helthy/views/history/tab_all.dart';
import 'package:helthy/views/history/tab_item.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Your Request',
            textAlign: TextAlign.center,
            style: Roboto700.copyWith(fontSize: 24, color: ColorStyles.genoa),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              color: Colors.white,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  height: 45,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.shade200,
                  ),
                  child: Obx(
                    () => TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      indicator: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelColor: Colors.black,
                      padding: const EdgeInsets.all(2.5),
                      unselectedLabelColor: Colors.grey.shade500,
                      labelStyle: Roboto700.copyWith(
                        fontSize: 12.5,
                        color: ColorStyles.genoa,
                      ),
                      unselectedLabelStyle: Roboto700.copyWith(
                        fontSize: 12.5,
                        color: Colors.black,
                      ),
                      tabs: [
                        TabItem(title: "All (${controller.requests.length})"),
                        TabItem(
                          title:
                              "Approved (${controller.requests.where((request) {
                                if (request.approvals.isEmpty) return false;
                                final sortedApprovals = [...request.approvals]..sort((a, b) => a.tanggal.compareTo(b.tanggal));
                                return sortedApprovals.last.status.toLowerCase() == 'approved';
                              }).toList().length})",
                        ),
                        TabItem(
                          title:
                              "Rejected  (${controller.requests.where((request) {
                                if (request.approvals.isEmpty) return false;
                                final sortedApprovals = [...request.approvals]..sort((a, b) => a.tanggal.compareTo(b.tanggal));
                                return sortedApprovals.last.status.toLowerCase() == 'rejected';
                              }).toList().length})",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            16.ph,
            Obx(() {
              if (controller.isLoading.value) {
                return const SizedBox();
              }
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TabBarView(
                    children: [
                      TabAll(requests: controller.requests),
                      TabAll(
                        requests:
                            controller.requests.where((request) {
                              if (request.approvals.isEmpty) return false;
                              final sortedApprovals = [
                                ...request.approvals,
                              ]..sort((a, b) => a.tanggal.compareTo(b.tanggal));
                              return sortedApprovals.last.status
                                      .toLowerCase() ==
                                  'approved';
                            }).toList(),
                      ),
                      TabAll(
                        requests:
                            controller.requests.where((request) {
                              if (request.approvals.isEmpty) return false;
                              final sortedApprovals = [
                                ...request.approvals,
                              ]..sort((a, b) => a.tanggal.compareTo(b.tanggal));
                              return sortedApprovals.last.status
                                      .toLowerCase() ==
                                  'rejected';
                            }).toList(),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
