import 'package:ksu_budidaya/core.dart';

class ListTutupKasirResult {
  bool? success;
  DataTutupKasir? data;
  String? message;

  ListTutupKasirResult({this.success, this.data, this.message});

  ListTutupKasirResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataTutupKasir.fromJson(json['data']) : null;
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

class DataTutupKasir {
  List<DetailDataTutupKasir>? dataTutupKasir;
  Paging? paging;

  DataTutupKasir({this.dataTutupKasir, this.paging});

  DataTutupKasir.fromJson(Map<String, dynamic> json) {
    if (json['data_tutup_kasir'] != null) {
      dataTutupKasir = <DetailDataTutupKasir>[];
      json['data_tutup_kasir'].forEach((v) {
        dataTutupKasir!.add(DetailDataTutupKasir.fromJson(v));
      });
    }
    paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dataTutupKasir != null) {
      data['data_tutup_kasir'] =
          dataTutupKasir!.map((v) => v.toJson()).toList();
    }
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    return data;
  }
}

class DetailDataTutupKasir {
  int? idTutupKasir;
  String? tgTutupKasir;
  String? shift;
  String? namaKasir;
  String? username;
  String? tunai;
  String? qris;
  String? kredit;
  String? total;
  String? uangTunai;
  String? totalNilaiJual;
  String? totalNilaiBeli;
  String? totalKeuntungan;
  String? createdAt;
  String? updatedAt;

  DetailDataTutupKasir(
      {this.idTutupKasir,
      this.tgTutupKasir,
      this.shift,
      this.namaKasir,
      this.username,
      this.tunai,
      this.qris,
      this.kredit,
      this.total,
      this.uangTunai,
      this.totalNilaiJual,
      this.totalNilaiBeli,
      this.totalKeuntungan,
      this.createdAt,
      this.updatedAt});

  DetailDataTutupKasir.fromJson(Map<String, dynamic> json) {
    idTutupKasir = json['id_tutup_kasir'];
    tgTutupKasir = json['tg_tutup_kasir'];
    shift = json['shift'];
    namaKasir = json['nama_kasir'];
    username = json['username'];
    tunai = json['tunai'];
    qris = json['qris'];
    kredit = json['kredit'];
    total = json['total'];
    uangTunai = json['uang_tunai'];
    totalNilaiJual = json['total_nilai_jual'];
    totalNilaiBeli = json['total_nilai_beli'];
    totalKeuntungan = json['total_keuntungan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_tutup_kasir'] = idTutupKasir;
    data['tg_tutup_kasir'] = tgTutupKasir;
    data['shift'] = shift;
    data['nama_kasir'] = namaKasir;
    data['username'] = username;
    data['tunai'] = tunai;
    data['qris'] = qris;
    data['kredit'] = kredit;
    data['total'] = total;
    data['uang_tunai'] = uangTunai;
    data['total_nilai_jual'] = totalNilaiJual;
    data['total_nilai_beli'] = totalNilaiBeli;
    data['total_keuntungan'] = totalKeuntungan;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
