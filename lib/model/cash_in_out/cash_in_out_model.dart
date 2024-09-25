import 'package:ksu_budidaya/core.dart';

class CashInOutResult {
  bool? success;
  DataCashInOut? data;
  String? message;

  CashInOutResult({this.success, this.data, this.message});

  CashInOutResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataCashInOut.fromJson(json['data']) : null;
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

class DataCashInOut {
  List<DataDetailCashInOut>? dataCashInOut;
  Paging? paging;

  DataCashInOut({this.dataCashInOut, this.paging});

  DataCashInOut.fromJson(Map<String, dynamic> json) {
    if (json['data_cash_in_out'] != null) {
      dataCashInOut = <DataDetailCashInOut>[];
      json['data_cash_in_out'].forEach((v) {
        dataCashInOut!.add(DataDetailCashInOut.fromJson(v));
      });
    }
    paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dataCashInOut != null) {
      data['data_cash_in_out'] = dataCashInOut!.map((v) => v.toJson()).toList();
    }
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    return data;
  }
}

class DataDetailCashInOut {
  String? idCashInOut;
  String? tgTransaksi;
  String? idCash;
  int? idJenis;
  int? idDetail;
  String? nominal;
  String? keterangan;
  String? createdAt;
  String? updatedAt;

  DataDetailCashInOut(
      {this.idCashInOut,
      this.tgTransaksi,
      this.idCash,
      this.idJenis,
      this.idDetail,
      this.nominal,
      this.keterangan,
      this.createdAt,
      this.updatedAt});

  DataDetailCashInOut.fromJson(Map<String, dynamic> json) {
    idCashInOut = json['id_cash_in_out'];
    tgTransaksi = json['tg_transaksi'];
    idCash = json['id_cash'];
    idJenis = json['id_jenis'];
    idDetail = json['id_detail'];
    nominal = json['nominal'];
    keterangan = json['keterangan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_cash_in_out'] = idCashInOut;
    data['tg_transaksi'] = tgTransaksi;
    data['id_cash'] = idCash;
    data['id_jenis'] = idJenis;
    data['id_detail'] = idDetail;
    data['nominal'] = nominal;
    data['keterangan'] = keterangan;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  DataDetailCashInOut copyWith({
    String? idCashInOut,
    String? tgTransaksi,
    String? idCash,
    int? idJenis,
    int? idDetail,
    String? nominal,
    String? keterangan,
    String? createdAt,
    String? updatedAt,
  }) =>
      DataDetailCashInOut(
        idCashInOut: idCashInOut ?? this.idCashInOut,
        tgTransaksi: tgTransaksi ?? this.tgTransaksi,
        idCash: idCash ?? this.idCash,
        idJenis: idJenis ?? this.idJenis,
        idDetail: idDetail ?? this.idDetail,
        nominal: nominal ?? this.nominal,
        keterangan: keterangan ?? this.keterangan,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
