class BayarHutangDagangResult {
  bool? success;
  DataBayarHutangDagang? data;
  String? message;

  BayarHutangDagangResult({this.success, this.data, this.message});

  BayarHutangDagangResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? DataBayarHutangDagang.fromJson(json['data'])
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

class DataBayarHutangDagang {
  String? idHistoryHutangDagang;
  String? idSupplier;
  String? nmSupplier;
  String? tgBayarHutang;
  String? nominal;
  String? keterangan;
  String? idPembelian;
  String? createdAt;
  String? updatedAt;

  DataBayarHutangDagang(
      {this.idHistoryHutangDagang,
      this.idSupplier,
      this.nmSupplier,
      this.tgBayarHutang,
      this.nominal,
      this.keterangan,
      this.idPembelian,
      this.createdAt,
      this.updatedAt});

  DataBayarHutangDagang.fromJson(Map<String, dynamic> json) {
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
