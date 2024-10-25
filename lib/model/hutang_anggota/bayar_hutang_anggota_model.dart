class BayarHutangAnggotaResult {
  bool? success;
  DataBayarHutangAnggota? data;
  String? message;

  BayarHutangAnggotaResult({this.success, this.data, this.message});

  BayarHutangAnggotaResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? DataBayarHutangAnggota.fromJson(json['data'])
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

class DataBayarHutangAnggota {
  String? idHistoryHutangAnggota;
  String? idAnggota;
  String? nmAnggota;
  String? tgBayarHutang;
  String? nominal;
  String? keterangan;
  String? idPenjualan;
  String? createdAt;
  String? updatedAt;

  DataBayarHutangAnggota(
      {this.idHistoryHutangAnggota,
      this.idAnggota,
      this.nmAnggota,
      this.tgBayarHutang,
      this.nominal,
      this.keterangan,
      this.idPenjualan,
      this.createdAt,
      this.updatedAt});

  DataBayarHutangAnggota.fromJson(Map<String, dynamic> json) {
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
