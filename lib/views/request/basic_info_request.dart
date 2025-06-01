import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/controllers/request_controller.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:helthy/widgets/filled_primary_textfield.dart';

class BasicInfoRequest extends GetView<RequestController> {
  const BasicInfoRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      children: [
        Text('Create a new Request', style: Calibri700.copyWith(fontSize: 16)),
        4.ph,
        Text(
          '1 of 4 Completed Basic Info',
          style: Calibri400.copyWith(fontSize: 16),
        ),
        10.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          labelText: 'No Dokumen',
          isRequired: true,
          controller: controller.tcNoDokumen,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          onTap:
              () => controller.onPickDate(
                controller.tcTanggal,
                controller.dtTanggal,
              ),
          labelText: 'Tanggal Dokumen',
          isRequired: true,
          readOnly: true,
          controller: controller.tcTanggal,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          labelText: 'Alamat',
          isRequired: true,
          controller: controller.tcAlamat,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          labelText: 'No Telepon',
          isRequired: true,
          controller: controller.tcTelepon,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          labelText: 'Kepala Laboratorium',
          isRequired: true,
          controller: controller.tcKepalaLab,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          labelText: 'Penanggung Jawab Alat',
          isRequired: true,
          controller: controller.tcPenanggungJawab,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          onTap:
              () => controller.onPickDate(
                controller.tcTanggalPengajuanForm,
                controller.dtTanggalPengajuanForm,
              ),
          labelText: 'Tanggal Pengajuan Form',
          isRequired: true,
          readOnly: true,
          controller: controller.tcTanggalPengajuanForm,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          labelText: 'Alat',
          isRequired: true,
          controller: controller.tcAlat,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          labelText: 'Merk',
          isRequired: true,
          controller: controller.tcMerk,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          labelText: 'Serial Number',
          isRequired: true,
          controller: controller.tcSerialNumber,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          labelText: 'No SPK/Invoice',
          isRequired: true,
          controller: controller.tcInvoice,
        ),
      ],
    );
  }
}
