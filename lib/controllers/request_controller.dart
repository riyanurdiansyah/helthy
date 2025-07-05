import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/controllers/dashboard_controller.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/models/approval_m.dart';
import 'package:helthy/models/instalasi_form_m.dart';
import 'package:helthy/models/item_m.dart';
import 'package:helthy/models/profile_m.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/utils/dialogs.dart';
import 'package:helthy/utils/prefs.dart';
import 'package:helthy/views/request/accesories_info_builder.dart';
import 'package:helthy/views/request/accesories_info_request.dart';
import 'package:helthy/views/request/basic_info_request.dart';
import 'package:helthy/views/request/basic_info_training_request.dart';
import 'package:helthy/views/request/item_info_builder.dart';
import 'package:helthy/views/request/item_info_request.dart';
import 'package:helthy/views/request/item_info_training_request.dart';
import 'package:intl/intl.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class RequestController extends GetxController {
  final _dC = Get.find<DashboardController>();
  final Rxn<ProfileM> profile = Rxn<ProfileM>();

  final tcNoDokumen = TextEditingController();
  final tcTanggal = TextEditingController();
  final tcTanggalPresentasi = TextEditingController();
  final tcRevisi = TextEditingController(text: "1");
  final tcNamaRS = TextEditingController();
  final tcPIC = TextEditingController();
  final tcAlamat = TextEditingController();
  final tcTelepon = TextEditingController();
  final tcKepalaLab = TextEditingController();
  final tcDivisi = TextEditingController();
  final tcPenanggungJawab = TextEditingController();
  final tcAlat = TextEditingController();
  final tcTanggalPengajuanForm = TextEditingController();
  final tcMerk = TextEditingController();
  final tcOnlineOffline = TextEditingController();
  final tcNote = TextEditingController();
  final tcSerialNumber = TextEditingController();
  final tcInvoice = TextEditingController();
  final tcBusinessRepresentative = TextEditingController();
  final tcTechnicalSupp = TextEditingController();
  final tcFieldServiceEngineer = TextEditingController();
  final tcTanggalPermintaanPemasangan = TextEditingController();
  final tcTanggalPemasangan = TextEditingController();
  final tcTanggalTraining = TextEditingController();
  final tcPraInstalasi = TextEditingController();

  final tcNamaBarang = TextEditingController();
  final tcJumlah = TextEditingController();
  final tcSatuan = TextEditingController();
  final tcStatus = TextEditingController();

  final Rxn<DateTime> dtTanggal = Rxn<DateTime>();
  final Rxn<DateTime> dtTanggalTraining = Rxn<DateTime>();
  final Rxn<DateTime> dtTanggalPemasangan = Rxn<DateTime>();
  final Rxn<DateTime> dtTanggalPermintaanPemasangan = Rxn<DateTime>();
  final Rxn<DateTime> dtTanggalPengajuanForm = Rxn<DateTime>();
  final Rxn<DateTime> dtTanggalPresentasi = Rxn<DateTime>();

  final RxList<ItemM> items = <ItemM>[].obs;
  final RxList<ItemM> accecories = <ItemM>[].obs;

  final RxBool isBasicInfoValid = false.obs;
  final RxBool isBasicInfoTrainingValid = false.obs;

  final Rxn<RequestFormM> oldRequest = Rxn<RequestFormM>();

  PageController? pageController = PageController(initialPage: 0);
  final AutoScrollController autoScrollController = AutoScrollController(
    axis: Axis.horizontal,
  );

  RxInt step = 1.obs;

  List<Map<String, dynamic>> listSection = [
    {"id": 1, "step": "Basic Info"},
    {"id": 2, "step": "Item Info"},
    {"id": 3, "step": "Accesories Info"},
  ];

  List<Map<String, dynamic>> listSectionTraining = [
    {"id": 1, "step": "Basic Info"},
    {"id": 2, "step": "Item Info"},
  ];

  List<Widget> listPage = [
    BasicInfoRequest(),
    ItemRequest(),
    AccesoriesInfoRequest(),
  ];

  List<Widget> listTrainingPage = [
    BasicInfoTrainingRequest(),
    ItemTrainingRequest(),
  ];

  @override
  void onInit() {
    super.onInit();
    getProfile();
    List<TextEditingController> controllers = [
      tcNoDokumen,
      tcTanggal,
      tcAlamat,
      tcTelepon,
      tcKepalaLab,
      tcPenanggungJawab,
      tcTanggalPengajuanForm,
      tcAlat,
      tcMerk,
      tcSerialNumber,
      tcInvoice,
      tcBusinessRepresentative,
      tcTechnicalSupp,
      tcOnlineOffline,
      tcDivisi,
      tcNamaRS,
      tcTanggalPresentasi,
      tcPIC,
      tcTechnicalSupp,
      tcFieldServiceEngineer,
      tcTechnicalSupp,
      tcTanggalPermintaanPemasangan,
      tcTanggalPemasangan,
      tcTanggalTraining,
    ];

    for (var c in controllers) {
      c.addListener(validateBasicInfo);
      c.addListener(validateBasicInfoTraining);
    }

    if (Get.arguments != null) {
      if (Get.arguments["data"] is RequestFormM) {
        oldRequest.value = Get.arguments["data"];
        setOldData();
      }
    }
  }

  void setOldData() {
    final data = oldRequest.value!;
    tcNoDokumen.text = data.noDokumen;
    tcAlamat.text = data.alamat;
    tcTelepon.text = data.noTelepon;
    tcKepalaLab.text = data.namaKepalaLab;
    tcPenanggungJawab.text = data.namaKepalaLab;
    tcAlat.text = data.alat;
    tcMerk.text = data.merk;
    tcSerialNumber.text = data.serialNumber;
    tcInvoice.text = data.noInvoice;
    tcNamaRS.text = data.namaRS;
    tcBusinessRepresentative.text = data.businessRepresentivePerson;
    tcTechnicalSupp.text = data.technicalSupport;
    tcFieldServiceEngineer.text = data.fieldServiceEngineer;

    tcTanggal.text = oldRequest.value?.tanggal == null
        ? ""
        : DateFormat("dd MMM yyyy").format(data.tanggal!.toDate());
    dtTanggal.value = oldRequest.value?.tanggal?.toDate();

    tcTanggalPengajuanForm.text = oldRequest.value?.tanggalPengajuan == null
        ? ""
        : DateFormat("dd MMM yyyy").format(data.tanggalPengajuan!.toDate());
    dtTanggalPengajuanForm.value = oldRequest.value?.tanggalPengajuan?.toDate();

    tcTanggalPermintaanPemasangan.text =
        oldRequest.value?.tanggalPermintaanPemasangan == null
            ? ""
            : DateFormat("dd MMM yyyy")
                .format(data.tanggalPermintaanPemasangan!.toDate());
    dtTanggalPermintaanPemasangan.value =
        oldRequest.value?.tanggalPermintaanPemasangan?.toDate();

    tcTanggalPemasangan.text = oldRequest.value?.tanggalPemasangan == null
        ? ""
        : DateFormat("dd MMM yyyy").format(data.tanggalPemasangan!.toDate());
    dtTanggalPemasangan.value = oldRequest.value?.tanggalPemasangan?.toDate();

    tcTanggalTraining.text = oldRequest.value?.tanggalTraining == null
        ? ""
        : DateFormat("dd MMM yyyy").format(data.tanggalTraining!.toDate());
    dtTanggalTraining.value = oldRequest.value?.tanggalTraining?.toDate();

    items.value = data.items;
    accecories.value = data.accesories;
  }

  void getProfile() async {
    final prof = SharedPrefs().getString("profile");
    profile.value = ProfileM.fromJson(jsonDecode(prof!));
  }

  void validateBasicInfo() {
    isBasicInfoValid.value = tcNoDokumen.text.isNotEmpty &&
        tcTanggal.text.isNotEmpty &&
        tcAlamat.text.isNotEmpty &&
        tcTelepon.text.isNotEmpty &&
        tcKepalaLab.text.isNotEmpty &&
        tcPenanggungJawab.text.isNotEmpty &&
        tcTanggalPengajuanForm.text.isNotEmpty &&
        tcAlat.text.isNotEmpty &&
        tcMerk.text.isNotEmpty &&
        tcSerialNumber.text.isNotEmpty &&
        tcBusinessRepresentative.text.isNotEmpty &&
        tcTechnicalSupp.text.isNotEmpty &&
        tcFieldServiceEngineer.text.isNotEmpty &&
        tcTanggalPemasangan.text.isNotEmpty &&
        tcTanggalTraining.text.isNotEmpty &&
        tcInvoice.text.isNotEmpty;
  }

  void validateBasicInfoTraining() {
    isBasicInfoTrainingValid.value = tcNoDokumen.text.isNotEmpty &&
        tcTanggal.text.isNotEmpty &&
        tcNamaRS.text.isNotEmpty &&
        tcDivisi.text.isNotEmpty &&
        tcAlamat.text.isNotEmpty &&
        tcTelepon.text.isNotEmpty &&
        tcTanggalPengajuanForm.text.isNotEmpty &&
        tcBusinessRepresentative.text.isNotEmpty &&
        tcTechnicalSupp.text.isNotEmpty &&
        tcTanggalPresentasi.text.isNotEmpty &&
        tcOnlineOffline.text.isNotEmpty &&
        tcPIC.text.isNotEmpty &&
        tcMerk.text.isNotEmpty;
  }

  void onPickDate(TextEditingController tc, Rxn<DateTime> dt) async {
    final data = await AppDialog.datePicker(
      firstDate: DateTime.now(),
      backDates: DateTime.now().subtract(Duration(days: 30)),
    );
    if (data != null) {
      tc.text = DateFormat("dd MMM yyyy").format(data);
      dt.value = data;
    }
  }

  showItem({ItemM? data, String? nameColumn3}) {
    Get.bottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      ItemInfoBuilder(data: data, nameColumn3: nameColumn3),
      isScrollControlled: true,
    ).then((_) {
      clearBarang();
    });
  }

  showAccesory({ItemM? data}) {
    Get.bottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      AccesoriesInfoBuilder(data: data),
      isScrollControlled: true,
    ).then((_) {
      clearBarang();
    });
  }

  void saveItem({ItemM? data}) {
    Get.back();
    if (data == null) {
      items.add(
        ItemM(
          namaItem: tcNamaBarang.text,
          jumlah: int.parse(tcJumlah.text),
          satuan: tcSatuan.text,
          status: tcStatus.text,
          id: generateUuidV4(),
          isDeleteable: true,
        ),
      );
    } else {
      final index = items.indexWhere((item) => item.id == data.id);
      if (index != -1) {
        items[index] = ItemM(
          id: data.id,
          namaItem: tcNamaBarang.text,
          jumlah: int.tryParse(tcJumlah.text) ?? data.jumlah,
          satuan: tcSatuan.text,
          status: tcStatus.text,
          isDeleteable: data.isDeleteable,
        );
      }
    }
    clearBarang();
  }

  void saveAccesory({ItemM? data}) {
    Get.back();
    if (data == null) {
      accecories.add(
        ItemM(
          namaItem: tcNamaBarang.text,
          jumlah: int.parse(tcJumlah.text),
          satuan: tcSatuan.text,
          status: tcStatus.text,
          id: generateUuidV4(),
          isDeleteable: true,
        ),
      );
    } else {
      final index = accecories.indexWhere((item) => item.id == data.id);
      if (index != -1) {
        accecories[index] = ItemM(
          id: data.id,
          namaItem: tcNamaBarang.text,
          jumlah: int.tryParse(tcJumlah.text) ?? data.jumlah,
          satuan: tcSatuan.text,
          status: tcStatus.text,
          isDeleteable: data.isDeleteable,
        );
      }
    }
    clearBarang();
  }

  void clearBarang() {
    tcNamaBarang.clear();
    tcJumlah.clear();
    tcSatuan.clear();
    tcStatus.clear();
  }

  void doDeleteItem(String id) {
    Get.back();
    items.removeWhere((e) => e.id == id);
  }

  void doDeleteAcc(String id) {
    Get.back();
    accecories.removeWhere((e) => e.id == id);
  }

  bool isBasicInfoComplete() {
    return tcNoDokumen.text.isNotEmpty &&
        tcTanggal.text.isNotEmpty &&
        tcAlamat.text.isNotEmpty &&
        tcTelepon.text.isNotEmpty &&
        tcKepalaLab.text.isNotEmpty &&
        tcPenanggungJawab.text.isNotEmpty &&
        tcTanggalPengajuanForm.text.isNotEmpty &&
        tcAlat.text.isNotEmpty &&
        tcMerk.text.isNotEmpty &&
        tcSerialNumber.text.isNotEmpty &&
        tcInvoice.text.isNotEmpty;
  }

  void submitRequest(String type) async {
    final request = RequestFormM(
      pic: tcPIC.text,
      namaRS: tcNamaRS.text,
      divisi: tcDivisi.text,
      onlineOffline: tcOnlineOffline.text,
      tanggalPresentasi: dtTanggalPresentasi.value == null
          ? null
          : Timestamp.fromDate(dtTanggalPresentasi.value!),
      createdBy: profile.value?.username ?? "-",
      id: oldRequest.value != null ? oldRequest.value!.id : generateUuidV4(),
      type: type,
      noDokumen: tcNoDokumen.text,
      tanggal:
          dtTanggal.value == null ? null : Timestamp.fromDate(dtTanggal.value!),
      noRevisi: int.tryParse(tcRevisi.text) ?? 0,
      tanggalPengajuan: dtTanggalPengajuanForm.value == null
          ? null
          : Timestamp.fromDate(dtTanggalPengajuanForm.value!),
      alamat: tcAlamat.text,
      alat: tcAlat.text,
      noTelepon: tcTelepon.text,
      merk: tcMerk.text,
      namaKepalaLab: tcKepalaLab.text,
      serialNumber: tcSerialNumber.text,
      penanggungJawabAlat: tcPenanggungJawab.text,
      noInvoice: tcInvoice.text,
      businessRepresentivePerson: tcBusinessRepresentative.text,
      technicalSupport: tcTechnicalSupp.text,
      fieldServiceEngineer: tcFieldServiceEngineer.text,
      tanggalPermintaanPemasangan: dtTanggalPermintaanPemasangan.value == null
          ? null
          : Timestamp.fromDate(dtTanggalPermintaanPemasangan.value!),
      tanggalPemasangan: dtTanggalPemasangan.value == null
          ? null
          : Timestamp.fromDate(dtTanggalPemasangan.value!),
      tanggalTraining: dtTanggalTraining.value == null
          ? null
          : Timestamp.fromDate(dtTanggalTraining.value!),
      catatan: "",
      praInstalasi: tcPraInstalasi.text,
      dtCreated: Timestamp.now(),
      dtUpdated: Timestamp.now(),
      items: items,
      accesories: accecories,
      approvals: oldRequest.value != null ? oldRequest.value!.approvals : [],
    );
    if (oldRequest.value != null) {
      final data = ApprovalM(
        nama: _dC.profile.value!.username,
        tanggal: Timestamp.now(),
        status: "REVISED",
        isFinalStatus: false,
        signature: "",
      );
      request.approvals.add(data);
    }
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore
          .collection("requests")
          .doc(request.id)
          .set(request.toJson());

      Get.back();
      Get.snackbar(
        'Info',
        'Success submit request',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorStyles.genoa,
        margin: const EdgeInsets.all(14),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to submit: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorStyles.danger,
        margin: const EdgeInsets.all(14),
        colorText: Colors.white,
      );
    }
  }
}
