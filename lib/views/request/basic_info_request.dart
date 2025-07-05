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
        Text(
          'Create a new request Instalasi',
          style: Calibri700.copyWith(fontSize: 16),
        ),
        4.ph,
        Text(
          '1 of 3 Completed Basic Info',
          style: Calibri400.copyWith(fontSize: 16),
        ),
        10.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          labelText: 'No Dokumen',
          textInputAction: TextInputAction.next,
          isRequired: true,
          controller: controller.tcNoDokumen,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          onTap: () => controller.onPickDate(
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
          labelText: 'Nama RS/Lab',
          isRequired: true,
          controller: controller.tcNamaRS,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          onTap: () => controller.onPickDate(
            controller.tcTanggalPengajuanForm,
            controller.dtTanggalPengajuanForm,
          ),
          labelText: 'Tanggal Pengajuan Form',
          isRequired: true,
          readOnly: true,
          textInputAction: TextInputAction.next,
          controller: controller.tcTanggalPengajuanForm,
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
          labelText: 'Alat',
          isRequired: true,
          textInputAction: TextInputAction.next,
          controller: controller.tcAlat,
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
          labelText: 'Merk',
          isRequired: true,
          textInputAction: TextInputAction.next,
          controller: controller.tcMerk,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          labelText: 'Kepala Laboratorium',
          isRequired: true,
          textInputAction: TextInputAction.next,
          controller: controller.tcKepalaLab,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          labelText: 'Serial Number',
          isRequired: true,
          textInputAction: TextInputAction.next,
          controller: controller.tcSerialNumber,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          labelText: 'Penanggung Jawab Alat',
          isRequired: true,
          textInputAction: TextInputAction.next,
          controller: controller.tcPenanggungJawab,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          textInputAction: TextInputAction.next,
          labelText: 'No SPK/Invoice',
          isRequired: true,
          controller: controller.tcInvoice,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          labelText: 'Business Representative Person',
          isRequired: true,
          textInputAction: TextInputAction.next,
          controller: controller.tcBusinessRepresentative,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          labelText: 'Technical Support',
          isRequired: true,
          textInputAction: TextInputAction.next,
          controller: controller.tcTechnicalSupp,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          labelText: 'Field Service Engineer',
          isRequired: true,
          textInputAction: TextInputAction.next,
          controller: controller.tcFieldServiceEngineer,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          onTap: () => controller.onPickDate(
            controller.tcTanggalPermintaanPemasangan,
            controller.dtTanggalPermintaanPemasangan,
          ),
          labelText: 'Tanggal Permintaan Pemasangan',
          isRequired: true,
          readOnly: true,
          textInputAction: TextInputAction.next,
          controller: controller.tcTanggalPermintaanPemasangan,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          onTap: () => controller.onPickDate(
            controller.tcTanggalPemasangan,
            controller.dtTanggalPemasangan,
          ),
          labelText: 'Tanggal Pemasangan',
          isRequired: true,
          readOnly: true,
          textInputAction: TextInputAction.next,
          controller: controller.tcTanggalPemasangan,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          onTap: () => controller.onPickDate(
            controller.tcTanggalTraining,
            controller.dtTanggalTraining,
          ),
          labelText: 'Tanggal Training',
          isRequired: true,
          readOnly: true,
          textInputAction: TextInputAction.next,
          controller: controller.tcTanggalTraining,
        ),
      ],
    );
  }
}
