import 'package:hive/hive.dart';
part 'login_model.g.dart';

@HiveType(typeId: 0)
class LoginResult {
  @HiveField(0)
  bool? success;
  @HiveField(1)
  DataLogin? data;
  @HiveField(2)
  String? message;

  LoginResult({this.success, this.data, this.message});

  LoginResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataLogin.fromJson(json['data']) : null;
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

@HiveType(typeId: 1)
class DataLogin {
  @HiveField(0)
  UserDataLogin? userData;
  @HiveField(1)
  RoleDataLogin? roleData;

  DataLogin({this.userData, this.roleData});

  DataLogin.fromJson(Map<String, dynamic> json) {
    userData = json['user_data'] != null
        ? UserDataLogin.fromJson(json['user_data'])
        : null;
    roleData = json['role_data'] != null
        ? RoleDataLogin.fromJson(json['role_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userData != null) {
      data['user_data'] = userData!.toJson();
    }
    if (roleData != null) {
      data['role_data'] = roleData!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 2)
class UserDataLogin {
  @HiveField(0)
  String? username;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? token;

  UserDataLogin({this.username, this.name, this.token});

  UserDataLogin.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['name'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['name'] = name;
    data['token'] = token;
    return data;
  }
}

@HiveType(typeId: 3)
class RoleDataLogin {
  @HiveField(0)
  String? idRole;
  @HiveField(1)
  String? roleName;
  @HiveField(2)
  bool? stsAnggota;
  @HiveField(3)
  bool? stsPembayaranPinjaman;
  @HiveField(4)
  bool? stsKartuPiutang;
  @HiveField(5)
  bool? stsSupplier;
  @HiveField(6)
  bool? stsDivisi;
  @HiveField(7)
  bool? stsProduk;
  @HiveField(8)
  bool? stsPembelian;
  @HiveField(9)
  bool? stsPenjualan;
  @HiveField(10)
  bool? stsRetur;
  @HiveField(11)
  bool? stsPembayaranHutang;
  @HiveField(12)
  bool? stsEstimasi;
  @HiveField(13)
  bool? stsStocktakeHarian;
  @HiveField(14)
  bool? stsStockOpname;
  @HiveField(15)
  bool? stsCashInCashOut;
  @HiveField(16)
  bool? stsCashMovement;
  @HiveField(17)
  bool? stsUser;
  @HiveField(18)
  bool? stsRole;
  @HiveField(19)
  bool? stsCetakLabel;
  @HiveField(20)
  bool? stsCetakBarcode;
  @HiveField(21)
  bool? stsAwalAkhirHari;
  @HiveField(22)
  bool? stsDashboard;
  @HiveField(23)
  bool? stsLaporan;
  @HiveField(24)
  String? createdAt;
  @HiveField(25)
  String? updatedAt;

  RoleDataLogin(
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

  RoleDataLogin.fromJson(Map<String, dynamic> json) {
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
