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
            'History',
            textAlign: TextAlign.center,
            style: Roboto700.copyWith(fontSize: 24, color: ColorStyles.genoa),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 45,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey.shade300,
                ),
                child: TabBar(
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
                    TabItem(title: "All"),
                    TabItem(title: "Approved"),
                    TabItem(title: "Rejected"),
                  ],
                ),
              ),
            ),
            16.ph,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TabBarView(
                  children: [TabAll(), const SizedBox(), const SizedBox()],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
