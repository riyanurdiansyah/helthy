import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/models/item_m.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:helthy/views/request/item_content.dart';
import 'package:helthy/widgets/confirmation_dialog.dart';
import 'package:helthy/widgets/custom_container_shadow.dart';

class ItemTrainingCard extends StatelessWidget {
  const ItemTrainingCard({
    super.key,
    required this.data,
    required this.onDetail,
    required this.onDelete,
  });

  final ItemM data;
  final Function() onDetail;

  final Function() onDelete;

  _showDeleteConfirmation() {
    Get.dialog(
      ConfirmationDialog(
        title: 'Hapus Barang',
        leftButtonText: 'Tidak',
        rightButtonText: 'Ya, Hapus',
        rightButtonAction: onDelete,
        content: Text(
          'Kamu yakin ingin menghapus data Barang?',
          textAlign: TextAlign.center,
          style: Calibri400.copyWith(fontSize: 14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainerShadow(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      useBorder: true,
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap:
                    () => data.isDeleteable ? _showDeleteConfirmation() : null,
                child: Row(
                  children: [
                    Icon(CupertinoIcons.delete_solid, color: Colors.red),
                    SizedBox(width: 4),
                    Text(
                      'Hapus',
                      style: Calibri700.copyWith(
                        fontSize: 14,
                        color:
                            data.isDeleteable
                                ? ColorStyles.danger
                                : ColorStyles.disableBold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onDetail,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          'Lihat Detail',
                          style: Calibri700.copyWith(fontSize: 14),
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_ios_rounded),
                    ],
                  ),
                ),
              ),
            ],
          ),
          24.ph,
          Container(
            width: Get.mediaQuery.size.width,
            height: 1,
            color: ColorStyles.disableLight,
          ),
          24.ph,
          Row(
            children: [
              Expanded(
                child: ItemContent(title: "Nama Item", content: data.namaItem),
              ),
              10.pw,
              Expanded(
                child: ItemContent(
                  title: "Total Item",
                  content: "${data.jumlah} ${data.satuan}",
                ),
              ),
            ],
          ),
          18.ph,
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.grey.shade200,
            ),
            child: Text(
              "Keterangan : ${data.status}",
              style: Calibri700.copyWith(
                fontSize: 14,
                color: ColorStyles.genoa,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
