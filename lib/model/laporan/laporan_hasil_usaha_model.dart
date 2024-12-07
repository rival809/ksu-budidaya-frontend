class LaporanHasilUsahaResult {
  bool? success;
  DataLaporanHasilUsaha? data;
  String? message;

  LaporanHasilUsahaResult({this.success, this.data, this.message});

  LaporanHasilUsahaResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? DataLaporanHasilUsaha.fromJson(json['data'])
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

class DataLaporanHasilUsaha {
  PenjualanLaporanHasilUsaha? penjualan;
  HargaPokokPenjualanLaporanHasilUsaha? hargaPokokPenjualan;
  BebanOperasionalLaporanHasilUsaha? bebanOperasional;
  PendapatanLainLaporanHasilUsaha? pendapatanLain;
  SisaHasilUsahaLaporanHasilUsaha? sisaHasilUsaha;

  DataLaporanHasilUsaha(
      {this.penjualan,
      this.hargaPokokPenjualan,
      this.bebanOperasional,
      this.pendapatanLain,
      this.sisaHasilUsaha});

  DataLaporanHasilUsaha.fromJson(Map<String, dynamic> json) {
    penjualan = json['penjualan'] != null
        ? PenjualanLaporanHasilUsaha.fromJson(json['penjualan'])
        : null;
    hargaPokokPenjualan = json['harga_pokok_penjualan'] != null
        ? HargaPokokPenjualanLaporanHasilUsaha.fromJson(
            json['harga_pokok_penjualan'])
        : null;
    bebanOperasional = json['beban_operasional'] != null
        ? BebanOperasionalLaporanHasilUsaha.fromJson(json['beban_operasional'])
        : null;
    pendapatanLain = json['pendapatan_lain'] != null
        ? PendapatanLainLaporanHasilUsaha.fromJson(json['pendapatan_lain'])
        : null;
    sisaHasilUsaha = json['sisa_hasil_usaha'] != null
        ? SisaHasilUsahaLaporanHasilUsaha.fromJson(json['sisa_hasil_usaha'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (penjualan != null) {
      data['penjualan'] = penjualan!.toJson();
    }
    if (hargaPokokPenjualan != null) {
      data['harga_pokok_penjualan'] = hargaPokokPenjualan!.toJson();
    }
    if (bebanOperasional != null) {
      data['beban_operasional'] = bebanOperasional!.toJson();
    }
    if (pendapatanLain != null) {
      data['pendapatan_lain'] = pendapatanLain!.toJson();
    }
    if (sisaHasilUsaha != null) {
      data['sisa_hasil_usaha'] = sisaHasilUsaha!.toJson();
    }
    return data;
  }
}

class PenjualanLaporanHasilUsaha {
  double? totalCurrentMonthSale;
  double? totalLastMonthSale;
  double? currentMonthCashSale;
  double? lastMonthCashSale;
  double? currentMonthCreditSale;
  double? lastMonthCreditSale;
  double? currentMonthQrisSale;
  double? lastMonthQrisSale;

  PenjualanLaporanHasilUsaha(
      {this.totalCurrentMonthSale,
      this.totalLastMonthSale,
      this.currentMonthCashSale,
      this.lastMonthCashSale,
      this.currentMonthCreditSale,
      this.lastMonthCreditSale,
      this.currentMonthQrisSale,
      this.lastMonthQrisSale});

  PenjualanLaporanHasilUsaha.fromJson(Map<String, dynamic> json) {
    totalCurrentMonthSale = json['total_current_month_sale'];
    totalLastMonthSale = json['total_last_month_sale'];
    currentMonthCashSale = json['current_month_cash_sale'];
    lastMonthCashSale = json['last_month_cash_sale'];
    currentMonthCreditSale = json['current_month_credit_sale'];
    lastMonthCreditSale = json['last_month_credit_sale'];
    currentMonthQrisSale = json['current_month_qris_sale'];
    lastMonthQrisSale = json['last_month_qris_sale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_current_month_sale'] = totalCurrentMonthSale;
    data['total_last_month_sale'] = totalLastMonthSale;
    data['current_month_cash_sale'] = currentMonthCashSale;
    data['last_month_cash_sale'] = lastMonthCashSale;
    data['current_month_credit_sale'] = currentMonthCreditSale;
    data['last_month_credit_sale'] = lastMonthCreditSale;
    data['current_month_qris_sale'] = currentMonthQrisSale;
    data['last_month_qris_sale'] = lastMonthQrisSale;
    return data;
  }
}

class HargaPokokPenjualanLaporanHasilUsaha {
  double? persediaanAwal;
  double? persediaanAwalLastMonth;
  double? pembelianTunai;
  double? pembelianTunaiLastMonth;
  double? pembelianKredit;
  double? pembelianKreditLastMonth;
  double? retur;
  double? returLastMonth;
  double? pembelianBersih;
  double? pembelianBersihLastMonth;
  double? barangSiapJual;
  double? barangSiapJualLastMonth;
  double? persediaanAkhir;
  double? persediaanAkhirLastMonth;
  double? hargaPokokPenjualan;
  double? hargaPokokPenjualanLastMonth;
  double? hasilUsahaKotor;
  double? hasilUsahaKotorLastMonth;

  HargaPokokPenjualanLaporanHasilUsaha(
      {this.persediaanAwal,
      this.persediaanAwalLastMonth,
      this.pembelianTunai,
      this.pembelianTunaiLastMonth,
      this.pembelianKredit,
      this.pembelianKreditLastMonth,
      this.pembelianBersih,
      this.pembelianBersihLastMonth,
      this.barangSiapJual,
      this.barangSiapJualLastMonth,
      this.persediaanAkhir,
      this.persediaanAkhirLastMonth,
      this.hargaPokokPenjualan,
      this.hargaPokokPenjualanLastMonth,
      this.hasilUsahaKotor,
      this.hasilUsahaKotorLastMonth});

  HargaPokokPenjualanLaporanHasilUsaha.fromJson(Map<String, dynamic> json) {
    persediaanAwal = json['persediaan_awal'];
    persediaanAwalLastMonth = json['persediaan_awal_last_month'];
    pembelianTunai = json['pembelian_tunai'];
    pembelianTunaiLastMonth = json['pembelian_tunai_last_month'];
    pembelianKredit = json['pembelian_kredit'];
    pembelianKreditLastMonth = json['pembelian_kredit_last_month'];
    pembelianBersih = json['pembelian_bersih'];
    pembelianBersihLastMonth = json['pembelian_bersih_last_month'];
    barangSiapJual = json['barang_siap_jual'];
    barangSiapJualLastMonth = json['barang_siap_jual_last_month'];
    persediaanAkhir = json['persediaan_akhir'];
    persediaanAkhirLastMonth = json['persediaan_akhir_last_month'];
    hargaPokokPenjualan = json['harga_pokok_penjualan'];
    hargaPokokPenjualanLastMonth = json['harga_pokok_penjualan_last_month'];
    hasilUsahaKotor = json['hasil_usaha_kotor'];
    hasilUsahaKotorLastMonth = json['hasil_usaha_kotor_last_month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['persediaan_awal'] = persediaanAwal;
    data['persediaan_awal_last_month'] = persediaanAwalLastMonth;
    data['pembelian_tunai'] = pembelianTunai;
    data['pembelian_tunai_last_month'] = pembelianTunaiLastMonth;
    data['pembelian_kredit'] = pembelianKredit;
    data['pembelian_kredit_last_month'] = pembelianKreditLastMonth;
    data['pembelian_bersih'] = pembelianBersih;
    data['pembelian_bersih_last_month'] = pembelianBersihLastMonth;
    data['barang_siap_jual'] = barangSiapJual;
    data['barang_siap_jual_last_month'] = barangSiapJualLastMonth;
    data['persediaan_akhir'] = persediaanAkhir;
    data['persediaan_akhir_last_month'] = persediaanAkhirLastMonth;
    data['harga_pokok_penjualan'] = hargaPokokPenjualan;
    data['harga_pokok_penjualan_last_month'] = hargaPokokPenjualanLastMonth;
    data['hasil_usaha_kotor'] = hasilUsahaKotor;
    data['hasil_usaha_kotor_last_month'] = hasilUsahaKotorLastMonth;
    return data;
  }
}

class BebanOperasionalLaporanHasilUsaha {
  double? bebanGaji;
  double? bebanGajiLastMonth;
  double? uangMakan;
  double? uangMakanLastMonth;
  double? thrKaryawan;
  double? thrKaryawanLastMonth;
  double? bebanAdm;
  double? bebanAdmLastMonth;
  double? bebanPerlengkapan;
  double? bebanPerlengkapanLastMonth;
  double? bebanPenyInventaris;
  double? bebanPenyInventarisLastMonth;
  double? bebanPenyGedung;
  double? bebanPenyGedungLastMonth;
  double? pemeliharaanInventaris;
  double? pemeliharaanInventarisLastMonth;
  double? pemeliharaanGedung;
  double? pemeliharaanGedungLastMonth;
  double? pengeluaranLain;
  double? pengeluaranLainLastMonth;
  double? totalBebanOperasional;
  double? totalBebanOperasionalLastMonth;
  double? hasilUsahaBersih;
  double? hasilUsahaBersihLastMonth;

  BebanOperasionalLaporanHasilUsaha(
      {this.bebanGaji,
      this.bebanGajiLastMonth,
      this.uangMakan,
      this.uangMakanLastMonth,
      this.thrKaryawan,
      this.thrKaryawanLastMonth,
      this.bebanAdm,
      this.bebanAdmLastMonth,
      this.bebanPerlengkapan,
      this.bebanPerlengkapanLastMonth,
      this.bebanPenyInventaris,
      this.bebanPenyInventarisLastMonth,
      this.bebanPenyGedung,
      this.bebanPenyGedungLastMonth,
      this.pemeliharaanInventaris,
      this.pemeliharaanInventarisLastMonth,
      this.pemeliharaanGedung,
      this.pemeliharaanGedungLastMonth,
      this.pengeluaranLain,
      this.pengeluaranLainLastMonth,
      this.totalBebanOperasional,
      this.totalBebanOperasionalLastMonth,
      this.hasilUsahaBersih,
      this.hasilUsahaBersihLastMonth});

  BebanOperasionalLaporanHasilUsaha.fromJson(Map<String, dynamic> json) {
    bebanGaji = json['beban_gaji'];
    bebanGajiLastMonth = json['beban_gaji_last_month'];
    uangMakan = json['uang_makan'];
    uangMakanLastMonth = json['uang_makan_last_month'];
    thrKaryawan = json['thr_karyawan'];
    thrKaryawanLastMonth = json['thr_karyawan_last_month'];
    bebanAdm = json['beban_adm'];
    bebanAdmLastMonth = json['beban_adm_last_month'];
    bebanPerlengkapan = json['beban_perlengkapan'];
    bebanPerlengkapanLastMonth = json['beban_perlengkapan_last_month'];
    bebanPenyInventaris = json['beban_peny_inventaris'];
    bebanPenyInventarisLastMonth = json['beban_peny_inventaris_last_month'];
    bebanPenyGedung = json['beban_peny_gedung'];
    bebanPenyGedungLastMonth = json['beban_peny_gedung_last_month'];
    pemeliharaanInventaris = json['pemeliharaan_inventaris'];
    pemeliharaanInventarisLastMonth =
        json['pemeliharaan_inventaris_last_month'];
    pemeliharaanGedung = json['pemeliharaan_gedung'];
    pemeliharaanGedungLastMonth = json['pemeliharaan_gedung_last_month'];
    pengeluaranLain = json['pengeluaran_lain'];
    pengeluaranLainLastMonth = json['pengeluaran_lain_last_month'];
    totalBebanOperasional = json['total_beban_operasional'];
    totalBebanOperasionalLastMonth = json['total_beban_operasional_last_month'];
    hasilUsahaBersih = json['hasil_usaha_bersih'];
    hasilUsahaBersihLastMonth = json['hasil_usaha_bersih_last_month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['beban_gaji'] = bebanGaji;
    data['beban_gaji_last_month'] = bebanGajiLastMonth;
    data['uang_makan'] = uangMakan;
    data['uang_makan_last_month'] = uangMakanLastMonth;
    data['thr_karyawan'] = thrKaryawan;
    data['thr_karyawan_last_month'] = thrKaryawanLastMonth;
    data['beban_adm'] = bebanAdm;
    data['beban_adm_last_month'] = bebanAdmLastMonth;
    data['beban_perlengkapan'] = bebanPerlengkapan;
    data['beban_perlengkapan_last_month'] = bebanPerlengkapanLastMonth;
    data['beban_peny_inventaris'] = bebanPenyInventaris;
    data['beban_peny_inventaris_last_month'] = bebanPenyInventarisLastMonth;
    data['beban_peny_gedung'] = bebanPenyGedung;
    data['beban_peny_gedung_last_month'] = bebanPenyGedungLastMonth;
    data['pemeliharaan_inventaris'] = pemeliharaanInventaris;
    data['pemeliharaan_inventaris_last_month'] =
        pemeliharaanInventarisLastMonth;
    data['pemeliharaan_gedung'] = pemeliharaanGedung;
    data['pemeliharaan_gedung_last_month'] = pemeliharaanGedungLastMonth;
    data['pengeluaran_lain'] = pengeluaranLain;
    data['pengeluaran_lain_last_month'] = pengeluaranLainLastMonth;
    data['total_beban_operasional'] = totalBebanOperasional;
    data['total_beban_operasional_last_month'] = totalBebanOperasionalLastMonth;
    data['hasil_usaha_bersih'] = hasilUsahaBersih;
    data['hasil_usaha_bersih_last_month'] = hasilUsahaBersihLastMonth;
    return data;
  }
}

class PendapatanLainLaporanHasilUsaha {
  double? tenant;
  double? tenantLastMonth;
  double? lainLain;
  double? lainLainLastMonth;
  double? totalPendapatanLain;
  double? totalPendapatanLainLastMonth;

  PendapatanLainLaporanHasilUsaha(
      {this.tenant,
      this.tenantLastMonth,
      this.lainLain,
      this.lainLainLastMonth,
      this.totalPendapatanLain,
      this.totalPendapatanLainLastMonth});

  PendapatanLainLaporanHasilUsaha.fromJson(Map<String, dynamic> json) {
    tenant = json['tenant'];
    tenantLastMonth = json['tenant_last_month'];
    lainLain = json['lain_lain'];
    lainLainLastMonth = json['lain_lain_last_month'];
    totalPendapatanLain = json['total_pendapatan_lain'];
    totalPendapatanLainLastMonth = json['total_pendapatan_lain_last_month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tenant'] = tenant;
    data['tenant_last_month'] = tenantLastMonth;
    data['lain_lain'] = lainLain;
    data['lain_lain_last_month'] = lainLainLastMonth;
    data['total_pendapatan_lain'] = totalPendapatanLain;
    data['total_pendapatan_lain_last_month'] = totalPendapatanLainLastMonth;
    return data;
  }
}

class SisaHasilUsahaLaporanHasilUsaha {
  double? sisaHasilUsaha;
  double? sisaHasilUsahaLastMonth;

  SisaHasilUsahaLaporanHasilUsaha(
      {this.sisaHasilUsaha, this.sisaHasilUsahaLastMonth});

  SisaHasilUsahaLaporanHasilUsaha.fromJson(Map<String, dynamic> json) {
    sisaHasilUsaha = json['sisa_hasil_usaha'];
    sisaHasilUsahaLastMonth = json['sisa_hasil_usaha_last_month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sisa_hasil_usaha'] = sisaHasilUsaha;
    data['sisa_hasil_usaha_last_month'] = sisaHasilUsahaLastMonth;
    return data;
  }
}

class RowLaporanHasilUsaha {
  String? no;
  String? uraian;
  double? currentMonth;
  double? lastMonth;

  RowLaporanHasilUsaha({
    this.no,
    this.uraian,
    this.currentMonth,
    this.lastMonth,
  });

  RowLaporanHasilUsaha.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    uraian = json['uraian'];
    currentMonth = json['current_month'];
    lastMonth = json['last_month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['no'] = no;
    data['uraian'] = uraian;
    data['current_month'] = currentMonth;
    data['last_month'] = lastMonth;
    return data;
  }
}

class RowLaporanRealisasiPendapatan {
  String? uraian;
  double? jan;
  double? feb;
  double? mar;
  double? apr;
  double? mei;
  double? jun;
  double? jul;
  double? agu;
  double? sep;
  double? okt;
  double? nov;
  double? des;
  double? jumlah;

  RowLaporanRealisasiPendapatan({
    this.uraian,
    this.jan,
    this.feb,
    this.mar,
    this.apr,
    this.mei,
    this.jun,
    this.jul,
    this.agu,
    this.sep,
    this.okt,
    this.nov,
    this.des,
    this.jumlah,
  });
  RowLaporanRealisasiPendapatan.fromJson(Map<String, dynamic> json) {
    uraian = json['uraian'];
    jan = json['jan'];
    feb = json['feb'];
    mar = json['mar'];
    apr = json['apr'];
    mei = json['mei'];
    jun = json['jun'];
    jul = json['jul'];
    agu = json['agu'];
    sep = json['sep'];
    okt = json['okt'];
    nov = json['nov'];
    des = json['des'];
    jumlah = json['jumlah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uraian'] = uraian;
    data['jan'] = jan;
    data['feb'] = feb;
    data['mar'] = mar;
    data['apr'] = apr;
    data['mei'] = mei;
    data['jun'] = jun;
    data['jul'] = jul;
    data['agu'] = agu;
    data['sep'] = sep;
    data['okt'] = okt;
    data['nov'] = nov;
    data['des'] = des;
    data['jumlah'] = jumlah;
    return data;
  }
}

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
