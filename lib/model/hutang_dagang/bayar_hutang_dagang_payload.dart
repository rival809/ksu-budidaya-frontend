class BayarHutangDagangPayload {
  String? idHutangDagang;
  String? nominalBayar;
  String? tgBayar;
  String? keterangan;

  BayarHutangDagangPayload(
      {this.idHutangDagang, this.nominalBayar, this.tgBayar, this.keterangan});

  BayarHutangDagangPayload.fromJson(Map<String, dynamic> json) {
    idHutangDagang = json['id_hutang_dagang'];
    nominalBayar = json['nominal_bayar'];
    tgBayar = json['tg_bayar'];
    keterangan = json['keterangan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_hutang_dagang'] = idHutangDagang;
    data['nominal_bayar'] = nominalBayar;
    data['tg_bayar'] = tgBayar;
    data['keterangan'] = keterangan;
    return data;
  }
}
