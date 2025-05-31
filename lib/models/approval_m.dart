class ApprovalM {
  final String nama;
  final DateTime tanggal;
  final String status;

  ApprovalM({required this.nama, required this.tanggal, required this.status});

  factory ApprovalM.fromJson(Map<String, dynamic> json) => ApprovalM(
    nama: json['nama'],
    tanggal: DateTime.parse(json['tanggal']),
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'nama': nama,
    'tanggal': tanggal.toIso8601String(),
    'status': status,
  };
}
