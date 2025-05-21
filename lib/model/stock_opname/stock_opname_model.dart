import 'package:ksu_budidaya/core.dart';

class StockOpnameModel {
  bool? success;
  DataStockOpname? data;
  String? message;

  StockOpnameModel({this.success, this.data, this.message});

  StockOpnameModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataStockOpname.fromJson(json['data']) : null;
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

class DataStockOpname {
  String? idStocktake;
  String? tgStocktake;
  String? idProduct;
  String? nmProduct;
  String? stokAwal;
  String? stokAkhir;
  String? selisih;
  String? username;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? totalHargaJualStock;
  String? totalHargaJualStocktake;
  String? selisihHargaJual;

  DataStockOpname(
      {this.idStocktake,
      this.tgStocktake,
      this.idProduct,
      this.nmProduct,
      this.stokAwal,
      this.stokAkhir,
      this.selisih,
      this.username,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.totalHargaJualStock,
      this.totalHargaJualStocktake,
      this.selisihHargaJual});

  DataStockOpname.fromJson(Map<String, dynamic> json) {
    idStocktake = checkModel(json['id_stocktake']);
    tgStocktake = checkModel(json['tg_stocktake']);
    idProduct = checkModel(json['id_product']);
    nmProduct = checkModel(json['nm_product']);
    stokAwal = checkModel(json['stok_awal']);
    stokAkhir = checkModel(json['stok_akhir']);
    selisih = checkModel(json['selisih']);
    username = checkModel(json['username']);
    name = checkModel(json['name']);
    createdAt = checkModel(json['created_at']);
    updatedAt = checkModel(json['updated_at']);
    totalHargaJualStock = checkModel(json['total_harga_jual_stock']);
    totalHargaJualStocktake = checkModel(json['total_harga_jual_stocktake']);
    selisihHargaJual = checkModel(json['selisih_harga_jual']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_stocktake'] = idStocktake;
    data['tg_stocktake'] = tgStocktake;
    data['id_product'] = idProduct;
    data['nm_product'] = nmProduct;
    data['stok_awal'] = stokAwal;
    data['stok_akhir'] = stokAkhir;
    data['selisih'] = selisih;
    data['username'] = username;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['total_harga_jual_stock'] = totalHargaJualStock;
    data['total_harga_jual_stocktake'] = totalHargaJualStocktake;
    data['selisih_harga_jual'] = selisihHargaJual;
    return data;
  }
}
