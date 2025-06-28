import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/controllers/history_controller.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/models/instalasi_form_m.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:helthy/views/history/tab_card.dart';
import 'package:helthy/views/request/detail_request_view.dart';

class TabAll extends GetView<HistoryController> {
  const TabAll({super.key, required this.requests});

  final List<InstalasiFormM> requests;

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
      );
    }
    return ListView(
      children: List.generate(requests.length, (i) {
        return TabCard(
          ontap: () {
            Get.to(
              () => DetailRequestView(
                data: requests[i],
                isApproval: false,
                onReject: null,
                onApprove: null,
              ),
            );
          },
          data: requests[i],
        );
      }),
    );
  }
}
