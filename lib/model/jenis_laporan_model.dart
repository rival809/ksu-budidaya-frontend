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
  {"id": 2, "nm_laporan": "REALISASI ANGGARAN PENDAPATAN DAN BIAYA"},
  {"id": 3, "nm_laporan": "LAPORAN NERACA LAJUR"},
  {"id": 4, "nm_laporan": "LAPORAN NERACA"},
];
