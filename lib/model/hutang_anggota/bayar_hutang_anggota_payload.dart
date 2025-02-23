class BayarHutangAnggotaPayload {
  String? idAnggota;
  String? nominalBayar;
  String? tgBayar;
  String? keterangan;

  BayarHutangAnggotaPayload({this.idAnggota, this.nominalBayar, this.tgBayar, this.keterangan});

  BayarHutangAnggotaPayload.fromJson(Map<String, dynamic> json) {
    idAnggota = json['id_anggota'];
    nominalBayar = json['nominal_bayar'];
    tgBayar = json['tg_bayar'];
    keterangan = json['keterangan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_anggota'] = idAnggota;
    data['nominal_bayar'] = nominalBayar;
    data['tg_bayar'] = tgBayar;
    data['keterangan'] = keterangan;
    return data;
  }
}
