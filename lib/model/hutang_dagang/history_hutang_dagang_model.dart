import 'package:ksu_budidaya/core.dart';

class HistoryHutangDagangResult {
  bool? success;
  DataHistoryHutangDagang? data;
  String? message;

  HistoryHutangDagangResult({this.success, this.data, this.message});

  HistoryHutangDagangResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? DataHistoryHutangDagang.fromJson(json['data'])
        : null;
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

class DataHistoryHutangDagang {
  List<DataDetailBayarHutang>? dataBayarHutang;
  Paging? paging;

  DataHistoryHutangDagang({this.dataBayarHutang, this.paging});

  DataHistoryHutangDagang.fromJson(Map<String, dynamic> json) {
    if (json['data_bayar_hutang'] != null) {
      dataBayarHutang = <DataDetailBayarHutang>[];
      json['data_bayar_hutang'].forEach((v) {
        dataBayarHutang!.add(DataDetailBayarHutang.fromJson(v));
      });
    }
    paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dataBayarHutang != null) {
      data['data_bayar_hutang'] =
          dataBayarHutang!.map((v) => v.toJson()).toList();
    }
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    return data;
  }
}

class DataDetailBayarHutang {
  String? idHistoryHutangDagang;
  String? idSupplier;
  String? nmSupplier;
  String? tgBayarHutang;
  String? nominal;
  String? keterangan;
  String? idPembelian;
  String? createdAt;
  String? updatedAt;

  DataDetailBayarHutang(
      {this.idHistoryHutangDagang,
      this.idSupplier,
      this.nmSupplier,
      this.tgBayarHutang,
      this.nominal,
      this.keterangan,
      this.idPembelian,
      this.createdAt,
      this.updatedAt});

  DataDetailBayarHutang.fromJson(Map<String, dynamic> json) {
    idHistoryHutangDagang = json['id_history_hutang_dagang'];
    idSupplier = json['id_supplier'];
    nmSupplier = json['nm_supplier'];
    tgBayarHutang = json['tg_bayar_hutang'];
    nominal = json['nominal'];
    keterangan = json['keterangan'];
    idPembelian = json['id_pembelian'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_history_hutang_dagang'] = idHistoryHutangDagang;
    data['id_supplier'] = idSupplier;
    data['nm_supplier'] = nmSupplier;
    data['tg_bayar_hutang'] = tgBayarHutang;
    data['nominal'] = nominal;
    data['keterangan'] = keterangan;
    data['id_pembelian'] = idPembelian;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
