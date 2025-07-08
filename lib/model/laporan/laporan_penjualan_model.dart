class LaporanPenjualanModel {
  bool? success;
  DataLaporanPenjualan? data;
  String? message;

  LaporanPenjualanModel({this.success, this.data, this.message});

  LaporanPenjualanModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataLaporanPenjualan.fromJson(json['data']) : null;
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

class DataLaporanPenjualan {
  Periode? periode;
  List<DetailDataLaporanPenjualan>? data;
  Summary? summary;

  DataLaporanPenjualan({this.periode, this.data, this.summary});

  DataLaporanPenjualan.fromJson(Map<String, dynamic> json) {
    periode = json['periode'] != null ? Periode.fromJson(json['periode']) : null;
    if (json['data'] != null) {
      data = <DetailDataLaporanPenjualan>[];
      json['data'].forEach((v) {
        data!.add(DetailDataLaporanPenjualan.fromJson(v));
      });
    }
    summary = json['summary'] != null ? Summary.fromJson(json['summary']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (periode != null) {
      data['periode'] = periode!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    return data;
  }
}

class Periode {
  String? startDate;
  String? endDate;

  Periode({this.startDate, this.endDate});

  Periode.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    return data;
  }
}

class DetailDataLaporanPenjualan {
  String? produk;
  String? metodePembayaran;
  double? jumlah;
  double? modal;
  double? hasilPenjualan;
  double? keuntungan;
  double? persentase;

  DetailDataLaporanPenjualan(
      {this.produk,
      this.metodePembayaran,
      this.jumlah,
      this.modal,
      this.hasilPenjualan,
      this.keuntungan,
      this.persentase});

  DetailDataLaporanPenjualan.fromJson(Map<String, dynamic> json) {
    produk = json['produk'];
    metodePembayaran = json['metode_pembayaran'];
    jumlah = json['jumlah'];
    modal = json['modal'];
    hasilPenjualan = json['hasil_penjualan'];
    keuntungan = json['keuntungan'];
    persentase = json['persentase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['produk'] = produk;
    data['metode_pembayaran'] = metodePembayaran;
    data['jumlah'] = jumlah;
    data['modal'] = modal;
    data['hasil_penjualan'] = hasilPenjualan;
    data['keuntungan'] = keuntungan;
    data['persentase'] = persentase;
    return data;
  }
}

class Summary {
  TotalPenjualanTunai? totalPenjualanTunai;
  TotalPenjualanTunai? totalPenjualanQris;
  TotalPenjualanTunai? totalPenjualanKredit;
  TotalPenjualanTunai? grandTotal;

  Summary(
      {this.totalPenjualanTunai,
      this.totalPenjualanQris,
      this.totalPenjualanKredit,
      this.grandTotal});

  Summary.fromJson(Map<String, dynamic> json) {
    totalPenjualanTunai = json['total_penjualan_tunai'] != null
        ? TotalPenjualanTunai.fromJson(json['total_penjualan_tunai'])
        : null;
    totalPenjualanQris = json['total_penjualan_qris'] != null
        ? TotalPenjualanTunai.fromJson(json['total_penjualan_qris'])
        : null;
    totalPenjualanKredit = json['total_penjualan_kredit'] != null
        ? TotalPenjualanTunai.fromJson(json['total_penjualan_kredit'])
        : null;
    grandTotal =
        json['grand_total'] != null ? TotalPenjualanTunai.fromJson(json['grand_total']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (totalPenjualanTunai != null) {
      data['total_penjualan_tunai'] = totalPenjualanTunai!.toJson();
    }
    if (totalPenjualanQris != null) {
      data['total_penjualan_qris'] = totalPenjualanQris!.toJson();
    }
    if (totalPenjualanKredit != null) {
      data['total_penjualan_kredit'] = totalPenjualanKredit!.toJson();
    }
    if (grandTotal != null) {
      data['grand_total'] = grandTotal!.toJson();
    }
    return data;
  }
}

class TotalPenjualanTunai {
  double? jumlah;
  double? modal;
  double? hasilPenjualan;
  double? keuntungan;

  TotalPenjualanTunai({this.jumlah, this.modal, this.hasilPenjualan, this.keuntungan});

  TotalPenjualanTunai.fromJson(Map<String, dynamic> json) {
    jumlah = json['jumlah'];
    modal = json['modal'];
    hasilPenjualan = json['hasil_penjualan'];
    keuntungan = json['keuntungan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jumlah'] = jumlah;
    data['modal'] = modal;
    data['hasil_penjualan'] = hasilPenjualan;
    data['keuntungan'] = keuntungan;
    return data;
  }
}
