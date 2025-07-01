import 'package:cloud_firestore/cloud_firestore.dart';

class ApprovalM {
  final String nama;
  final Timestamp tanggal;
  final String status;
  final bool isFinalStatus;
  final String signature;

  ApprovalM({
    required this.nama,
    required this.tanggal,
    required this.status,
    required this.isFinalStatus,
    required this.signature,
  });

  factory ApprovalM.fromJson(Map<String, dynamic> json) => ApprovalM(
    nama: json['nama'],
    tanggal: json['tanggal'],
    status: json['status'],
    isFinalStatus: json['isFinalStatus'],
    signature: json['signature'] ?? "",
  );

  Map<String, dynamic> toJson() => {
    'nama': nama,
    'tanggal': tanggal,
    'status': status,
    'isFinalStatus': isFinalStatus,
    'signature': signature,
  };
}
