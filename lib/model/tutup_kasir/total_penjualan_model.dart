class TotalPenjualanResult {
  bool? success;
  DataTotalPenjualan? data;
  String? message;

  TotalPenjualanResult({this.success, this.data, this.message});

  TotalPenjualanResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data =
        json['data'] != null ? DataTotalPenjualan.fromJson(json['data']) : null;
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

class DataTotalPenjualan {
  String? keterangan;
  DetailDataTotalPenjualan? penjualan;
  DetailDataTotalKeuntungan? keuntungan;

  DataTotalPenjualan({this.keterangan, this.penjualan, this.keuntungan});

  DataTotalPenjualan.fromJson(Map<String, dynamic> json) {
    keterangan = json['keterangan'];
    penjualan = json['penjualan'] != null
        ? DetailDataTotalPenjualan.fromJson(json['penjualan'])
        : null;
    keuntungan = json['keuntungan'] != null
        ? DetailDataTotalKeuntungan.fromJson(json['keuntungan'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['keterangan'] = keterangan;
    if (penjualan != null) {
      data['penjualan'] = penjualan!.toJson();
    }
    if (keuntungan != null) {
      data['keuntungan'] = keuntungan!.toJson();
    }
    return data;
  }
}

class DetailDataTotalPenjualan {
  int? penjualanTunai;
  int? penjualanQris;
  int? penjualanKredit;
  int? totalPenjualan;

  DetailDataTotalPenjualan(
      {this.penjualanTunai,
      this.penjualanQris,
      this.penjualanKredit,
      this.totalPenjualan});

  DetailDataTotalPenjualan.fromJson(Map<String, dynamic> json) {
    penjualanTunai = json['penjualan_tunai'];
    penjualanQris = json['penjualan_qris'];
    penjualanKredit = json['penjualan_kredit'];
    totalPenjualan = json['total_penjualan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['penjualan_tunai'] = penjualanTunai;
    data['penjualan_qris'] = penjualanQris;
    data['penjualan_kredit'] = penjualanKredit;
    data['total_penjualan'] = totalPenjualan;
    return data;
  }
}

class DetailDataTotalKeuntungan {
  int? totalNilaiJual;
  int? totalNilaiBeli;
  int? totalKeuntungan;

  DetailDataTotalKeuntungan(
      {this.totalNilaiJual, this.totalNilaiBeli, this.totalKeuntungan});

  DetailDataTotalKeuntungan.fromJson(Map<String, dynamic> json) {
    totalNilaiJual = json['total_nilai_jual'];
    totalNilaiBeli = json['total_nilai_beli'];
    totalKeuntungan = json['total_keuntungan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_nilai_jual'] = totalNilaiJual;
    data['total_nilai_beli'] = totalNilaiBeli;
    data['total_keuntungan'] = totalKeuntungan;
    return data;
  }
}
