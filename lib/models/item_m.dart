class ItemM {
  final String id;
  final String namaItem;
  final int jumlah;
  final String satuan;
  final String status;
  final bool isDeleteable;

  ItemM({
    required this.id,
    required this.namaItem,
    required this.jumlah,
    required this.satuan,
    required this.status,
    required this.isDeleteable,
  });

  factory ItemM.fromJson(Map<String, dynamic> json) => ItemM(
    id: json['id'],
    namaItem: json['namaItem'],
    jumlah: json['jumlah'],
    satuan: json['satuan'],
    status: json['status'],
    isDeleteable: json['isDeleteable'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'namaItem': namaItem,
    'jumlah': jumlah,
    'satuan': satuan,
    'status': status,
    'isDeleteable': false,
  };
}
