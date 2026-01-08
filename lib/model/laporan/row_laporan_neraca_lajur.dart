class RowLaporanNeracaLajur {
  String? uraian;
  double? neracaAwalD;
  double? neracaAwalK;
  double? neracaMutasiD;
  double? neracaMutasiK;
  double? neracaPercobaanD;
  double? neracaPercobaanK;
  double? neracaSaldoD;
  double? neracaSaldoK;
  double? neracaHasilUsahaD;
  double? neracaHasilUsahaK;
  double? neracaAkhirD;
  double? neracaAkhirK;

  RowLaporanNeracaLajur({
    this.uraian,
    this.neracaAwalD,
    this.neracaAwalK,
    this.neracaMutasiD,
    this.neracaMutasiK,
    this.neracaPercobaanD,
    this.neracaPercobaanK,
    this.neracaSaldoD,
    this.neracaSaldoK,
    this.neracaHasilUsahaD,
    this.neracaHasilUsahaK,
    this.neracaAkhirD,
    this.neracaAkhirK,
  });
  RowLaporanNeracaLajur.fromJson(Map<String, dynamic> json) {
    uraian = json['uraian'];
    neracaAwalD = json['neraca_awal_d'];
    neracaAwalK = json['neraca_awal_k'];
    neracaMutasiD = json['neraca_mutasi_d'];
    neracaMutasiK = json['neraca_mutasi_k'];
    neracaPercobaanD = json['neraca_percobaan_d'];
    neracaPercobaanK = json['neraca_percobaan_k'];
    neracaSaldoD = json['neraca_saldo_d'];
    neracaSaldoK = json['neraca_saldo_k'];
    neracaHasilUsahaD = json['neraca_hasil_usaha_d'];
    neracaHasilUsahaK = json['neraca_hasil_usaha_k'];
    neracaAkhirD = json['neraca_akhir_d'];
    neracaAkhirK = json['neraca_akhir_k'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uraian'] = uraian;
    data['neraca_awal_d'] = neracaAwalD;
    data['neraca_awal_k'] = neracaAwalK;
    data['neraca_mutasi_d'] = neracaMutasiD;
    data['neraca_mutasi_k'] = neracaMutasiK;
    data['neraca_percobaan_d'] = neracaPercobaanD;
    data['neraca_percobaan_k'] = neracaPercobaanK;
    data['neraca_saldo_d'] = neracaSaldoD;
    data['neraca_saldo_k'] = neracaSaldoK;
    data['neraca_hasil_usaha_d'] = neracaHasilUsahaD;
    data['neraca_hasil_usaha_k'] = neracaHasilUsahaK;
    data['neraca_akhir_d'] = neracaAkhirD;
    data['neraca_akhir_k'] = neracaAkhirK;
    return data;
  }
}
