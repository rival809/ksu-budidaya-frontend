import 'package:ksu_budidaya/core.dart';

class DetailStockTakeResult {
  bool? success;
  DataDetailStockTake? data;
  String? message;

  DetailStockTakeResult({this.success, this.data, this.message});

  DetailStockTakeResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataDetailStockTake.fromJson(json['data']) : null;
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

class DataDetailStockTake {
  List<DetailDataDetailStockTake>? dataStock;
  Paging? paging;

  DataDetailStockTake({this.dataStock, this.paging});

  DataDetailStockTake.fromJson(Map<String, dynamic> json) {
    if (json['data_stock'] != null) {
      dataStock = <DetailDataDetailStockTake>[];
      json['data_stock'].forEach((v) {
        dataStock!.add(DetailDataDetailStockTake.fromJson(v));
      });
    }
    paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dataStock != null) {
      data['data_stock'] = dataStock!.map((v) => v.toJson()).toList();
    }
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    return data;
  }
}

class DetailDataDetailStockTake {
  String? idProduct;
  String? nmProduct;
  String? divisi;
  String? stock;
  String? stocktake;
  String? selisih;
  String? petugas;
  bool? isSelisih;
  String? totalHargaJualStock;
  String? totalHargaJualStocktake;
  String? selisihHargaJual;

  DetailDataDetailStockTake(
      {this.idProduct,
      this.nmProduct,
      this.divisi,
      this.stocktake,
      this.stock,
      this.selisih,
      this.petugas,
      this.isSelisih,
      this.totalHargaJualStock,
      this.totalHargaJualStocktake,
      this.selisihHargaJual});

  DetailDataDetailStockTake.fromJson(Map<String, dynamic> json) {
    idProduct = checkModel(json['id_product']);
    nmProduct = checkModel(json['nm_product']);
    divisi = checkModel(json['divisi']);
    stocktake = checkModel(json['stock_take']);
    stock = checkModel(json['stock']);
    selisih = checkModel(json['selisih']);
    petugas = checkModel(json['petugas']);
    isSelisih = checkModel(json['is_selisih']);
    totalHargaJualStock = checkModel(json['total_harga_jual_stock']);
    totalHargaJualStocktake = checkModel(json['total_harga_jual_stocktake']);
    selisihHargaJual = checkModel(json['selisih_harga_jual']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_product'] = idProduct;
    data['nm_product'] = nmProduct;
    data['divisi'] = divisi;
    data['stock_take'] = stocktake;
    data['stock'] = stock;
    data['selisih'] = selisih;
    data['petugas'] = petugas;
    data['is_selisih'] = isSelisih;
    data['total_harga_jual_stock'] = totalHargaJualStock;
    data['total_harga_jual_stocktake'] = totalHargaJualStocktake;
    data['selisih_harga_jual'] = selisihHargaJual;
    return data;
  }
}
