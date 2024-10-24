// To parse this JSON data, do
//
//     final laporanRealisasiPendapatan = laporanRealisasiPendapatanFromJson(jsonString);

import 'dart:convert';

LaporanRealisasiPendapatanResult laporanRealisasiPendapatanFromJson(
        String str) =>
    LaporanRealisasiPendapatanResult.fromJson(json.decode(str));

String laporanRealisasiPendapatanToJson(
        LaporanRealisasiPendapatanResult data) =>
    json.encode(data.toJson());

class LaporanRealisasiPendapatanResult {
  bool? success;
  DataRealisasiPendapatan? data;
  String? message;

  LaporanRealisasiPendapatanResult({
    this.success,
    this.data,
    this.message,
  });

  factory LaporanRealisasiPendapatanResult.fromJson(
          Map<String, dynamic> json) =>
      LaporanRealisasiPendapatanResult(
        success: json["success"],
        data: json["data"] == null
            ? null
            : DataRealisasiPendapatan.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class DataRealisasiPendapatan {
  Pendapatan? pendapatan;
  Pengeluaran? pengeluaran;
  SisaHasilUsaha? sisaHasilUsaha;

  DataRealisasiPendapatan({
    this.pendapatan,
    this.pengeluaran,
    this.sisaHasilUsaha,
  });

  factory DataRealisasiPendapatan.fromJson(Map<String, dynamic> json) =>
      DataRealisasiPendapatan(
        pendapatan: json["pendapatan"] == null
            ? null
            : Pendapatan.fromJson(json["pendapatan"]),
        pengeluaran: json["pengeluaran"] == null
            ? null
            : Pengeluaran.fromJson(json["pengeluaran"]),
        sisaHasilUsaha: json["sisa_hasil_usaha"] == null
            ? null
            : SisaHasilUsaha.fromJson(json["sisa_hasil_usaha"]),
      );

  Map<String, dynamic> toJson() => {
        "pendapatan": pendapatan?.toJson(),
        "pengeluaran": pengeluaran?.toJson(),
        "sisa_hasil_usaha": sisaHasilUsaha?.toJson(),
      };
}

class Pendapatan {
  HasilUsahaWaserda? hasilUsahaWaserda;
  ReturPembelian? returPembelian;
  PendapatanLainlain? pendapatanLainlain;
  TotalPendapatanPerBulan? totalPendapatanPerBulan;

  Pendapatan({
    this.hasilUsahaWaserda,
    this.returPembelian,
    this.pendapatanLainlain,
    this.totalPendapatanPerBulan,
  });

  factory Pendapatan.fromJson(Map<String, dynamic> json) => Pendapatan(
        hasilUsahaWaserda: json["hasil_usaha_waserda"] == null
            ? null
            : HasilUsahaWaserda.fromJson(json["hasil_usaha_waserda"]),
        returPembelian: json["retur_pembelian"] == null
            ? null
            : ReturPembelian.fromJson(json["retur_pembelian"]),
        pendapatanLainlain: json["pendapatan_lainlain"] == null
            ? null
            : PendapatanLainlain.fromJson(json["pendapatan_lainlain"]),
        totalPendapatanPerBulan: json["total_pendapatan_per_bulan"] == null
            ? null
            : TotalPendapatanPerBulan.fromJson(
                json["total_pendapatan_per_bulan"]),
      );

  Map<String, dynamic> toJson() => {
        "hasil_usaha_waserda": hasilUsahaWaserda?.toJson(),
        "retur_pembelian": returPembelian?.toJson(),
        "pendapatan_lainlain": pendapatanLainlain?.toJson(),
        "total_pendapatan_per_bulan": totalPendapatanPerBulan?.toJson(),
      };
}

class HasilUsahaWaserda {
  int? jumlah;
  List<HasilUsahaWaserdaDatum>? data;

  HasilUsahaWaserda({
    this.jumlah,
    this.data,
  });

  factory HasilUsahaWaserda.fromJson(Map<String, dynamic> json) =>
      HasilUsahaWaserda(
        jumlah: json["jumlah"],
        data: json["data"] == null
            ? []
            : List<HasilUsahaWaserdaDatum>.from(
                json["data"]!.map((x) => HasilUsahaWaserdaDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "jumlah": jumlah,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class HasilUsahaWaserdaDatum {
  String? bulan;
  int? totalNilaiJual;

  HasilUsahaWaserdaDatum({
    this.bulan,
    this.totalNilaiJual,
  });

  factory HasilUsahaWaserdaDatum.fromJson(Map<String, dynamic> json) =>
      HasilUsahaWaserdaDatum(
        bulan: json["bulan"],
        totalNilaiJual: json["total_nilai_jual"],
      );

  Map<String, dynamic> toJson() => {
        "bulan": bulan,
        "total_nilai_jual": totalNilaiJual,
      };
}

class PendapatanLainlain {
  double? jumlah;
  List<PendapatanLainlainDatum>? data;

  PendapatanLainlain({
    this.jumlah,
    this.data,
  });

  factory PendapatanLainlain.fromJson(Map<String, dynamic> json) =>
      PendapatanLainlain(
        jumlah: json["jumlah"]?.toDouble(),
        data: json["data"] == null
            ? []
            : List<PendapatanLainlainDatum>.from(
                json["data"]!.map((x) => PendapatanLainlainDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "jumlah": jumlah,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PendapatanLainlainDatum {
  String? bulan;
  double? nominal;

  PendapatanLainlainDatum({
    this.bulan,
    this.nominal,
  });

  factory PendapatanLainlainDatum.fromJson(Map<String, dynamic> json) =>
      PendapatanLainlainDatum(
        bulan: json["bulan"],
        nominal: json["nominal"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "bulan": bulan,
        "nominal": nominal,
      };
}

class ReturPembelian {
  int? jumlah;
  List<ReturPembelianDatum>? data;

  ReturPembelian({
    this.jumlah,
    this.data,
  });

  factory ReturPembelian.fromJson(Map<String, dynamic> json) => ReturPembelian(
        jumlah: json["jumlah"],
        data: json["data"] == null
            ? []
            : List<ReturPembelianDatum>.from(
                json["data"]!.map((x) => ReturPembelianDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "jumlah": jumlah,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ReturPembelianDatum {
  String? bulan;
  int? totalNilaiBeli;

  ReturPembelianDatum({
    this.bulan,
    this.totalNilaiBeli,
  });

  factory ReturPembelianDatum.fromJson(Map<String, dynamic> json) =>
      ReturPembelianDatum(
        bulan: json["bulan"],
        totalNilaiBeli: json["total_nilai_beli"],
      );

  Map<String, dynamic> toJson() => {
        "bulan": bulan,
        "total_nilai_beli": totalNilaiBeli,
      };
}

class TotalPendapatanPerBulan {
  int? jumlah;
  List<TotalPendapatanPerBulanDatum>? data;

  TotalPendapatanPerBulan({
    this.jumlah,
    this.data,
  });

  factory TotalPendapatanPerBulan.fromJson(Map<String, dynamic> json) =>
      TotalPendapatanPerBulan(
        jumlah: json["jumlah"],
        data: json["data"] == null
            ? []
            : List<TotalPendapatanPerBulanDatum>.from(json["data"]!
                .map((x) => TotalPendapatanPerBulanDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "jumlah": jumlah,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TotalPendapatanPerBulanDatum {
  String? bulan;
  int? totalPendapatan;

  TotalPendapatanPerBulanDatum({
    this.bulan,
    this.totalPendapatan,
  });

  factory TotalPendapatanPerBulanDatum.fromJson(Map<String, dynamic> json) =>
      TotalPendapatanPerBulanDatum(
        bulan: json["bulan"],
        totalPendapatan: json["total_pendapatan"],
      );

  Map<String, dynamic> toJson() => {
        "bulan": bulan,
        "total_pendapatan": totalPendapatan,
      };
}

class Pengeluaran {
  PendapatanLainlain? bebanGaji;
  PendapatanLainlain? uangMakan;
  PendapatanLainlain? thr;
  PendapatanLainlain? bebanAdmUmum;
  PendapatanLainlain? bebanPerlengkapan;
  PendapatanLainlain? bebanPenyusutanInventaris;
  PendapatanLainlain? bebanPenyusutanGedung;
  PendapatanLainlain? pemeliharaanInventaris;
  PendapatanLainlain? pemeliharaanGedung;
  TotalPengeluaraanPerBulan? totalPengeluaraanPerBulan;

  Pengeluaran({
    this.bebanGaji,
    this.uangMakan,
    this.thr,
    this.bebanAdmUmum,
    this.bebanPerlengkapan,
    this.bebanPenyusutanInventaris,
    this.bebanPenyusutanGedung,
    this.pemeliharaanInventaris,
    this.pemeliharaanGedung,
    this.totalPengeluaraanPerBulan,
  });

  factory Pengeluaran.fromJson(Map<String, dynamic> json) => Pengeluaran(
        bebanGaji: json["beban_gaji"] == null
            ? null
            : PendapatanLainlain.fromJson(json["beban_gaji"]),
        uangMakan: json["uang_makan"] == null
            ? null
            : PendapatanLainlain.fromJson(json["uang_makan"]),
        thr: json["thr"] == null
            ? null
            : PendapatanLainlain.fromJson(json["thr"]),
        bebanAdmUmum: json["beban_adm_umum"] == null
            ? null
            : PendapatanLainlain.fromJson(json["beban_adm_umum"]),
        bebanPerlengkapan: json["beban_perlengkapan"] == null
            ? null
            : PendapatanLainlain.fromJson(json["beban_perlengkapan"]),
        bebanPenyusutanInventaris: json["beban_penyusutan_inventaris"] == null
            ? null
            : PendapatanLainlain.fromJson(json["beban_penyusutan_inventaris"]),
        bebanPenyusutanGedung: json["beban_penyusutan_gedung"] == null
            ? null
            : PendapatanLainlain.fromJson(json["beban_penyusutan_gedung"]),
        pemeliharaanInventaris: json["pemeliharaan_inventaris"] == null
            ? null
            : PendapatanLainlain.fromJson(json["pemeliharaan_inventaris"]),
        pemeliharaanGedung: json["pemeliharaan_gedung"] == null
            ? null
            : PendapatanLainlain.fromJson(json["pemeliharaan_gedung"]),
        totalPengeluaraanPerBulan: json["total_pengeluaraan_per_bulan"] == null
            ? null
            : TotalPengeluaraanPerBulan.fromJson(
                json["total_pengeluaraan_per_bulan"]),
      );

  Map<String, dynamic> toJson() => {
        "beban_gaji": bebanGaji?.toJson(),
        "uang_makan": uangMakan?.toJson(),
        "thr": thr?.toJson(),
        "beban_adm_umum": bebanAdmUmum?.toJson(),
        "beban_perlengkapan": bebanPerlengkapan?.toJson(),
        "beban_penyusutan_inventaris": bebanPenyusutanInventaris?.toJson(),
        "beban_penyusutan_gedung": bebanPenyusutanGedung?.toJson(),
        "pemeliharaan_inventaris": pemeliharaanInventaris?.toJson(),
        "pemeliharaan_gedung": pemeliharaanGedung?.toJson(),
        "total_pengeluaraan_per_bulan": totalPengeluaraanPerBulan?.toJson(),
      };
}

class TotalPengeluaraanPerBulan {
  double? jumlah;
  List<TotalPengeluaraanPerBulanDatum>? data;

  TotalPengeluaraanPerBulan({
    this.jumlah,
    this.data,
  });

  factory TotalPengeluaraanPerBulan.fromJson(Map<String, dynamic> json) =>
      TotalPengeluaraanPerBulan(
        jumlah: json["jumlah"]?.toDouble(),
        data: json["data"] == null
            ? []
            : List<TotalPengeluaraanPerBulanDatum>.from(json["data"]!
                .map((x) => TotalPengeluaraanPerBulanDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "jumlah": jumlah,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TotalPengeluaraanPerBulanDatum {
  String? bulan;
  double? totalPengeluaran;

  TotalPengeluaraanPerBulanDatum({
    this.bulan,
    this.totalPengeluaran,
  });

  factory TotalPengeluaraanPerBulanDatum.fromJson(Map<String, dynamic> json) =>
      TotalPengeluaraanPerBulanDatum(
        bulan: json["bulan"],
        totalPengeluaran: json["total_pengeluaran"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "bulan": bulan,
        "total_pengeluaran": totalPengeluaran,
      };
}

class SisaHasilUsaha {
  double? jumlah;
  List<SisaHasilUsahaDatum>? data;

  SisaHasilUsaha({
    this.jumlah,
    this.data,
  });

  factory SisaHasilUsaha.fromJson(Map<String, dynamic> json) => SisaHasilUsaha(
        jumlah: json["jumlah"]?.toDouble(),
        data: json["data"] == null
            ? []
            : List<SisaHasilUsahaDatum>.from(
                json["data"]!.map((x) => SisaHasilUsahaDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "jumlah": jumlah,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SisaHasilUsahaDatum {
  String? bulan;
  double? sisaHasilUsaha;

  SisaHasilUsahaDatum({
    this.bulan,
    this.sisaHasilUsaha,
  });

  factory SisaHasilUsahaDatum.fromJson(Map<String, dynamic> json) =>
      SisaHasilUsahaDatum(
        bulan: json["bulan"],
        sisaHasilUsaha: json["sisa_hasil_usaha"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "bulan": bulan,
        "sisa_hasil_usaha": sisaHasilUsaha,
      };
}
