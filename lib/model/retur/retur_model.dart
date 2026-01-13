import 'package:ksu_budidaya/model/user/list_role_model.dart';

class ReturResult {
  bool? success;
  DataRetur? data;
  String? message;

  ReturResult({this.success, this.data, this.message});

  ReturResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataRetur.fromJson(json['data']) : null;
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

class DataRetur {
  List<DetailDataRetur>? dataRetur;
  PagingRole? paging;

  DataRetur({this.dataRetur, this.paging});

  DataRetur.fromJson(Map<String, dynamic> json) {
    if (json['data_retur'] != null) {
      dataRetur = <DetailDataRetur>[];
      json['data_retur'].forEach((v) {
        dataRetur!.add(DetailDataRetur.fromJson(v));
      });
    }
    paging = json['paging'] != null ? PagingRole.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dataRetur != null) {
      data['data_retur'] = dataRetur!.map((v) => v.toJson()).toList();
    }
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    return data;
  }
}

class DetailDataRetur {
  String? idRetur;
  String? tgRetur;
  String? idPembelian;
  String? idSupplier;
  String? nmSupplier;
  int? jumlah;
  String? totalNilaiBeli;
  String? keterangan;
  String? createdAt;
  String? updatedAt;

  DetailDataRetur(
      {this.idRetur,
      this.tgRetur,
      this.idPembelian,
      this.idSupplier,
      this.nmSupplier,
      this.jumlah,
      this.totalNilaiBeli,
      this.keterangan,
      this.createdAt,
      this.updatedAt});

  DetailDataRetur.fromJson(Map<String, dynamic> json) {
    idRetur = json['id_retur'];
    tgRetur = json['tg_retur'];
    idPembelian = json['id_pembelian'];
    idSupplier = json['id_supplier'];
    nmSupplier = json['nm_supplier'];
    jumlah = json['jumlah'];
    totalNilaiBeli = json['total_nilai_beli'];
    keterangan = json['keterangan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_retur'] = idRetur;
    data['tg_retur'] = tgRetur;
    data['id_pembelian'] = idPembelian;
    data['id_supplier'] = idSupplier;
    data['nm_supplier'] = nmSupplier;
    data['jumlah'] = jumlah;
    data['total_nilai_beli'] = totalNilaiBeli;
    data['keterangan'] = keterangan;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
