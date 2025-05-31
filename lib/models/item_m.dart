class ItemM {
  final String namaItem;
  final int jumlah;
  final String satuan;
  final String status;

  ItemM({
    required this.namaItem,
    required this.jumlah,
    required this.satuan,
    required this.status,
  });

  factory ItemM.fromJson(Map<String, dynamic> json) => ItemM(
    namaItem: json['namaItem'],
    jumlah: json['jumlah'],
    satuan: json['satuan'],
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'namaItem': namaItem,
    'jumlah': jumlah,
    'satuan': satuan,
    'status': status,
  };
}
