import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helthy/models/approval_m.dart';
import 'package:helthy/models/item_m.dart';

class RequestFormM {
  String id;
  String type;
  String noDokumen;
  String createdBy;
  Timestamp? tanggal;
  int noRevisi;
  String namaLab;
  Timestamp? tanggalPengajuan;
  String alamat;
  String alat;
  String noTelepon;
  String merk;
  String namaKepalaLab;
  String serialNumber;
  String penanggungJawabAlat;
  String noInvoice;
  String businessRepresentivePerson;
  String technicalSupport;
  String fieldServiceEngineer;
  Timestamp? tanggalPermintaanPemasangan;
  Timestamp? tanggalPemasangan;
  Timestamp? tanggalTraining;
  String catatan;
  String praInstalasi;
  Timestamp? dtCreated;
  Timestamp? dtUpdated;
  List<ItemM> items;
  List<ItemM> accesories;
  List<ApprovalM> approvals;
  String namaRS;
  String divisi;
  String namaBR;
  Timestamp? tanggalPresentasi;
  String onlineOffline;
  String pic;

  RequestFormM({
    required this.id,
    required this.type,
    required this.noDokumen,
    required this.createdBy,
    required this.tanggal,
    required this.noRevisi,
    required this.namaLab,
    required this.tanggalPengajuan,
    required this.alamat,
    required this.alat,
    required this.noTelepon,
    required this.merk,
    required this.namaKepalaLab,
    required this.serialNumber,
    required this.penanggungJawabAlat,
    required this.noInvoice,
    required this.businessRepresentivePerson,
    required this.technicalSupport,
    required this.fieldServiceEngineer,
    required this.tanggalPermintaanPemasangan,
    required this.tanggalPemasangan,
    required this.tanggalTraining,
    required this.catatan,
    required this.praInstalasi,
    required this.dtCreated,
    required this.dtUpdated,
    required this.items,
    required this.accesories,
    required this.approvals,
    required this.namaRS,
    required this.namaBR,
    required this.tanggalPresentasi,
    required this.divisi,
    required this.onlineOffline,
    required this.pic,
  });
  factory RequestFormM.fromJson(Map<String, dynamic> json) => RequestFormM(
    id: json['id'] ?? '',
    type: json['type'] ?? '',
    noDokumen: json['noDokumen'] ?? '',
    createdBy: json['createdBy'] ?? '',
    tanggal: json['tanggal'],
    noRevisi: json['noRevisi'] ?? 0,
    namaLab: json['namaLab'] ?? '',
    tanggalPengajuan: json['tanggalPengajuan'],
    alamat: json['alamat'] ?? '',
    alat: json['alat'] ?? '',
    noTelepon: json['noTelepon'] ?? '',
    merk: json['merk'] ?? '',
    namaKepalaLab: json['namaKepalaLab'] ?? '',
    serialNumber: json['serialNumber'] ?? '',
    penanggungJawabAlat: json['penanggungJawabAlat'] ?? '',
    noInvoice: json['noInvoice'] ?? '',
    businessRepresentivePerson: json['businessRepresentivePerson'] ?? '',
    technicalSupport: json['technicalSupport'] ?? '',
    fieldServiceEngineer: json['fieldServiceEngineer'] ?? '',
    tanggalPermintaanPemasangan: json['tanggalPermintaanPemasangan'],
    tanggalPemasangan: json['tanggalPemasangan'],
    tanggalTraining: json['tanggalTraining'],
    catatan: json['catatan'] ?? '',
    praInstalasi: json['praInstalasi'] ?? '',
    dtCreated: json['dtCreated'],
    dtUpdated: json['dtUpdated'],
    items:
        (json['items'] as List?)?.map((e) => ItemM.fromJson(e)).toList() ?? [],
    accesories:
        (json['accesories'] as List?)?.map((e) => ItemM.fromJson(e)).toList() ??
        [],
    approvals:
        (json['approvals'] as List?)
            ?.map((e) => ApprovalM.fromJson(e))
            .toList() ??
        [],
    namaRS: json["namaRS"] ?? "",
    namaBR: json["namaBR"] ?? "",
    divisi: json["divisi"] ?? "",
    onlineOffline: json["onlineOffline"] ?? "",
    tanggalPresentasi: json["tanggalPresentasi"],
    pic: json["pic"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'noDokumen': noDokumen,
    'createdBy': createdBy,
    'tanggal': tanggal,
    'noRevisi': noRevisi,
    'namaLab': namaLab,
    'tanggalPengajuan': tanggalPengajuan,
    'alamat': alamat,
    'alat': alat,
    'noTelepon': noTelepon,
    'merk': merk,
    'namaKepalaLab': namaKepalaLab,
    'serialNumber': serialNumber,
    'penanggungJawabAlat': penanggungJawabAlat,
    'noInvoice': noInvoice,
    'businessRepresentivePerson': businessRepresentivePerson,
    'technicalSupport': technicalSupport,
    'fieldServiceEngineer': fieldServiceEngineer,
    'tanggalPermintaanPemasangan': tanggalPermintaanPemasangan,
    'tanggalPemasangan': tanggalPemasangan,
    'tanggalTraining': tanggalTraining,
    'catatan': catatan,
    'praInstalasi': praInstalasi,
    'dtCreated': dtCreated,
    'dtUpdated': dtUpdated,
    'items': items.map((e) => e.toJson()).toList(),
    'accesories': accesories.map((e) => e.toJson()).toList(),
    'approvals': approvals.map((e) => e.toJson()).toList(),
    'namaRS': namaRS,
    'namaBR': namaBR,
    'tanggalPresentasi': tanggalPresentasi,
    'divisi': divisi,
    'onlineOffline': onlineOffline,
    'pic': pic,
  };
}
