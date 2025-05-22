class IncomeMonthlyResult {
  bool? success;
  DataIncomeMonthly? data;
  String? message;

  IncomeMonthlyResult({this.success, this.data, this.message});

  IncomeMonthlyResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataIncomeMonthly.fromJson(json['data']) : null;
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

class DataIncomeMonthly {
  PendapatanToko? pendapatanToko;
  PendapatanKoperasi? pendapatanKoperasi;

  DataIncomeMonthly({this.pendapatanToko, this.pendapatanKoperasi});

  DataIncomeMonthly.fromJson(Map<String, dynamic> json) {
    pendapatanToko =
        json['pendapatan_toko'] != null ? PendapatanToko.fromJson(json['pendapatan_toko']) : null;
    pendapatanKoperasi = json['pendapatan_koperasi'] != null
        ? PendapatanKoperasi.fromJson(json['pendapatan_koperasi'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pendapatanToko != null) {
      data['pendapatan_toko'] = pendapatanToko!.toJson();
    }
    if (pendapatanKoperasi != null) {
      data['pendapatan_koperasi'] = pendapatanKoperasi!.toJson();
    }
    return data;
  }
}

class PendapatanToko {
  double? penjualan;
  double? presentasePenjualan;
  double? keuntungan;
  double? presentaseKeuntungan;

  PendapatanToko(
      {this.penjualan, this.presentasePenjualan, this.keuntungan, this.presentaseKeuntungan});

  PendapatanToko.fromJson(Map<String, dynamic> json) {
    penjualan = json['penjualan'];
    presentasePenjualan = json['presentase_penjualan'];
    keuntungan = json['keuntungan'];
    presentaseKeuntungan = json['presentase_keuntungan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['penjualan'] = penjualan;
    data['presentase_penjualan'] = presentasePenjualan;
    data['keuntungan'] = keuntungan;
    data['presentase_keuntungan'] = presentaseKeuntungan;
    return data;
  }
}

class PendapatanKoperasi {
  double? pendapatanKoperasi;
  double? presentasePendapatan;
  double? pengeluaranKoperasi;
  double? presentasePengeluaran;
  double? keuntunganKoperasi;
  double? presentaseKeuntungan;

  PendapatanKoperasi(
      {this.pendapatanKoperasi,
      this.presentasePendapatan,
      this.pengeluaranKoperasi,
      this.presentasePengeluaran,
      this.keuntunganKoperasi,
      this.presentaseKeuntungan});

  PendapatanKoperasi.fromJson(Map<String, dynamic> json) {
    pendapatanKoperasi = json['pendapatan_koperasi'];
    presentasePendapatan = json['presentase_pendapatan'];
    pengeluaranKoperasi = json['pengeluaran_koperasi'];
    presentasePengeluaran = json['presentase_pengeluaran'];
    keuntunganKoperasi = json['keuntungan_koperasi'];
    presentaseKeuntungan = json['presentase_keuntungan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pendapatan_koperasi'] = pendapatanKoperasi;
    data['presentase_pendapatan'] = presentasePendapatan;
    data['pengeluaran_koperasi'] = pengeluaranKoperasi;
    data['presentase_pengeluaran'] = presentasePengeluaran;
    data['keuntungan_koperasi'] = keuntunganKoperasi;
    data['presentase_keuntungan'] = presentaseKeuntungan;
    return data;
  }
}
