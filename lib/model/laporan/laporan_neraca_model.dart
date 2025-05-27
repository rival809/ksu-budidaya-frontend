// To parse this JSON data, do
//
//     final laporanNeracaModel = laporanNeracaModelFromJson(jsonString);

import 'dart:convert';

LaporanNeracaModel laporanNeracaModelFromJson(String str) =>
    LaporanNeracaModel.fromJson(json.decode(str));

String laporanNeracaModelToJson(LaporanNeracaModel data) => json.encode(data.toJson());

class LaporanNeracaModel {
  bool? success;
  DataLaporanNeraca? data;
  String? message;

  LaporanNeracaModel({
    this.success,
    this.data,
    this.message,
  });

  factory LaporanNeracaModel.fromJson(Map<String, dynamic> json) => LaporanNeracaModel(
        success: json["success"],
        data: json["data"] == null ? null : DataLaporanNeraca.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class DataLaporanNeraca {
  DetailLaporanNeraca? current;
  DetailLaporanNeraca? previous;

  DataLaporanNeraca({
    this.current,
    this.previous,
  });

  factory DataLaporanNeraca.fromJson(Map<String, dynamic> json) => DataLaporanNeraca(
        current: json["current"] == null ? null : DetailLaporanNeraca.fromJson(json["current"]),
        previous: json["previous"] == null ? null : DetailLaporanNeraca.fromJson(json["previous"]),
      );

  Map<String, dynamic> toJson() => {
        "current": current?.toJson(),
        "previous": previous?.toJson(),
      };
}

class DetailLaporanNeraca {
  Map<String, dynamic>? aktivaLancar;
  AktivaTetap? aktivaTetap;
  AktivaTetap? akumPenyusutan;
  double? nilaiBukuAktiva;
  AktivaLain? aktivaLain;
  HutangLancar? hutangLancar;
  UtangDariSp? utangDariSp;
  Map<String, dynamic>? danaModalShu;
  double? totalAktiva;
  double? totalPasiva;

  DetailLaporanNeraca({
    this.aktivaLancar,
    this.aktivaTetap,
    this.akumPenyusutan,
    this.nilaiBukuAktiva,
    this.aktivaLain,
    this.hutangLancar,
    this.utangDariSp,
    this.danaModalShu,
    this.totalAktiva,
    this.totalPasiva,
  });

  factory DetailLaporanNeraca.fromJson(Map<String, dynamic> json) => DetailLaporanNeraca(
        aktivaLancar: json["aktiva_lancar"],
        aktivaTetap:
            json["aktiva_tetap"] == null ? null : AktivaTetap.fromJson(json["aktiva_tetap"]),
        akumPenyusutan:
            json["akum_penyusutan"] == null ? null : AktivaTetap.fromJson(json["akum_penyusutan"]),
        nilaiBukuAktiva: json["nilai_buku_aktiva"]?.toDouble(),
        aktivaLain: json["aktiva_lain"] == null ? null : AktivaLain.fromJson(json["aktiva_lain"]),
        hutangLancar:
            json["hutang_lancar"] == null ? null : HutangLancar.fromJson(json["hutang_lancar"]),
        utangDariSp:
            json["utang_dari_sp"] == null ? null : UtangDariSp.fromJson(json["utang_dari_sp"]),
        danaModalShu: json["dana_modal_shu"],
        totalAktiva: json["total_aktiva"]?.toDouble(),
        totalPasiva: json["total_pasiva"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "aktiva_lancar": aktivaLancar,
        "aktiva_tetap": aktivaTetap?.toJson(),
        "akum_penyusutan": akumPenyusutan?.toJson(),
        "nilai_buku_aktiva": nilaiBukuAktiva,
        "aktiva_lain": aktivaLain?.toJson(),
        "hutang_lancar": hutangLancar?.toJson(),
        "utang_dari_sp": utangDariSp?.toJson(),
        "dana_modal_shu": danaModalShu,
        "total_aktiva": totalAktiva,
        "total_pasiva": totalPasiva,
      };
}

class AktivaLain {
  double? jumlah;

  AktivaLain({
    this.jumlah,
  });

  factory AktivaLain.fromJson(Map<String, dynamic> json) => AktivaLain(
        jumlah: json["jumlah"],
      );

  Map<String, dynamic> toJson() => {
        "jumlah": jumlah,
      };
}

class AktivaTetap {
  double? inventaris;
  double? gedung;
  double? jumlah;

  AktivaTetap({
    this.inventaris,
    this.gedung,
    this.jumlah,
  });

  factory AktivaTetap.fromJson(Map<String, dynamic> json) => AktivaTetap(
        inventaris: json["inventaris"]?.toDouble(),
        gedung: json["gedung"]?.toDouble(),
        jumlah: json["jumlah"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "inventaris": inventaris,
        "gedung": gedung,
        "jumlah": jumlah,
      };
}

class HutangLancar {
  double? hutangDagang;
  double? modalTidakTetap;
  double? jumlah;

  HutangLancar({
    this.hutangDagang,
    this.modalTidakTetap,
    this.jumlah,
  });

  factory HutangLancar.fromJson(Map<String, dynamic> json) => HutangLancar(
        hutangDagang: json["hutang_dagang"],
        modalTidakTetap: json["modal_tidak_tetap"],
        jumlah: json["jumlah"],
      );

  Map<String, dynamic> toJson() => {
        "hutang_dagang": hutangDagang,
        "modal_tidak_tetap": modalTidakTetap,
        "jumlah": jumlah,
      };
}

class UtangDariSp {
  double? utangDariSp;
  double? jumlah;

  UtangDariSp({
    this.utangDariSp,
    this.jumlah,
  });

  factory UtangDariSp.fromJson(Map<String, dynamic> json) => UtangDariSp(
        utangDariSp: json["utang_dari_sp"],
        jumlah: json["jumlah"],
      );

  Map<String, dynamic> toJson() => {
        "utang_dari_sp": utangDariSp,
        "jumlah": jumlah,
      };
}
