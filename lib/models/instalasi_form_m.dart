import 'package:helthy/models/approval_m.dart';
import 'package:helthy/models/item_m.dart';

class InstalasiFormM {
  final String id;
  final String type;
  final String noDokumen;
  final DateTime tanggal;
  final int noRevisi;
  final String namaLab;
  final DateTime tanggalPengajuan;
  final String alamat;
  final String alat;
  final String noTelepon;
  final String merk;
  final String namaKepalaLab;
  final String serialNumber;
  final String penanggungJawabAlat;
  final String noInvoice;
  final String businessRepresentivePerson;
  final String technicalSupport;
  final String fieldServiceEngineer;
  final DateTime tanggalPermintaanPemasangan;
  final DateTime tanggalPemasangan;
  final DateTime tanggalTraining;
  final String catatan;
  final String praInstalasi;
  final DateTime dtCreated;
  final DateTime dtUpdated;
  final List<ItemM> items;
  final List<ApprovalM> approvals;

  InstalasiFormM({
    required this.id,
    required this.type,
    required this.noDokumen,
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
    required this.approvals,
  });

  factory InstalasiFormM.fromJson(Map<String, dynamic> json) => InstalasiFormM(
    id: json['id'],
    type: json['type'],
    noDokumen: json['noDokumen'],
    tanggal: DateTime.parse(json['tanggal']),
    noRevisi: json['noRevisi'],
    namaLab: json['namaLab'],
    tanggalPengajuan: DateTime.parse(json['tanggalPengajuan']),
    alamat: json['alamat'],
    alat: json['alat'],
    noTelepon: json['noTelepon'],
    merk: json['merk'],
    namaKepalaLab: json['namaKepalaLab'],
    serialNumber: json['serialNumber'],
    penanggungJawabAlat: json['penanggungJawabAlat'],
    noInvoice: json['noInvoice'],
    businessRepresentivePerson: json['businessRepresentivePerson'],
    technicalSupport: json['technicalSupport'],
    fieldServiceEngineer: json['fieldServiceEngineer'],
    tanggalPermintaanPemasangan: DateTime.parse(
      json['tanggalPermintaanPemasangan'],
    ),
    tanggalPemasangan: DateTime.parse(json['tanggalPemasangan']),
    tanggalTraining: DateTime.parse(json['tanggalTraining']),
    catatan: json['catatan'],
    praInstalasi: json['praInstalasi'],
    dtCreated: DateTime.parse(json['dtCreated']),
    dtUpdated: DateTime.parse(json['dtUpdated']),
    items: (json['items'] as List).map((e) => ItemM.fromJson(e)).toList(),
    approvals:
        (json['approvals'] as List).map((e) => ApprovalM.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'noDokumen': noDokumen,
    'tanggal': tanggal.toIso8601String(),
    'noRevisi': noRevisi,
    'namaLab': namaLab,
    'tanggalPengajuan': tanggalPengajuan.toIso8601String(),
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
    'tanggalPermintaanPemasangan':
        tanggalPermintaanPemasangan.toIso8601String(),
    'tanggalPemasangan': tanggalPemasangan.toIso8601String(),
    'tanggalTraining': tanggalTraining.toIso8601String(),
    'catatan': catatan,
    'praInstalasi': praInstalasi,
    'dtCreated': dtCreated.toIso8601String(),
    'dtUpdated': dtUpdated.toIso8601String(),
    'items': items.map((e) => e.toJson()).toList(),
    'approvals': approvals.map((e) => e.toJson()).toList(),
  };
}
