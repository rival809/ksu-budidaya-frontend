import 'package:ksu_budidaya/core.dart';

class HutangAnggotaResult {
  bool? success;
  DataHutangAnggota? data;
  String? message;

  HutangAnggotaResult({this.success, this.data, this.message});

  HutangAnggotaResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataHutangAnggota.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class DataHutangAnggota {
  List<DetailDataHutangAnggota>? dataHutangAnggota;
  Paging? paging;

  DataHutangAnggota({this.dataHutangAnggota, this.paging});

  DataHutangAnggota.fromJson(Map<String, dynamic> json) {
    if (json['data_hutang_anggota'] != null) {
      dataHutangAnggota = <DetailDataHutangAnggota>[];
      json['data_hutang_anggota'].forEach((v) {
        dataHutangAnggota!.add(DetailDataHutangAnggota.fromJson(v));
      });
    }
    paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dataHutangAnggota != null) {
      data['data_hutang_anggota'] = dataHutangAnggota!.map((v) => v.toJson()).toList();
    }
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    return data;
  }
}

class DetailDataHutangAnggota {
  String? idHutangAnggota;
  String? idAnggota;
  String? nmAnggota;
  String? tgHutang;
  String? nominal;
  String? idPenjualan;
  String? createdAt;
  String? updatedAt;

  DetailDataHutangAnggota(
      {this.idHutangAnggota,
      this.idAnggota,
      this.nmAnggota,
      this.tgHutang,
      this.nominal,
      this.idPenjualan,
      this.createdAt,
      this.updatedAt});

  String hutangAnggotaAsString() {
    return "${trimString(nmAnggota)}";
  }

  DetailDataHutangAnggota copyWith({
    String? idHutangAnggota,
    String? idAnggota,
    String? nmAnggota,
    String? tgHutang,
    String? nominal,
    String? idPenjualan,
    String? createdAt,
    String? updatedAt,
  }) =>
      DetailDataHutangAnggota(
        idHutangAnggota: idHutangAnggota ?? this.idHutangAnggota,
        idAnggota: idAnggota ?? this.idAnggota,
        nmAnggota: nmAnggota ?? this.nmAnggota,
        tgHutang: tgHutang ?? this.tgHutang,
        nominal: nominal ?? this.nominal,
        idPenjualan: idPenjualan ?? this.idPenjualan,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  DetailDataHutangAnggota.fromJson(Map<String, dynamic> json) {
    idHutangAnggota = json['id_hutang_anggota'];
    idAnggota = json['id_anggota'];
    nmAnggota = json['nm_anggota'];
    tgHutang = json['tg_hutang'];
    nominal = json['nominal'];
    idPenjualan = json['id_penjualan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_hutang_anggota'] = idHutangAnggota;
    data['id_anggota'] = idAnggota;
    data['nm_anggota'] = nmAnggota;
    data['tg_hutang'] = tgHutang;
    data['nominal'] = nominal;
    data['id_penjualan'] = idPenjualan;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
