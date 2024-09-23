import 'package:ksu_budidaya/core.dart';
part 'list_role_model.g.dart';

class ListRoleResult {
  bool? success;
  DataListRole? data;
  String? message;

  ListRoleResult({this.success, this.data, this.message});

  ListRoleResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataListRole.fromJson(json['data']) : null;
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

@HiveType(typeId: 4)
class DataListRole extends HiveObject {
  @HiveField(0)
  List<DataRoles>? dataRoles;
  @HiveField(1)
  Paging? paging;

  DataListRole({this.dataRoles, this.paging});

  factory DataListRole.fromJson(Map<String, dynamic> json) {
    return DataListRole(
      dataRoles: json['data_roles'] != null
          ? (json['data_roles'] as List)
              .map((v) => DataRoles.fromJson(v))
              .toList()
          : null,
      paging: json['paging'] != null ? Paging.fromJson(json['paging']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data_roles': dataRoles?.map((v) => v.toJson()).toList(),
      'paging': paging?.toJson(),
    };
  }
}

@HiveType(typeId: 5)
class DataRoles extends HiveObject {
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

  DataRoles(
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

  String roleAsString() {
    return '${trimString(idRole)} - ${trimString(roleName)}';
  }

  DataRoles copyWith({
    String? idRole,
    String? roleName,
    bool? stsAnggota,
    bool? stsPembayaranPinjaman,
    bool? stsKartuPiutang,
    bool? stsSupplier,
    bool? stsDivisi,
    bool? stsProduk,
    bool? stsPembelian,
    bool? stsPenjualan,
    bool? stsRetur,
    bool? stsPembayaranHutang,
    bool? stsEstimasi,
    bool? stsStocktakeHarian,
    bool? stsStockOpname,
    bool? stsCashInCashOut,
    bool? stsCashMovement,
    bool? stsUser,
    bool? stsRole,
    bool? stsCetakLabel,
    bool? stsCetakBarcode,
    bool? stsAwalAkhirHari,
    bool? stsDashboard,
    bool? stsLaporan,
    String? createdAt,
    String? updatedAt,
  }) =>
      DataRoles(
        idRole: idRole ?? this.idRole,
        roleName: roleName ?? this.roleName,
        stsAnggota: stsAnggota ?? this.stsAnggota,
        stsPembayaranPinjaman:
            stsPembayaranPinjaman ?? this.stsPembayaranPinjaman,
        stsKartuPiutang: stsKartuPiutang ?? this.stsKartuPiutang,
        stsSupplier: stsSupplier ?? this.stsSupplier,
        stsDivisi: stsDivisi ?? this.stsDivisi,
        stsProduk: stsProduk ?? this.stsProduk,
        stsPembelian: stsPembelian ?? this.stsPembelian,
        stsPenjualan: stsPenjualan ?? this.stsPenjualan,
        stsRetur: stsRetur ?? this.stsRetur,
        stsPembayaranHutang: stsPembayaranHutang ?? this.stsPembayaranHutang,
        stsEstimasi: stsEstimasi ?? this.stsEstimasi,
        stsStocktakeHarian: stsStocktakeHarian ?? this.stsStocktakeHarian,
        stsStockOpname: stsStockOpname ?? this.stsStockOpname,
        stsCashInCashOut: stsCashInCashOut ?? this.stsCashInCashOut,
        stsCashMovement: stsCashMovement ?? this.stsCashMovement,
        stsUser: stsUser ?? this.stsUser,
        stsRole: stsRole ?? this.stsRole,
        stsCetakLabel: stsCetakLabel ?? this.stsCetakLabel,
        stsCetakBarcode: stsCetakBarcode ?? this.stsCetakBarcode,
        stsAwalAkhirHari: stsAwalAkhirHari ?? this.stsAwalAkhirHari,
        stsDashboard: stsDashboard ?? this.stsDashboard,
        stsLaporan: stsLaporan ?? this.stsLaporan,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory DataRoles.fromJson(Map<String, dynamic> json) {
    return DataRoles(
      idRole: json['id_role'],
      roleName: json['role_name'],
      stsAnggota: json['sts_anggota'],
      stsPembayaranPinjaman: json['sts_pembayaran_pinjaman'],
      stsKartuPiutang: json['sts_kartu_piutang'],
      stsSupplier: json['sts_supplier'],
      stsDivisi: json['sts_divisi'],
      stsProduk: json['sts_produk'],
      stsPembelian: json['sts_pembelian'],
      stsPenjualan: json['sts_penjualan'],
      stsRetur: json['sts_retur'],
      stsPembayaranHutang: json['sts_pembayaran_hutang'],
      stsEstimasi: json['sts_estimasi'],
      stsStocktakeHarian: json['sts_stocktake_harian'],
      stsStockOpname: json['sts_stock_opname'],
      stsCashInCashOut: json['sts_cash_in_cash_out'],
      stsCashMovement: json['sts_cash_movement'],
      stsUser: json['sts_user'],
      stsRole: json['sts_role'],
      stsCetakLabel: json['sts_cetak_label'],
      stsCetakBarcode: json['sts_cetak_barcode'],
      stsAwalAkhirHari: json['sts_awal_akhir_hari'],
      stsDashboard: json['sts_dashboard'],
      stsLaporan: json['sts_laporan'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_role': idRole,
      'role_name': roleName,
      'sts_anggota': stsAnggota,
      'sts_pembayaran_pinjaman': stsPembayaranPinjaman,
      'sts_kartu_piutang': stsKartuPiutang,
      'sts_supplier': stsSupplier,
      'sts_divisi': stsDivisi,
      'sts_produk': stsProduk,
      'sts_pembelian': stsPembelian,
      'sts_penjualan': stsPenjualan,
      'sts_retur': stsRetur,
      'sts_pembayaran_hutang': stsPembayaranHutang,
      'sts_estimasi': stsEstimasi,
      'sts_stocktake_harian': stsStocktakeHarian,
      'sts_stock_opname': stsStockOpname,
      'sts_cash_in_cash_out': stsCashInCashOut,
      'sts_cash_movement': stsCashMovement,
      'sts_user': stsUser,
      'sts_role': stsRole,
      'sts_cetak_label': stsCetakLabel,
      'sts_cetak_barcode': stsCetakBarcode,
      'sts_awal_akhir_hari': stsAwalAkhirHari,
      'sts_dashboard': stsDashboard,
      'sts_laporan': stsLaporan,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

@HiveType(typeId: 6)
class Paging {
  @HiveField(0)
  int? page;
  @HiveField(1)
  int? totalItem;
  @HiveField(2)
  int? totalPage;

  Paging({this.page, this.totalItem, this.totalPage});

  Paging.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalItem = json['total_item'];
    totalPage = json['total_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['total_item'] = totalItem;
    data['total_page'] = totalPage;
    return data;
  }
}
