class HistoryHutangAnggotaResult {
  bool? success;
  DataHistoryHutangAnggota? data;
  String? message;

  HistoryHutangAnggotaResult({this.success, this.data, this.message});

  HistoryHutangAnggotaResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataHistoryHutangAnggota.fromJson(json['data']) : null;
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

class DataHistoryHutangAnggota {
  List<DataBayarHutang>? dataBayarHutang;
  Paging? paging;

  DataHistoryHutangAnggota({this.dataBayarHutang, this.paging});

  DataHistoryHutangAnggota.fromJson(Map<String, dynamic> json) {
    if (json['data_bayar_hutang'] != null) {
      dataBayarHutang = <DataBayarHutang>[];
      json['data_bayar_hutang'].forEach((v) {
        dataBayarHutang!.add(DataBayarHutang.fromJson(v));
      });
    }
    paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dataBayarHutang != null) {
      data['data_bayar_hutang'] = dataBayarHutang!.map((v) => v.toJson()).toList();
    }
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    return data;
  }
}

class DataBayarHutang {
  String? idHistoryHutangAnggota;
  String? idAnggota;
  String? nmAnggota;
  String? tgBayarHutang;
  String? nominal;
  String? keterangan;
  String? idPenjualan;
  String? createdAt;
  String? updatedAt;

  DataBayarHutang(
      {this.idHistoryHutangAnggota,
      this.idAnggota,
      this.nmAnggota,
      this.tgBayarHutang,
      this.nominal,
      this.keterangan,
      this.idPenjualan,
      this.createdAt,
      this.updatedAt});

  DataBayarHutang.fromJson(Map<String, dynamic> json) {
    idHistoryHutangAnggota = json['id_history_hutang_anggota'];
    idAnggota = json['id_anggota'];
    nmAnggota = json['nm_anggota'];
    tgBayarHutang = json['tg_bayar_hutang'];
    nominal = json['nominal'];
    keterangan = json['keterangan'];
    idPenjualan = json['id_penjualan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_history_hutang_anggota'] = idHistoryHutangAnggota;
    data['id_anggota'] = idAnggota;
    data['nm_anggota'] = nmAnggota;
    data['tg_bayar_hutang'] = tgBayarHutang;
    data['nominal'] = nominal;
    data['keterangan'] = keterangan;
    data['id_penjualan'] = idPenjualan;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Paging {
  int? page;
  int? totalItem;
  int? totalPage;

  Paging({this.page, this.totalItem, this.totalPage});

  Paging.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalItem = json['total_item'];
    totalPage = json['total_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['total_item'] = totalItem;
    data['total_page'] = totalPage;
    return data;
  }
}
