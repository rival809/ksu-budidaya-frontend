import 'package:ksu_budidaya/core.dart';

class AktivitasStockModel {
  bool? success;
  DataAktivitasStock? data;
  String? message;

  AktivitasStockModel({this.success, this.data, this.message});

  AktivitasStockModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataAktivitasStock.fromJson(json['data']) : null;
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

class DataAktivitasStock {
  List<DataAktivitas>? dataAktivitas;
  Paging? paging;

  DataAktivitasStock({this.dataAktivitas, this.paging});

  DataAktivitasStock.fromJson(Map<String, dynamic> json) {
    if (json['data_aktivitas'] != null) {
      dataAktivitas = <DataAktivitas>[];
      json['data_aktivitas'].forEach((v) {
        dataAktivitas!.add(DataAktivitas.fromJson(v));
      });
    }
    paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dataAktivitas != null) {
      data['data_aktivitas'] = dataAktivitas!.map((v) => v.toJson()).toList();
    }
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    return data;
  }
}

class DataAktivitas {
  String? tgAktivitas;
  String? tgUpdateAktivitas;
  String? idProduct;
  String? nmProduct;
  String? divisi;
  String? jumlah;
  String? aktivitas;
  String? idAktivitas;
  String? user;

  DataAktivitas(
      {this.tgAktivitas,
      this.tgUpdateAktivitas,
      this.idProduct,
      this.nmProduct,
      this.divisi,
      this.jumlah,
      this.aktivitas,
      this.idAktivitas,
      this.user});

  DataAktivitas.fromJson(Map<String, dynamic> json) {
    tgAktivitas = json['tg_aktivitas'];
    tgUpdateAktivitas = json['tg_update_aktivitas'];
    idProduct = json['id_product'];
    nmProduct = json['nm_product'];
    divisi = json['divisi'];
    jumlah = checkModel(json['jumlah']);
    aktivitas = json['aktivitas'];
    idAktivitas = json['id_aktivitas'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tg_aktivitas'] = tgAktivitas;
    data['tg_update_aktivitas'] = tgUpdateAktivitas;
    data['id_product'] = idProduct;
    data['nm_product'] = nmProduct;
    data['divisi'] = divisi;
    data['jumlah'] = jumlah;
    data['aktivitas'] = aktivitas;
    data['id_aktivitas'] = idAktivitas;
    data['user'] = user;
    return data;
  }
}
