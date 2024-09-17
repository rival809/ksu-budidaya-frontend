class CreateRoleResult {
  bool? success;
  DataCreateRole? data;
  String? message;

  CreateRoleResult({this.success, this.data, this.message});

  CreateRoleResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataCreateRole.fromJson(json['data']) : null;
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

class DataCreateRole {
  String? idRole;
  String? roleName;
  bool? stsAnggota;
  bool? stsPembayaranPinjaman;
  bool? stsKartuPiutang;
  bool? stsSupplier;
  bool? stsDivisi;
  bool? stsProduk;
  bool? stsPembelian;
  bool? stsPenjualan;
  bool? stsRetur;
  bool? stsPembayaranHutang;
  bool? stsEstimasi;
  bool? stsStocktakeHarian;
  bool? stsStockOpname;
  bool? stsCashInCashOut;
  bool? stsCashMovement;
  bool? stsUser;
  bool? stsRole;
  bool? stsCetakLabel;
  bool? stsCetakBarcode;
  bool? stsAwalAkhirHari;
  bool? stsDashboard;
  bool? stsLaporan;
  String? createdAt;
  String? updatedAt;

  DataCreateRole(
      {this.idRole,
      this.roleName,
      this.stsAnggota,
      this.stsPembayaranPinjaman,
      this.stsKartuPiutang,
      this.stsSupplier,
      this.stsDivisi,
      this.stsProduk,
      this.stsPembelian,
      this.stsPenjualan,
      this.stsRetur,
      this.stsPembayaranHutang,
      this.stsEstimasi,
      this.stsStocktakeHarian,
      this.stsStockOpname,
      this.stsCashInCashOut,
      this.stsCashMovement,
      this.stsUser,
      this.stsRole,
      this.stsCetakLabel,
      this.stsCetakBarcode,
      this.stsAwalAkhirHari,
      this.stsDashboard,
      this.stsLaporan,
      this.createdAt,
      this.updatedAt});

  DataCreateRole.fromJson(Map<String, dynamic> json) {
    idRole = json['id_role'];
    roleName = json['role_name'];
    stsAnggota = json['sts_anggota'];
    stsPembayaranPinjaman = json['sts_pembayaran_pinjaman'];
    stsKartuPiutang = json['sts_kartu_piutang'];
    stsSupplier = json['sts_supplier'];
    stsDivisi = json['sts_divisi'];
    stsProduk = json['sts_produk'];
    stsPembelian = json['sts_pembelian'];
    stsPenjualan = json['sts_penjualan'];
    stsRetur = json['sts_retur'];
    stsPembayaranHutang = json['sts_pembayaran_hutang'];
    stsEstimasi = json['sts_estimasi'];
    stsStocktakeHarian = json['sts_stocktake_harian'];
    stsStockOpname = json['sts_stock_opname'];
    stsCashInCashOut = json['sts_cash_in_cash_out'];
    stsCashMovement = json['sts_cash_movement'];
    stsUser = json['sts_user'];
    stsRole = json['sts_role'];
    stsCetakLabel = json['sts_cetak_label'];
    stsCetakBarcode = json['sts_cetak_barcode'];
    stsAwalAkhirHari = json['sts_awal_akhir_hari'];
    stsDashboard = json['sts_dashboard'];
    stsLaporan = json['sts_laporan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_role'] = idRole;
    data['role_name'] = roleName;
    data['sts_anggota'] = stsAnggota;
    data['sts_pembayaran_pinjaman'] = stsPembayaranPinjaman;
    data['sts_kartu_piutang'] = stsKartuPiutang;
    data['sts_supplier'] = stsSupplier;
    data['sts_divisi'] = stsDivisi;
    data['sts_produk'] = stsProduk;
    data['sts_pembelian'] = stsPembelian;
    data['sts_penjualan'] = stsPenjualan;
    data['sts_retur'] = stsRetur;
    data['sts_pembayaran_hutang'] = stsPembayaranHutang;
    data['sts_estimasi'] = stsEstimasi;
    data['sts_stocktake_harian'] = stsStocktakeHarian;
    data['sts_stock_opname'] = stsStockOpname;
    data['sts_cash_in_cash_out'] = stsCashInCashOut;
    data['sts_cash_movement'] = stsCashMovement;
    data['sts_user'] = stsUser;
    data['sts_role'] = stsRole;
    data['sts_cetak_label'] = stsCetakLabel;
    data['sts_cetak_barcode'] = stsCetakBarcode;
    data['sts_awal_akhir_hari'] = stsAwalAkhirHari;
    data['sts_dashboard'] = stsDashboard;
    data['sts_laporan'] = stsLaporan;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
