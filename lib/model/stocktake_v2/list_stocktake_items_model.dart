import 'package:ksu_budidaya/core.dart';

class ListStocktakeItemsModel {
  bool? success;
  DataListStocktakeItems? data;
  String? message;

  ListStocktakeItemsModel({this.success, this.data, this.message});

  ListStocktakeItemsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataListStocktakeItems.fromJson(json['data']) : null;
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

class DataListStocktakeItems {
  List<DetailListStocktakeItemsilDataListStocktakeItems>? data;
  Pagination? pagination;

  DataListStocktakeItems({this.data, this.pagination});

  DataListStocktakeItems.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DetailListStocktakeItemsilDataListStocktakeItems>[];
      json['data'].forEach((v) {
        data!.add(DetailListStocktakeItemsilDataListStocktakeItems.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class DetailListStocktakeItemsilDataListStocktakeItems {
  double? idStocktakeItem;
  String? idStocktakeSession;
  String? idProduct;
  String? nmProduct;
  String? nmDivisi;
  String? hargaBeli;
  String? hargaJual;
  double? stokSistem;
  double? stokFisik;
  double? selisih;
  bool? isCounted;
  bool? isFlagged;
  String? flagReason;
  bool? isHighRisk;
  bool? hasTransaction;
  String? notes;
  String? countedAt;
  String? createdAt;
  String? updatedAt;
  Valuasi? valuasi;

  DetailListStocktakeItemsilDataListStocktakeItems(
      {this.idStocktakeItem,
      this.idStocktakeSession,
      this.idProduct,
      this.nmProduct,
      this.nmDivisi,
      this.hargaBeli,
      this.hargaJual,
      this.stokSistem,
      this.stokFisik,
      this.selisih,
      this.isCounted,
      this.isFlagged,
      this.flagReason,
      this.isHighRisk,
      this.hasTransaction,
      this.notes,
      this.countedAt,
      this.createdAt,
      this.updatedAt,
      this.valuasi});

  DetailListStocktakeItemsilDataListStocktakeItems.fromJson(Map<String, dynamic> json) {
    idStocktakeItem =
        json['id_stocktake_item'] != null ? (json['id_stocktake_item'] as num).toDouble() : null;
    idStocktakeSession = json['id_stocktake_session'];
    idProduct = json['id_product'];
    nmProduct = json['nm_product'];
    nmDivisi = json['nm_divisi'];
    hargaBeli = json['harga_beli'];
    hargaJual = json['harga_jual'];
    stokSistem = json['stok_sistem'] != null ? (json['stok_sistem'] as num).toDouble() : null;
    stokFisik = json['stok_fisik'] != null ? (json['stok_fisik'] as num).toDouble() : null;
    selisih = json['selisih'] != null ? (json['selisih'] as num).toDouble() : null;
    isCounted = json['is_counted'];
    isFlagged = json['is_flagged'];
    flagReason = json['flag_reason'];
    isHighRisk = json['is_high_risk'];
    hasTransaction = json['has_transaction'];
    notes = json['notes'];
    countedAt = json['counted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    valuasi = json['valuasi'] != null ? Valuasi.fromJson(json['valuasi']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_stocktake_item'] = idStocktakeItem;
    data['id_stocktake_session'] = idStocktakeSession;
    data['id_product'] = idProduct;
    data['nm_product'] = nmProduct;
    data['nm_divisi'] = nmDivisi;
    data['harga_beli'] = hargaBeli;
    data['harga_jual'] = hargaJual;
    data['stok_sistem'] = stokSistem;
    data['stok_fisik'] = stokFisik;
    data['selisih'] = selisih;
    data['is_counted'] = isCounted;
    data['is_flagged'] = isFlagged;
    data['flag_reason'] = flagReason;
    data['is_high_risk'] = isHighRisk;
    data['has_transaction'] = hasTransaction;
    data['notes'] = notes;
    data['counted_at'] = countedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (valuasi != null) {
      data['valuasi'] = valuasi!.toJson();
    }
    return data;
  }
}

class Valuasi {
  double? qtySistem;
  double? valuasiSistemBeli;
  double? valuasiSistemJual;
  double? qtyFisik;
  double? valuasiFisikBeli;
  double? valuasiFisikJual;
  double? qtySelisih;
  double? valuasiSelisihBeli;
  double? valuasiSelisihJual;

  Valuasi(
      {this.qtySistem,
      this.valuasiSistemBeli,
      this.valuasiSistemJual,
      this.qtyFisik,
      this.valuasiFisikBeli,
      this.valuasiFisikJual,
      this.qtySelisih,
      this.valuasiSelisihBeli,
      this.valuasiSelisihJual});

  Valuasi.fromJson(Map<String, dynamic> json) {
    qtySistem = json['qty_sistem'] != null ? (json['qty_sistem'] as num).toDouble() : null;
    valuasiSistemBeli = json['valuasi_sistem_beli'] != null
        ? (json['valuasi_sistem_beli'] as num).toDouble()
        : null;
    valuasiSistemJual = json['valuasi_sistem_jual'] != null
        ? (json['valuasi_sistem_jual'] as num).toDouble()
        : null;
    qtyFisik = json['qty_fisik'] != null ? (json['qty_fisik'] as num).toDouble() : null;
    valuasiFisikBeli =
        json['valuasi_fisik_beli'] != null ? (json['valuasi_fisik_beli'] as num).toDouble() : null;
    valuasiFisikJual =
        json['valuasi_fisik_jual'] != null ? (json['valuasi_fisik_jual'] as num).toDouble() : null;
    qtySelisih = json['qty_selisih'] != null ? (json['qty_selisih'] as num).toDouble() : null;
    valuasiSelisihBeli = json['valuasi_selisih_beli'] != null
        ? (json['valuasi_selisih_beli'] as num).toDouble()
        : null;
    valuasiSelisihJual = json['valuasi_selisih_jual'] != null
        ? (json['valuasi_selisih_jual'] as num).toDouble()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['qty_sistem'] = qtySistem;
    data['valuasi_sistem_beli'] = valuasiSistemBeli;
    data['valuasi_sistem_jual'] = valuasiSistemJual;
    data['qty_fisik'] = qtyFisik;
    data['valuasi_fisik_beli'] = valuasiFisikBeli;
    data['valuasi_fisik_jual'] = valuasiFisikJual;
    data['qty_selisih'] = qtySelisih;
    data['valuasi_selisih_beli'] = valuasiSelisihBeli;
    data['valuasi_selisih_jual'] = valuasiSelisihJual;
    return data;
  }
}
