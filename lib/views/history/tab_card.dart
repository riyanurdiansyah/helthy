import 'package:flutter/material.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/models/instalasi_form_m.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:intl/intl.dart';

class TabCard extends StatelessWidget {
  const TabCard({super.key, this.ontap, required this.data});

  final Function()? ontap;
  final InstalasiFormM data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
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
                      color:
                          data.approvals.isEmpty
                              ? Colors.grey.shade300
                              : (data.approvals..sort(
                                        (a, b) =>
                                            a.tanggal.compareTo(b.tanggal),
                                      ))
                                      .last
                                      .status ==
                                  "Rejected"
                              ? Colors.red
                              : Colors.green,
                    ),
                    child: Text(
                      data.approvals.isEmpty
                          ? "Submitted"
                          : (data.approvals..sort(
                                (a, b) => a.tanggal.compareTo(b.tanggal),
                              ))
                              .last
                              .status,
                      textAlign: TextAlign.center,
                      style: Calibri700.copyWith(
                        fontSize: 12.5,
                        color:
                            data.approvals.isEmpty
                                ? Colors.grey.shade600
                                : ColorStyles.white,
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
              8.ph,
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
            ],
          ),
        ),
      ),
    );
  }
}
