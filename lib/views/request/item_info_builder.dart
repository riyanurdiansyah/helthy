import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:helthy/controllers/request_controller.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/models/item_m.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:helthy/widgets/filled_primary_textfield.dart';
import 'package:helthy/widgets/primary_button.dart';

class ItemInfoBuilder extends GetView<RequestController> {
  ItemInfoBuilder({super.key, this.data});

  ItemM? data;

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      controller.tcNamaBarang.text = data!.namaItem;
      controller.tcJumlah.text = data!.jumlah.toString();
      controller.tcSatuan.text = data!.satuan;
      controller.tcStatus.text = data!.status;
    }

    return Container(
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
              data == null ? 'Add New Item' : 'Edit Item',
              style: Calibri700.copyWith(fontSize: 16),
            ),
            10.ph,
            FilledPrimaryTextfield(
              style: Calibri400.copyWith(
                fontSize: 18,
                color: ColorStyles.disableBold,
              ),
              labelText: 'Item Name',
              isRequired: true,
              controller: controller.tcNamaBarang,
            ),
            12.ph,
            FilledPrimaryTextfield(
              style: Calibri400.copyWith(
                fontSize: 18,
                color: ColorStyles.disableBold,
              ),
              labelText: 'Quantity',
              isRequired: true,
              controller: controller.tcJumlah,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            12.ph,
            FilledPrimaryTextfield(
              style: Calibri400.copyWith(
                fontSize: 18,
                color: ColorStyles.disableBold,
              ),
              labelText: 'Unit',
              isRequired: true,
              controller: controller.tcSatuan,
            ),
            12.ph,
            FilledPrimaryTextfield(
              style: Calibri400.copyWith(
                fontSize: 18,
                color: ColorStyles.disableBold,
              ),
              labelText: 'Status',
              isRequired: true,
              controller: controller.tcStatus,
            ),
            25.ph,
            SizedBox(
              width: double.infinity,
              height: 45,
              child: PrimaryButton(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                backgroundColor: ColorStyles.genoa,
                text: "SAVE",
                borderRadius: 12,
                textStyle: Calibri700.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
                onPressed: () => controller.saveItem(data: data),
              ),
            ),
            18.ph,
          ],
        ),
      ),
    );
  }
}
