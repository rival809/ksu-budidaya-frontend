class BayarHutangAnggotaPayload {
  String? idHutangAnggota;
  String? nominalBayar;
  String? tgBayar;
  String? keterangan;

  BayarHutangAnggotaPayload(
      {this.idHutangAnggota, this.nominalBayar, this.tgBayar, this.keterangan});

  BayarHutangAnggotaPayload.fromJson(Map<String, dynamic> json) {
    idHutangAnggota = json['id_hutang_dagang'];
    nominalBayar = json['nominal_bayar'];
    tgBayar = json['tg_bayar'];
    keterangan = json['keterangan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_hutang_dagang'] = idHutangAnggota;
    data['nominal_bayar'] = nominalBayar;
    data['tg_bayar'] = tgBayar;
    data['keterangan'] = keterangan;
    return data;
  }
}
