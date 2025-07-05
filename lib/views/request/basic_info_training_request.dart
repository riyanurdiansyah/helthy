import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/controllers/request_controller.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:helthy/widgets/filled_primary_textfield.dart';

class BasicInfoTrainingRequest extends GetView<RequestController> {
  const BasicInfoTrainingRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      children: [
        Text(
          'Create a new request Training',
          style: Calibri700.copyWith(fontSize: 16),
        ),
        4.ph,
        Text(
          '1 of 2 Completed Basic Info',
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
          labelText: 'PIC',
          isRequired: true,
          controller: controller.tcPIC,
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
          labelText: 'Divisi RS Yang Meminta',
          isRequired: true,
          textInputAction: TextInputAction.next,
          controller: controller.tcDivisi,
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
          onTap: () => controller.onPickDate(
            controller.tcTanggalPresentasi,
            controller.dtTanggalPresentasi,
          ),
          labelText: 'Tanggal Presentasi',
          isRequired: true,
          readOnly: true,
          controller: controller.tcTanggalPresentasi,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          labelText: 'Online / Offline',
          isRequired: true,
          textInputAction: TextInputAction.next,
          controller: controller.tcOnlineOffline,
        ),
        14.ph,
        FilledPrimaryTextfield(
          style: Calibri400.copyWith(
            fontSize: 18,
            color: ColorStyles.disableBold,
          ),
          labelText: 'Note',
          isRequired: true,
          minLines: 3,
          maxLength: 6,
          textInputAction: TextInputAction.next,
          controller: controller.tcNote,
        ),
      ],
    );
  }
}
