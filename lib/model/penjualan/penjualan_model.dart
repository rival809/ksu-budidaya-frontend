import 'package:ksu_budidaya/core.dart';

class PenjualanResult {
  bool? success;
  DataPenjualan? data;
  String? message;

  PenjualanResult({this.success, this.data, this.message});

  PenjualanResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataPenjualan.fromJson(json['data']) : null;
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

class DataPenjualan {
  List<DetailDataPenjualan>? dataPenjualan;
  Paging? paging;

  DataPenjualan({this.dataPenjualan, this.paging});

  DataPenjualan.fromJson(Map<String, dynamic> json) {
    if (json['data_penjualan'] != null) {
      dataPenjualan = <DetailDataPenjualan>[];
      json['data_penjualan'].forEach((v) {
        dataPenjualan!.add(DetailDataPenjualan.fromJson(v));
      });
    }
    paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dataPenjualan != null) {
      data['data_penjualan'] = dataPenjualan!.map((v) => v.toJson()).toList();
    }
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    return data;
  }
}

class DetailDataPenjualan {
  String? idPenjualan;
  String? tgPenjualan;
  int? jumlah;
  String? totalNilaiBeli;
  String? totalNilaiJual;
  String? idAnggota;
  String? nmAnggota;
  String? jenisPembayaran;
  String? keterangan;
  String? username;
  String? createdAt;
  String? updatedAt;

  DetailDataPenjualan(
      {this.idPenjualan,
      this.tgPenjualan,
      this.jumlah,
      this.totalNilaiBeli,
      this.totalNilaiJual,
      this.idAnggota,
      this.nmAnggota,
      this.jenisPembayaran,
      this.keterangan,
      this.username,
      this.createdAt,
      this.updatedAt});

  DetailDataPenjualan.fromJson(Map<String, dynamic> json) {
    idPenjualan = json['id_penjualan'];
    tgPenjualan = json['tg_penjualan'];
    jumlah = json['jumlah'];
    totalNilaiBeli = json['total_nilai_beli'];
    totalNilaiJual = json['total_nilai_jual'];
    idAnggota = json['id_anggota'];
    nmAnggota = json['nm_anggota'];
    jenisPembayaran = json['jenis_pembayaran'];
    keterangan = json['keterangan'];
    username = json['username'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_penjualan'] = idPenjualan;
    data['tg_penjualan'] = tgPenjualan;
    data['jumlah'] = jumlah;
    data['total_nilai_beli'] = totalNilaiBeli;
    data['total_nilai_jual'] = totalNilaiJual;
    data['id_anggota'] = idAnggota;
    data['nm_anggota'] = nmAnggota;
    data['jenis_pembayaran'] = jenisPembayaran;
    data['keterangan'] = keterangan;
    data['username'] = username;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
