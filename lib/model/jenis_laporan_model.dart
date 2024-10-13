class ItemLaporan {
  final int id;
  final String nmLaporan;

  ItemLaporan({required this.id, required this.nmLaporan});

  factory ItemLaporan.fromJson(Map<String, dynamic> json) {
    return ItemLaporan(
      id: json['id'],
      nmLaporan: json['nm_laporan'],
    );
  }

  String itemLaporanAsString() {
    return nmLaporan;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nm_laporan': nmLaporan,
    };
  }
}

class JenisLaporan {
  final List<ItemLaporan> listItemLaporan;

  JenisLaporan({required this.listItemLaporan});

  factory JenisLaporan.fromJson(List<dynamic> json) {
    return JenisLaporan(
      listItemLaporan: json.map((e) => ItemLaporan.fromJson(e)).toList(),
    );
  }

  List<Map<String, dynamic>> toJson() {
    return listItemLaporan.map((e) => e.toJson()).toList();
  }
}

List<Map<String, dynamic>> dataItemLaporan = [
  {"id": 1, "nm_laporan": "LAPORAN HASIL USAHA"},
  {"id": 2, "nm_laporan": "Februari"},
  {"id": 3, "nm_laporan": "Maret"},
  {"id": 4, "nm_laporan": "April"},
  {"id": 5, "nm_laporan": "Mei"},
  {"id": 6, "nm_laporan": "Juni"},
  {"id": 7, "nm_laporan": "Juli"},
  {"id": 8, "nm_laporan": "Agustus"},
  {"id": 9, "nm_laporan": "September"},
  {"id": 10, "nm_laporan": "Oktober"},
  {"id": 11, "nm_laporan": "November"},
  {"id": 12, "nm_laporan": "Desember"}
];
