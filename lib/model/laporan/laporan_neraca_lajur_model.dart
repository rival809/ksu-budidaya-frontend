// To parse this JSON data, do
//
//     final laporanNeracaLajurModel = laporanNeracaLajurModelFromJson(jsonString);

import 'dart:convert';

LaporanNeracaLajurModel laporanNeracaLajurModelFromJson(String str) =>
    LaporanNeracaLajurModel.fromJson(json.decode(str));

String laporanNeracaLajurModelToJson(LaporanNeracaLajurModel data) => json.encode(data.toJson());

class LaporanNeracaLajurModel {
  bool? success;
  DataNeracaLajur? data;
  String? message;

  LaporanNeracaLajurModel({
    this.success,
    this.data,
    this.message,
  });

  LaporanNeracaLajurModel copyWith({
    bool? success,
    DataNeracaLajur? data,
    String? message,
  }) =>
      LaporanNeracaLajurModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory LaporanNeracaLajurModel.fromJson(Map<String, dynamic> json) => LaporanNeracaLajurModel(
        success: json["success"],
        data: json["data"] == null ? null : DataNeracaLajur.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class DataNeracaLajur {
  Map<String, DataNeraca?>? dataNeraca;
  TotalNeraca? totalNeraca;

  DataNeracaLajur({
    this.dataNeraca,
    this.totalNeraca,
  });

  DataNeracaLajur copyWith({
    Map<String, DataNeraca?>? dataNeraca,
    TotalNeraca? totalNeraca,
  }) =>
      DataNeracaLajur(
        dataNeraca: dataNeraca ?? this.dataNeraca,
        totalNeraca: totalNeraca ?? this.totalNeraca,
      );

  factory DataNeracaLajur.fromJson(Map<String, dynamic> json) => DataNeracaLajur(
        dataNeraca: Map.from(json["data_neraca"]!)
            .map((k, v) => MapEntry<String, DataNeraca?>(k, DataNeraca.fromJson(v))),
        totalNeraca:
            json["total_neraca"] == null ? null : TotalNeraca.fromJson(json["total_neraca"]),
      );

  Map<String, dynamic> toJson() => {
        "data_neraca":
            Map.from(dataNeraca!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "total_neraca": totalNeraca?.toJson(),
      };
}

class DataNeraca {
  TotalHasilUsaha? neracaAwal;
  TotalHasilUsaha? neracaMutasi;
  TotalHasilUsaha? neracaPercobaan;
  TotalHasilUsaha? neracaSaldo;
  TotalHasilUsaha? hasilUsaha;
  TotalHasilUsaha? neracaAkhir;

  DataNeraca({
    this.neracaAwal,
    this.neracaMutasi,
    this.neracaPercobaan,
    this.neracaSaldo,
    this.hasilUsaha,
    this.neracaAkhir,
  });

  DataNeraca copyWith({
    TotalHasilUsaha? neracaAwal,
    TotalHasilUsaha? neracaMutasi,
    TotalHasilUsaha? neracaPercobaan,
    TotalHasilUsaha? neracaSaldo,
    TotalHasilUsaha? hasilUsaha,
    TotalHasilUsaha? neracaAkhir,
  }) =>
      DataNeraca(
        neracaAwal: neracaAwal ?? this.neracaAwal,
        neracaMutasi: neracaMutasi ?? this.neracaMutasi,
        neracaPercobaan: neracaPercobaan ?? this.neracaPercobaan,
        neracaSaldo: neracaSaldo ?? this.neracaSaldo,
        hasilUsaha: hasilUsaha ?? this.hasilUsaha,
        neracaAkhir: neracaAkhir ?? this.neracaAkhir,
      );

  factory DataNeraca.fromJson(Map<String, dynamic> json) => DataNeraca(
        neracaAwal:
            json["neraca_awal"] == null ? null : TotalHasilUsaha.fromJson(json["neraca_awal"]),
        neracaMutasi:
            json["neraca_mutasi"] == null ? null : TotalHasilUsaha.fromJson(json["neraca_mutasi"]),
        neracaPercobaan: json["neraca_percobaan"] == null
            ? null
            : TotalHasilUsaha.fromJson(json["neraca_percobaan"]),
        neracaSaldo:
            json["neraca_saldo"] == null ? null : TotalHasilUsaha.fromJson(json["neraca_saldo"]),
        hasilUsaha:
            json["hasil_usaha"] == null ? null : TotalHasilUsaha.fromJson(json["hasil_usaha"]),
        neracaAkhir:
            json["neraca_akhir"] == null ? null : TotalHasilUsaha.fromJson(json["neraca_akhir"]),
      );

  Map<String, dynamic> toJson() => {
        "neraca_awal": neracaAwal?.toJson(),
        "neraca_mutasi": neracaMutasi?.toJson(),
        "neraca_percobaan": neracaPercobaan?.toJson(),
        "neraca_saldo": neracaSaldo?.toJson(),
        "hasil_usaha": hasilUsaha?.toJson(),
        "neraca_akhir": neracaAkhir?.toJson(),
      };
}

class TotalHasilUsaha {
  double? debit;
  double? kredit;

  TotalHasilUsaha({
    this.debit,
    this.kredit,
  });

  TotalHasilUsaha copyWith({
    double? debit,
    double? kredit,
  }) =>
      TotalHasilUsaha(
        debit: debit ?? this.debit,
        kredit: kredit ?? this.kredit,
      );

  factory TotalHasilUsaha.fromJson(Map<String, dynamic> json) => TotalHasilUsaha(
        debit: json["debit"]?.toDouble(),
        kredit: json["kredit"],
      );

  Map<String, dynamic> toJson() => {
        "debit": debit,
        "kredit": kredit,
      };
}

class TotalNeraca {
  TotalHasilUsaha? totalNeracaAwal;
  TotalHasilUsaha? totalNeracaMutasi;
  TotalHasilUsaha? totalNeracaPercobaan;
  TotalHasilUsaha? totalNeracaSaldo;
  TotalHasilUsaha? totalHasilUsaha;
  TotalHasilUsaha? totalNeracaAkhir;

  TotalNeraca({
    this.totalNeracaAwal,
    this.totalNeracaMutasi,
    this.totalNeracaPercobaan,
    this.totalNeracaSaldo,
    this.totalHasilUsaha,
    this.totalNeracaAkhir,
  });

  TotalNeraca copyWith({
    TotalHasilUsaha? totalNeracaAwal,
    TotalHasilUsaha? totalNeracaMutasi,
    TotalHasilUsaha? totalNeracaPercobaan,
    TotalHasilUsaha? totalNeracaSaldo,
    TotalHasilUsaha? totalHasilUsaha,
    TotalHasilUsaha? totalNeracaAkhir,
  }) =>
      TotalNeraca(
        totalNeracaAwal: totalNeracaAwal ?? this.totalNeracaAwal,
        totalNeracaMutasi: totalNeracaMutasi ?? this.totalNeracaMutasi,
        totalNeracaPercobaan: totalNeracaPercobaan ?? this.totalNeracaPercobaan,
        totalNeracaSaldo: totalNeracaSaldo ?? this.totalNeracaSaldo,
        totalHasilUsaha: totalHasilUsaha ?? this.totalHasilUsaha,
        totalNeracaAkhir: totalNeracaAkhir ?? this.totalNeracaAkhir,
      );

  factory TotalNeraca.fromJson(Map<String, dynamic> json) => TotalNeraca(
        totalNeracaAwal: json["total_neraca_awal"] == null
            ? null
            : TotalHasilUsaha.fromJson(json["total_neraca_awal"]),
        totalNeracaMutasi: json["total_neraca_mutasi"] == null
            ? null
            : TotalHasilUsaha.fromJson(json["total_neraca_mutasi"]),
        totalNeracaPercobaan: json["total_neraca_percobaan"] == null
            ? null
            : TotalHasilUsaha.fromJson(json["total_neraca_percobaan"]),
        totalNeracaSaldo: json["total_neraca_saldo"] == null
            ? null
            : TotalHasilUsaha.fromJson(json["total_neraca_saldo"]),
        totalHasilUsaha: json["total_hasil_usaha"] == null
            ? null
            : TotalHasilUsaha.fromJson(json["total_hasil_usaha"]),
        totalNeracaAkhir: json["total_neraca_akhir"] == null
            ? null
            : TotalHasilUsaha.fromJson(json["total_neraca_akhir"]),
      );

  Map<String, dynamic> toJson() => {
        "total_neraca_awal": totalNeracaAwal?.toJson(),
        "total_neraca_mutasi": totalNeracaMutasi?.toJson(),
        "total_neraca_percobaan": totalNeracaPercobaan?.toJson(),
        "total_neraca_saldo": totalNeracaSaldo?.toJson(),
        "total_hasil_usaha": totalHasilUsaha?.toJson(),
        "total_neraca_akhir": totalNeracaAkhir?.toJson(),
      };
}
