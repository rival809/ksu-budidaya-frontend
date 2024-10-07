import 'package:ksu_budidaya/core.dart';

class AnggotaResult {
  bool? success;
  DataAnggota? data;
  String? message;

  AnggotaResult({this.success, this.data, this.message});

  AnggotaResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataAnggota.fromJson(json['data']) : null;
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

class DataAnggota {
  List<DataDetailAnggota>? dataAnggota;
  Paging? paging;

  DataAnggota({this.dataAnggota, this.paging});

  DataAnggota.fromJson(Map<String, dynamic> json) {
    if (json['data_anggota'] != null) {
      dataAnggota = <DataDetailAnggota>[];
      json['data_anggota'].forEach((v) {
        dataAnggota!.add(DataDetailAnggota.fromJson(v));
      });
    }
    paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dataAnggota != null) {
      data['data_anggota'] = dataAnggota!.map((v) => v.toJson()).toList();
    }
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    return data;
  }
}

class DataDetailAnggota {
  String? idAnggota;
  String? nmAnggota;
  String? alamat;
  String? noWa;
  String? limitPinjaman;
  String? hutang;
  String? createdAt;
  String? updatedAt;

  DataDetailAnggota(
      {this.idAnggota,
      this.nmAnggota,
      this.alamat,
      this.noWa,
      this.limitPinjaman,
      this.hutang,
      this.createdAt,
      this.updatedAt});

  DataDetailAnggota.fromJson(Map<String, dynamic> json) {
    idAnggota = json['id_anggota'];
    nmAnggota = json['nm_anggota'];
    alamat = json['alamat'];
    noWa = json['no_wa'];
    limitPinjaman = json['limit_pinjaman'];
    hutang = json['hutang'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_anggota'] = idAnggota;
    data['nm_anggota'] = nmAnggota;
    data['alamat'] = alamat;
    data['no_wa'] = noWa;
    data['limit_pinjaman'] = limitPinjaman;
    data['hutang'] = hutang;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  DataDetailAnggota copyWith({
    String? idAnggota,
    String? nmAnggota,
    String? alamat,
    String? noWa,
    String? limitPinjaman,
    String? hutang,
    String? createdAt,
    String? updatedAt,
  }) =>
      DataDetailAnggota(
        idAnggota: idAnggota ?? this.idAnggota,
        nmAnggota: nmAnggota ?? this.nmAnggota,
        alamat: alamat ?? this.alamat,
        noWa: noWa ?? this.noWa,
        limitPinjaman: limitPinjaman ?? this.limitPinjaman,
        hutang: hutang ?? this.hutang,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
