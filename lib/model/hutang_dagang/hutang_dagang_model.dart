import 'package:ksu_budidaya/core.dart';

class HutangDagangResult {
  bool? success;
  DataHutangDagang? data;
  String? message;

  HutangDagangResult({this.success, this.data, this.message});

  HutangDagangResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data =
        json['data'] != null ? DataHutangDagang.fromJson(json['data']) : null;
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

class DataHutangDagang {
  List<DataDetailHutangDagang>? dataHutangDagang;
  Paging? paging;

  DataHutangDagang({this.dataHutangDagang, this.paging});

  DataHutangDagang.fromJson(Map<String, dynamic> json) {
    if (json['data_hutang_dagang'] != null) {
      dataHutangDagang = <DataDetailHutangDagang>[];
      json['data_hutang_dagang'].forEach((v) {
        dataHutangDagang!.add(DataDetailHutangDagang.fromJson(v));
      });
    }
    paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dataHutangDagang != null) {
      data['data_hutang_dagang'] =
          dataHutangDagang!.map((v) => v.toJson()).toList();
    }
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    return data;
  }
}

class DataDetailHutangDagang {
  String? idHutangDagang;
  String? idSupplier;
  String? nmSupplier;
  String? tgHutang;
  String? nominal;
  String? idPembelian;
  String? keterangan;
  String? createdAt;
  String? updatedAt;

  DataDetailHutangDagang(
      {this.idHutangDagang,
      this.idSupplier,
      this.nmSupplier,
      this.tgHutang,
      this.nominal,
      this.idPembelian,
      this.createdAt,
      this.updatedAt});

  DataDetailHutangDagang.fromJson(Map<String, dynamic> json) {
    idHutangDagang = json['id_hutang_dagang'];
    idSupplier = json['id_supplier'];
    nmSupplier = json['nm_supplier'];
    tgHutang = json['tg_hutang'];
    nominal = json['nominal'];
    idPembelian = json['id_pembelian'];
    keterangan = json['keterangan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_hutang_dagang'] = idHutangDagang;
    data['id_supplier'] = idSupplier;
    data['nm_supplier'] = nmSupplier;
    data['tg_hutang'] = tgHutang;
    data['nominal'] = nominal;
    data['id_pembelian'] = idPembelian;
    data['keterangan'] = keterangan;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  String hutangDagangAsString() {
    return "$idPembelian";
  }
}
