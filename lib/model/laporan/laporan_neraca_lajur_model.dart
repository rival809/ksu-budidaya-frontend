class LaporanNeracaLajurModel {
  bool? success;
  DataNeracaLajur? data;
  String? message;

  LaporanNeracaLajurModel({this.success, this.data, this.message});

  LaporanNeracaLajurModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataNeracaLajur.fromJson(json['data']) : null;
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

class DataNeracaLajur {
  DataNeraca? dataNeraca;
  TotalNeraca? totalNeraca;

  DataNeracaLajur({this.dataNeraca, this.totalNeraca});

  DataNeracaLajur.fromJson(Map<String, dynamic> json) {
    dataNeraca = json['data_neraca'] != null
        ? DataNeraca.fromJson(json['data_neraca'])
        : null;
    totalNeraca = json['total_neraca'] != null
        ? TotalNeraca.fromJson(json['total_neraca'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dataNeraca != null) {
      data['data_neraca'] = dataNeraca!.toJson();
    }
    if (totalNeraca != null) {
      data['total_neraca'] = totalNeraca!.toJson();
    }
    return data;
  }
}

class DataNeraca {
  DetailDataNeracaLajur? kas;
  DetailDataNeracaLajur? bankBri;
  DetailDataNeracaLajur? piutangDagang;
  DetailDataNeracaLajur? persediaan;
  DetailDataNeracaLajur? penghapusanPersediaan;
  DetailDataNeracaLajur? inventaris;
  DetailDataNeracaLajur? akumulasiPenyusutanInventaris;
  DetailDataNeracaLajur? gedung;
  DetailDataNeracaLajur? akumulasiPenyusutanGedung;
  DetailDataNeracaLajur? utangDagang;
  DetailDataNeracaLajur? utangSp;
  DetailDataNeracaLajur? modalTidakTetap;
  DetailDataNeracaLajur? modalDisetor;
  DetailDataNeracaLajur? usahaLainToko;
  DetailDataNeracaLajur? modalUnitToko;
  DetailDataNeracaLajur? shuTh2023;
  DetailDataNeracaLajur? shuTh2024;
  DetailDataNeracaLajur? shuTh2025;
  DetailDataNeracaLajur? shuTh2026;
  DetailDataNeracaLajur? shuTh2027;
  DetailDataNeracaLajur? shuTh2028;
  DetailDataNeracaLajur? shuTh2029;
  DetailDataNeracaLajur? shuTh2030;
  DetailDataNeracaLajur? shuTh2031;
  DetailDataNeracaLajur? shuTh2032;
  DetailDataNeracaLajur? shuTh2033;
  DetailDataNeracaLajur? shuTh2034;
  DetailDataNeracaLajur? shuTh2035;
  DetailDataNeracaLajur? shuTh2036;
  DetailDataNeracaLajur? shuTh2037;
  DetailDataNeracaLajur? shuTh2038;
  DetailDataNeracaLajur? shuTh2039;
  DetailDataNeracaLajur? shuTh2040;
  DetailDataNeracaLajur? shuTh2041;
  DetailDataNeracaLajur? shuTh2042;
  DetailDataNeracaLajur? shuTh2043;
  DetailDataNeracaLajur? shuTh2044;
  DetailDataNeracaLajur? shuTh2045;
  DetailDataNeracaLajur? shuTh2046;
  DetailDataNeracaLajur? shuTh2047;
  DetailDataNeracaLajur? shuTh2048;
  DetailDataNeracaLajur? shuTh2049;
  DetailDataNeracaLajur? shuTh2050;
  DetailDataNeracaLajur? shuTh2051;
  DetailDataNeracaLajur? shuTh2052;
  DetailDataNeracaLajur? shuTh2053;
  DetailDataNeracaLajur? shuTh2054;
  DetailDataNeracaLajur? shuTh2055;
  DetailDataNeracaLajur? shuTh2056;
  DetailDataNeracaLajur? shuTh2057;
  DetailDataNeracaLajur? shuTh2058;
  DetailDataNeracaLajur? shuTh2059;
  DetailDataNeracaLajur? shuTh2060;
  DetailDataNeracaLajur? shuTh2061;
  DetailDataNeracaLajur? shuTh2062;
  DetailDataNeracaLajur? shuTh2063;
  DetailDataNeracaLajur? shuTh2064;
  DetailDataNeracaLajur? shuTh2065;
  DetailDataNeracaLajur? shuTh2066;
  DetailDataNeracaLajur? shuTh2067;
  DetailDataNeracaLajur? shuTh2068;
  DetailDataNeracaLajur? shuTh2069;
  DetailDataNeracaLajur? shuTh2070;
  DetailDataNeracaLajur? penjualanTunai;
  DetailDataNeracaLajur? penjualanKredit;
  DetailDataNeracaLajur? penjualanQris;
  DetailDataNeracaLajur? pendapatanSewa;
  DetailDataNeracaLajur? pendapatanLain;
  DetailDataNeracaLajur? pembelianTunai;
  DetailDataNeracaLajur? pembelianKredit;
  DetailDataNeracaLajur? returPembelian;
  DetailDataNeracaLajur? bebanGaji;
  DetailDataNeracaLajur? uangMakan;
  DetailDataNeracaLajur? thrKaryawan;
  DetailDataNeracaLajur? bebanAdmUmum;
  DetailDataNeracaLajur? bebanPerlengkapan;
  DetailDataNeracaLajur? bebanPenyusutanInventaris;
  DetailDataNeracaLajur? bebanPenyusutanGedung;
  DetailDataNeracaLajur? pemeliharaanInventaris;
  DetailDataNeracaLajur? pemeliharaanGedung;
  DetailDataNeracaLajur? pengeluaranLain;
  DetailDataNeracaLajur? pengeluaranPusatLain;

  DataNeraca(
      {this.kas,
      this.bankBri,
      this.piutangDagang,
      this.persediaan,
      this.penghapusanPersediaan,
      this.inventaris,
      this.akumulasiPenyusutanInventaris,
      this.gedung,
      this.akumulasiPenyusutanGedung,
      this.utangDagang,
      this.utangSp,
      this.modalTidakTetap,
      this.modalDisetor,
      this.usahaLainToko,
      this.modalUnitToko,
      this.shuTh2023,
      this.shuTh2024,
      this.shuTh2025,
      this.shuTh2026,
      this.shuTh2027,
      this.shuTh2028,
      this.shuTh2029,
      this.shuTh2030,
      this.shuTh2031,
      this.shuTh2032,
      this.shuTh2033,
      this.shuTh2034,
      this.shuTh2035,
      this.shuTh2036,
      this.shuTh2037,
      this.shuTh2038,
      this.shuTh2039,
      this.shuTh2040,
      this.shuTh2041,
      this.shuTh2042,
      this.shuTh2043,
      this.shuTh2044,
      this.shuTh2045,
      this.shuTh2046,
      this.shuTh2047,
      this.shuTh2048,
      this.shuTh2049,
      this.shuTh2050,
      this.shuTh2051,
      this.shuTh2052,
      this.shuTh2053,
      this.shuTh2054,
      this.shuTh2055,
      this.shuTh2056,
      this.shuTh2057,
      this.shuTh2058,
      this.shuTh2059,
      this.shuTh2060,
      this.shuTh2061,
      this.shuTh2062,
      this.shuTh2063,
      this.shuTh2064,
      this.shuTh2065,
      this.shuTh2066,
      this.shuTh2067,
      this.shuTh2068,
      this.shuTh2069,
      this.shuTh2070,
      this.penjualanTunai,
      this.penjualanKredit,
      this.penjualanQris,
      this.pendapatanSewa,
      this.pendapatanLain,
      this.pembelianTunai,
      this.pembelianKredit,
      this.returPembelian,
      this.bebanGaji,
      this.uangMakan,
      this.thrKaryawan,
      this.bebanAdmUmum,
      this.bebanPerlengkapan,
      this.bebanPenyusutanInventaris,
      this.bebanPenyusutanGedung,
      this.pemeliharaanInventaris,
      this.pemeliharaanGedung,
      this.pengeluaranLain,
      this.pengeluaranPusatLain});

  DataNeraca.fromJson(Map<String, dynamic> json) {
    kas = json['kas'] != null
        ? DetailDataNeracaLajur.fromJson(json['kas'])
        : null;
    bankBri = json['bank_bri'] != null
        ? DetailDataNeracaLajur.fromJson(json['bank_bri'])
        : null;
    piutangDagang = json['piutang_dagang'] != null
        ? DetailDataNeracaLajur.fromJson(json['piutang_dagang'])
        : null;
    persediaan = json['persediaan'] != null
        ? DetailDataNeracaLajur.fromJson(json['persediaan'])
        : null;
    penghapusanPersediaan = json['penghapusan_persediaan'] != null
        ? DetailDataNeracaLajur.fromJson(json['penghapusan_persediaan'])
        : null;
    inventaris = json['inventaris'] != null
        ? DetailDataNeracaLajur.fromJson(json['inventaris'])
        : null;
    akumulasiPenyusutanInventaris =
        json['akumulasi_penyusutan_inventaris'] != null
            ? DetailDataNeracaLajur.fromJson(
                json['akumulasi_penyusutan_inventaris'])
            : null;
    gedung = json['gedung'] != null
        ? DetailDataNeracaLajur.fromJson(json['gedung'])
        : null;
    akumulasiPenyusutanGedung = json['akumulasi_penyusutan_gedung'] != null
        ? DetailDataNeracaLajur.fromJson(json['akumulasi_penyusutan_gedung'])
        : null;
    utangDagang = json['utang_dagang'] != null
        ? DetailDataNeracaLajur.fromJson(json['utang_dagang'])
        : null;
    utangSp = json['utang_sp'] != null
        ? DetailDataNeracaLajur.fromJson(json['utang_sp'])
        : null;
    modalTidakTetap = json['modal_tidak_tetap'] != null
        ? DetailDataNeracaLajur.fromJson(json['modal_tidak_tetap'])
        : null;
    modalDisetor = json['modal_disetor'] != null
        ? DetailDataNeracaLajur.fromJson(json['modal_disetor'])
        : null;
    usahaLainToko = json['usaha_lain_toko'] != null
        ? DetailDataNeracaLajur.fromJson(json['usaha_lain_toko'])
        : null;
    modalUnitToko = json['modal_unit_toko'] != null
        ? DetailDataNeracaLajur.fromJson(json['modal_unit_toko'])
        : null;
    shuTh2023 = json['shu_th_2023'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2023'])
        : null;
    shuTh2024 = json['shu_th_2024'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2024'])
        : null;
    shuTh2025 = json['shu_th_2025'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2025'])
        : null;
    shuTh2026 = json['shu_th_2026'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2026'])
        : null;
    shuTh2027 = json['shu_th_2027'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2027'])
        : null;
    shuTh2028 = json['shu_th_2028'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2028'])
        : null;
    shuTh2029 = json['shu_th_2029'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2029'])
        : null;
    shuTh2030 = json['shu_th_2030'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2030'])
        : null;
    shuTh2031 = json['shu_th_2031'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2031'])
        : null;
    shuTh2032 = json['shu_th_2032'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2032'])
        : null;
    shuTh2033 = json['shu_th_2033'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2033'])
        : null;
    shuTh2034 = json['shu_th_2034'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2034'])
        : null;
    shuTh2035 = json['shu_th_2035'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2035'])
        : null;
    shuTh2036 = json['shu_th_2036'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2036'])
        : null;
    shuTh2037 = json['shu_th_2037'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2037'])
        : null;
    shuTh2038 = json['shu_th_2038'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2038'])
        : null;
    shuTh2039 = json['shu_th_2039'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2039'])
        : null;
    shuTh2040 = json['shu_th_2040'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2040'])
        : null;
    shuTh2041 = json['shu_th_2041'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2041'])
        : null;
    shuTh2042 = json['shu_th_2042'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2042'])
        : null;
    shuTh2043 = json['shu_th_2043'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2043'])
        : null;
    shuTh2044 = json['shu_th_2044'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2044'])
        : null;
    shuTh2045 = json['shu_th_2045'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2045'])
        : null;
    shuTh2046 = json['shu_th_2046'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2046'])
        : null;
    shuTh2047 = json['shu_th_2047'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2047'])
        : null;
    shuTh2048 = json['shu_th_2048'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2048'])
        : null;
    shuTh2049 = json['shu_th_2049'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2049'])
        : null;
    shuTh2050 = json['shu_th_2050'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2050'])
        : null;
    shuTh2051 = json['shu_th_2051'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2051'])
        : null;
    shuTh2052 = json['shu_th_2052'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2052'])
        : null;
    shuTh2053 = json['shu_th_2053'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2053'])
        : null;
    shuTh2054 = json['shu_th_2054'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2054'])
        : null;
    shuTh2055 = json['shu_th_2055'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2055'])
        : null;
    shuTh2056 = json['shu_th_2056'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2056'])
        : null;
    shuTh2057 = json['shu_th_2057'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2057'])
        : null;
    shuTh2058 = json['shu_th_2058'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2058'])
        : null;
    shuTh2059 = json['shu_th_2059'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2059'])
        : null;
    shuTh2060 = json['shu_th_2060'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2060'])
        : null;
    shuTh2061 = json['shu_th_2061'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2061'])
        : null;
    shuTh2062 = json['shu_th_2062'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2062'])
        : null;
    shuTh2063 = json['shu_th_2063'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2063'])
        : null;
    shuTh2064 = json['shu_th_2064'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2064'])
        : null;
    shuTh2065 = json['shu_th_2065'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2065'])
        : null;
    shuTh2066 = json['shu_th_2066'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2066'])
        : null;
    shuTh2067 = json['shu_th_2067'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2067'])
        : null;
    shuTh2068 = json['shu_th_2068'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2068'])
        : null;
    shuTh2069 = json['shu_th_2069'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2069'])
        : null;
    shuTh2070 = json['shu_th_2070'] != null
        ? DetailDataNeracaLajur.fromJson(json['shu_th_2070'])
        : null;
    penjualanTunai = json['penjualan_tunai'] != null
        ? DetailDataNeracaLajur.fromJson(json['penjualan_tunai'])
        : null;
    penjualanKredit = json['penjualan_kredit'] != null
        ? DetailDataNeracaLajur.fromJson(json['penjualan_kredit'])
        : null;
    penjualanQris = json['penjualan_qris'] != null
        ? DetailDataNeracaLajur.fromJson(json['penjualan_qris'])
        : null;
    pendapatanSewa = json['pendapatan_sewa'] != null
        ? DetailDataNeracaLajur.fromJson(json['pendapatan_sewa'])
        : null;
    pendapatanLain = json['pendapatan_lain'] != null
        ? DetailDataNeracaLajur.fromJson(json['pendapatan_lain'])
        : null;
    pembelianTunai = json['pembelian_tunai'] != null
        ? DetailDataNeracaLajur.fromJson(json['pembelian_tunai'])
        : null;
    pembelianKredit = json['pembelian_kredit'] != null
        ? DetailDataNeracaLajur.fromJson(json['pembelian_kredit'])
        : null;
    returPembelian = json['retur_pembelian'] != null
        ? DetailDataNeracaLajur.fromJson(json['retur_pembelian'])
        : null;
    bebanGaji = json['beban_gaji'] != null
        ? DetailDataNeracaLajur.fromJson(json['beban_gaji'])
        : null;
    uangMakan = json['uang_makan'] != null
        ? DetailDataNeracaLajur.fromJson(json['uang_makan'])
        : null;
    thrKaryawan = json['thr_karyawan'] != null
        ? DetailDataNeracaLajur.fromJson(json['thr_karyawan'])
        : null;
    bebanAdmUmum = json['beban_adm_umum'] != null
        ? DetailDataNeracaLajur.fromJson(json['beban_adm_umum'])
        : null;
    bebanPerlengkapan = json['beban_perlengkapan'] != null
        ? DetailDataNeracaLajur.fromJson(json['beban_perlengkapan'])
        : null;
    bebanPenyusutanInventaris = json['beban_penyusutan_inventaris'] != null
        ? DetailDataNeracaLajur.fromJson(json['beban_penyusutan_inventaris'])
        : null;
    bebanPenyusutanGedung = json['beban_penyusutan_gedung'] != null
        ? DetailDataNeracaLajur.fromJson(json['beban_penyusutan_gedung'])
        : null;
    pemeliharaanInventaris = json['pemeliharaan_inventaris'] != null
        ? DetailDataNeracaLajur.fromJson(json['pemeliharaan_inventaris'])
        : null;
    pemeliharaanGedung = json['pemeliharaan_gedung'] != null
        ? DetailDataNeracaLajur.fromJson(json['pemeliharaan_gedung'])
        : null;
    pengeluaranLain = json['pengeluaran_lain'] != null
        ? DetailDataNeracaLajur.fromJson(json['pengeluaran_lain'])
        : null;
    pengeluaranPusatLain = json['pengeluaran_pusat_lain'] != null
        ? DetailDataNeracaLajur.fromJson(json['pengeluaran_pusat_lain'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (kas != null) {
      data['kas'] = kas!.toJson();
    }
    if (bankBri != null) {
      data['bank_bri'] = bankBri!.toJson();
    }
    if (piutangDagang != null) {
      data['piutang_dagang'] = piutangDagang!.toJson();
    }
    if (persediaan != null) {
      data['persediaan'] = persediaan!.toJson();
    }
    if (penghapusanPersediaan != null) {
      data['penghapusan_persediaan'] = penghapusanPersediaan!.toJson();
    }
    if (inventaris != null) {
      data['inventaris'] = inventaris!.toJson();
    }
    if (akumulasiPenyusutanInventaris != null) {
      data['akumulasi_penyusutan_inventaris'] =
          akumulasiPenyusutanInventaris!.toJson();
    }
    if (gedung != null) {
      data['gedung'] = gedung!.toJson();
    }
    if (akumulasiPenyusutanGedung != null) {
      data['akumulasi_penyusutan_gedung'] = akumulasiPenyusutanGedung!.toJson();
    }
    if (utangDagang != null) {
      data['utang_dagang'] = utangDagang!.toJson();
    }
    if (utangSp != null) {
      data['utang_sp'] = utangSp!.toJson();
    }
    if (modalTidakTetap != null) {
      data['modal_tidak_tetap'] = modalTidakTetap!.toJson();
    }
    if (modalDisetor != null) {
      data['modal_disetor'] = modalDisetor!.toJson();
    }
    if (usahaLainToko != null) {
      data['usaha_lain_toko'] = usahaLainToko!.toJson();
    }
    if (modalUnitToko != null) {
      data['modal_unit_toko'] = modalUnitToko!.toJson();
    }
    if (shuTh2023 != null) {
      data['shu_th_2023'] = shuTh2023!.toJson();
    }
    if (shuTh2024 != null) {
      data['shu_th_2024'] = shuTh2024!.toJson();
    }
    if (shuTh2025 != null) {
      data['shu_th_2025'] = shuTh2025!.toJson();
    }
    if (shuTh2026 != null) {
      data['shu_th_2026'] = shuTh2026!.toJson();
    }
    if (shuTh2027 != null) {
      data['shu_th_2027'] = shuTh2027!.toJson();
    }
    if (shuTh2028 != null) {
      data['shu_th_2028'] = shuTh2028!.toJson();
    }
    if (shuTh2029 != null) {
      data['shu_th_2029'] = shuTh2029!.toJson();
    }
    if (shuTh2030 != null) {
      data['shu_th_2030'] = shuTh2030!.toJson();
    }
    if (shuTh2031 != null) {
      data['shu_th_2031'] = shuTh2031!.toJson();
    }
    if (shuTh2032 != null) {
      data['shu_th_2032'] = shuTh2032!.toJson();
    }
    if (shuTh2033 != null) {
      data['shu_th_2033'] = shuTh2033!.toJson();
    }
    if (shuTh2034 != null) {
      data['shu_th_2034'] = shuTh2034!.toJson();
    }
    if (shuTh2035 != null) {
      data['shu_th_2035'] = shuTh2035!.toJson();
    }
    if (shuTh2036 != null) {
      data['shu_th_2036'] = shuTh2036!.toJson();
    }
    if (shuTh2037 != null) {
      data['shu_th_2037'] = shuTh2037!.toJson();
    }
    if (shuTh2038 != null) {
      data['shu_th_2038'] = shuTh2038!.toJson();
    }
    if (shuTh2039 != null) {
      data['shu_th_2039'] = shuTh2039!.toJson();
    }
    if (shuTh2040 != null) {
      data['shu_th_2040'] = shuTh2040!.toJson();
    }
    if (shuTh2041 != null) {
      data['shu_th_2041'] = shuTh2041!.toJson();
    }
    if (shuTh2042 != null) {
      data['shu_th_2042'] = shuTh2042!.toJson();
    }
    if (shuTh2043 != null) {
      data['shu_th_2043'] = shuTh2043!.toJson();
    }
    if (shuTh2044 != null) {
      data['shu_th_2044'] = shuTh2044!.toJson();
    }
    if (shuTh2045 != null) {
      data['shu_th_2045'] = shuTh2045!.toJson();
    }
    if (shuTh2046 != null) {
      data['shu_th_2046'] = shuTh2046!.toJson();
    }
    if (shuTh2047 != null) {
      data['shu_th_2047'] = shuTh2047!.toJson();
    }
    if (shuTh2048 != null) {
      data['shu_th_2048'] = shuTh2048!.toJson();
    }
    if (shuTh2049 != null) {
      data['shu_th_2049'] = shuTh2049!.toJson();
    }
    if (shuTh2050 != null) {
      data['shu_th_2050'] = shuTh2050!.toJson();
    }
    if (shuTh2051 != null) {
      data['shu_th_2051'] = shuTh2051!.toJson();
    }
    if (shuTh2052 != null) {
      data['shu_th_2052'] = shuTh2052!.toJson();
    }
    if (shuTh2053 != null) {
      data['shu_th_2053'] = shuTh2053!.toJson();
    }
    if (shuTh2054 != null) {
      data['shu_th_2054'] = shuTh2054!.toJson();
    }
    if (shuTh2055 != null) {
      data['shu_th_2055'] = shuTh2055!.toJson();
    }
    if (shuTh2056 != null) {
      data['shu_th_2056'] = shuTh2056!.toJson();
    }
    if (shuTh2057 != null) {
      data['shu_th_2057'] = shuTh2057!.toJson();
    }
    if (shuTh2058 != null) {
      data['shu_th_2058'] = shuTh2058!.toJson();
    }
    if (shuTh2059 != null) {
      data['shu_th_2059'] = shuTh2059!.toJson();
    }
    if (shuTh2060 != null) {
      data['shu_th_2060'] = shuTh2060!.toJson();
    }
    if (shuTh2061 != null) {
      data['shu_th_2061'] = shuTh2061!.toJson();
    }
    if (shuTh2062 != null) {
      data['shu_th_2062'] = shuTh2062!.toJson();
    }
    if (shuTh2063 != null) {
      data['shu_th_2063'] = shuTh2063!.toJson();
    }
    if (shuTh2064 != null) {
      data['shu_th_2064'] = shuTh2064!.toJson();
    }
    if (shuTh2065 != null) {
      data['shu_th_2065'] = shuTh2065!.toJson();
    }
    if (shuTh2066 != null) {
      data['shu_th_2066'] = shuTh2066!.toJson();
    }
    if (shuTh2067 != null) {
      data['shu_th_2067'] = shuTh2067!.toJson();
    }
    if (shuTh2068 != null) {
      data['shu_th_2068'] = shuTh2068!.toJson();
    }
    if (shuTh2069 != null) {
      data['shu_th_2069'] = shuTh2069!.toJson();
    }
    if (shuTh2070 != null) {
      data['shu_th_2070'] = shuTh2070!.toJson();
    }
    if (penjualanTunai != null) {
      data['penjualan_tunai'] = penjualanTunai!.toJson();
    }
    if (penjualanKredit != null) {
      data['penjualan_kredit'] = penjualanKredit!.toJson();
    }
    if (penjualanQris != null) {
      data['penjualan_qris'] = penjualanQris!.toJson();
    }
    if (pendapatanSewa != null) {
      data['pendapatan_sewa'] = pendapatanSewa!.toJson();
    }
    if (pendapatanLain != null) {
      data['pendapatan_lain'] = pendapatanLain!.toJson();
    }
    if (pembelianTunai != null) {
      data['pembelian_tunai'] = pembelianTunai!.toJson();
    }
    if (pembelianKredit != null) {
      data['pembelian_kredit'] = pembelianKredit!.toJson();
    }
    if (returPembelian != null) {
      data['retur_pembelian'] = returPembelian!.toJson();
    }
    if (bebanGaji != null) {
      data['beban_gaji'] = bebanGaji!.toJson();
    }
    if (uangMakan != null) {
      data['uang_makan'] = uangMakan!.toJson();
    }
    if (thrKaryawan != null) {
      data['thr_karyawan'] = thrKaryawan!.toJson();
    }
    if (bebanAdmUmum != null) {
      data['beban_adm_umum'] = bebanAdmUmum!.toJson();
    }
    if (bebanPerlengkapan != null) {
      data['beban_perlengkapan'] = bebanPerlengkapan!.toJson();
    }
    if (bebanPenyusutanInventaris != null) {
      data['beban_penyusutan_inventaris'] = bebanPenyusutanInventaris!.toJson();
    }
    if (bebanPenyusutanGedung != null) {
      data['beban_penyusutan_gedung'] = bebanPenyusutanGedung!.toJson();
    }
    if (pemeliharaanInventaris != null) {
      data['pemeliharaan_inventaris'] = pemeliharaanInventaris!.toJson();
    }
    if (pemeliharaanGedung != null) {
      data['pemeliharaan_gedung'] = pemeliharaanGedung!.toJson();
    }
    if (pengeluaranLain != null) {
      data['pengeluaran_lain'] = pengeluaranLain!.toJson();
    }
    if (pengeluaranPusatLain != null) {
      data['pengeluaran_pusat_lain'] = pengeluaranPusatLain!.toJson();
    }
    return data;
  }
}

class DetailDataNeracaLajur {
  DataDKNeracaLajur? neracaAwal;
  DataDKNeracaLajur? neracaMutasi;
  DataDKNeracaLajur? neracaPercobaan;
  DataDKNeracaLajur? neracaSaldo;
  DataDKNeracaLajur? hasilUsaha;
  DataDKNeracaLajur? neracaAkhir;

  DetailDataNeracaLajur(
      {this.neracaAwal,
      this.neracaMutasi,
      this.neracaPercobaan,
      this.neracaSaldo,
      this.hasilUsaha,
      this.neracaAkhir});

  DetailDataNeracaLajur.fromJson(Map<String, dynamic> json) {
    neracaAwal = json['neraca_awal'] != null
        ? DataDKNeracaLajur.fromJson(json['neraca_awal'])
        : null;
    neracaMutasi = json['neraca_mutasi'] != null
        ? DataDKNeracaLajur.fromJson(json['neraca_mutasi'])
        : null;
    neracaPercobaan = json['neraca_percobaan'] != null
        ? DataDKNeracaLajur.fromJson(json['neraca_percobaan'])
        : null;
    neracaSaldo = json['neraca_saldo'] != null
        ? DataDKNeracaLajur.fromJson(json['neraca_saldo'])
        : null;
    hasilUsaha = json['hasil_usaha'] != null
        ? DataDKNeracaLajur.fromJson(json['hasil_usaha'])
        : null;
    neracaAkhir = json['neraca_akhir'] != null
        ? DataDKNeracaLajur.fromJson(json['neraca_akhir'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (neracaAwal != null) {
      data['neraca_awal'] = neracaAwal!.toJson();
    }
    if (neracaMutasi != null) {
      data['neraca_mutasi'] = neracaMutasi!.toJson();
    }
    if (neracaPercobaan != null) {
      data['neraca_percobaan'] = neracaPercobaan!.toJson();
    }
    if (neracaSaldo != null) {
      data['neraca_saldo'] = neracaSaldo!.toJson();
    }
    if (hasilUsaha != null) {
      data['hasil_usaha'] = hasilUsaha!.toJson();
    }
    if (neracaAkhir != null) {
      data['neraca_akhir'] = neracaAkhir!.toJson();
    }
    return data;
  }
}

class DataDKNeracaLajur {
  int? debit;
  int? kredit;

  DataDKNeracaLajur({this.debit, this.kredit});

  DataDKNeracaLajur.fromJson(Map<String, dynamic> json) {
    debit = json['debit'];
    kredit = json['kredit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['debit'] = debit;
    data['kredit'] = kredit;
    return data;
  }
}

class TotalNeraca {
  DataDKNeracaLajur? totalNeracaAwal;
  DataDKNeracaLajur? totalNeracaMutasi;
  DataDKNeracaLajur? totalNeracaPercobaan;
  DataDKNeracaLajur? totalNeracaSaldo;
  DataDKNeracaLajur? totalHasilUsaha;
  DataDKNeracaLajur? totalNeracaAkhir;

  TotalNeraca(
      {this.totalNeracaAwal,
      this.totalNeracaMutasi,
      this.totalNeracaPercobaan,
      this.totalNeracaSaldo,
      this.totalHasilUsaha,
      this.totalNeracaAkhir});

  TotalNeraca.fromJson(Map<String, dynamic> json) {
    totalNeracaAwal = json['total_neraca_awal'] != null
        ? DataDKNeracaLajur.fromJson(json['total_neraca_awal'])
        : null;
    totalNeracaMutasi = json['total_neraca_mutasi'] != null
        ? DataDKNeracaLajur.fromJson(json['total_neraca_mutasi'])
        : null;
    totalNeracaPercobaan = json['total_neraca_percobaan'] != null
        ? DataDKNeracaLajur.fromJson(json['total_neraca_percobaan'])
        : null;
    totalNeracaSaldo = json['total_neraca_saldo'] != null
        ? DataDKNeracaLajur.fromJson(json['total_neraca_saldo'])
        : null;
    totalHasilUsaha = json['total_hasil_usaha'] != null
        ? DataDKNeracaLajur.fromJson(json['total_hasil_usaha'])
        : null;
    totalNeracaAkhir = json['total_neraca_akhir'] != null
        ? DataDKNeracaLajur.fromJson(json['total_neraca_akhir'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (totalNeracaAwal != null) {
      data['total_neraca_awal'] = totalNeracaAwal!.toJson();
    }
    if (totalNeracaMutasi != null) {
      data['total_neraca_mutasi'] = totalNeracaMutasi!.toJson();
    }
    if (totalNeracaPercobaan != null) {
      data['total_neraca_percobaan'] = totalNeracaPercobaan!.toJson();
    }
    if (totalNeracaSaldo != null) {
      data['total_neraca_saldo'] = totalNeracaSaldo!.toJson();
    }
    if (totalHasilUsaha != null) {
      data['total_hasil_usaha'] = totalHasilUsaha!.toJson();
    }
    if (totalNeracaAkhir != null) {
      data['total_neraca_akhir'] = totalNeracaAkhir!.toJson();
    }
    return data;
  }
}
