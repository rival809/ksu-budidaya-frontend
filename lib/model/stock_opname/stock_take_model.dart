import 'package:ksu_budidaya/core.dart';

class StockTakeResult {
  bool? success;
  DataStockTake? data;
  String? message;

  StockTakeResult({this.success, this.data, this.message});

  StockTakeResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataStockTake.fromJson(json['data']) : null;
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

class DataStockTake {
  List<DetailDataStockTake>? dataStock;
  Paging? paging;
  TotalData? totalData;

  DataStockTake({
    this.dataStock,
    this.totalData,
    this.paging,
  });

  DataStockTake.fromJson(Map<String, dynamic> json) {
    if (json['data_stock'] != null) {
      dataStock = <DetailDataStockTake>[];
      json['data_stock'].forEach((v) {
        dataStock!.add(DetailDataStockTake.fromJson(v));
      });
    }
    totalData = json['total_data'] != null ? TotalData.fromJson(json['total_data']) : null;
    paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dataStock != null) {
      data['data_stock'] = dataStock!.map((v) => v.toJson()).toList();
    }
    if (totalData != null) {
      data['total_data'] = totalData!.toJson();
    }
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    return data;
  }
}

class DetailDataStockTake {
  String? idDivisi;
  String? nmDivisi;
  String? stock;
  String? stockTake;
  String? selisih;
  String? totalHargaJualStock;
  String? totalHargaJualStocktake;
  String? selisihHargaJual;

  DetailDataStockTake({
    this.idDivisi,
    this.nmDivisi,
    this.stock,
    this.stockTake,
    this.totalHargaJualStock,
    this.totalHargaJualStocktake,
    this.selisihHargaJual,
    this.selisih,
  });

  DetailDataStockTake.fromJson(Map<String, dynamic> json) {
    idDivisi = checkModel(json['id_divisi']);
    nmDivisi = checkModel(json['nm_divisi']);
    stockTake = checkModel(json['stock_take']);
    stock = checkModel(json['stock']);
    selisih = checkModel(json['selisih']);
    totalHargaJualStock = checkModel(json['total_harga_jual_stock']);
    totalHargaJualStocktake = checkModel(json['total_harga_jual_stocktake']);
    selisihHargaJual = checkModel(json['selisih_harga_jual']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_divisi'] = idDivisi;
    data['nm_divisi'] = nmDivisi;
    data['stock'] = stock;
    data['stock_take'] = stockTake;
    data['total_harga_jual_stock'] = totalHargaJualStock;
    data['total_harga_jual_stocktake'] = totalHargaJualStocktake;
    data['selisih_harga_jual'] = selisihHargaJual;
    data['selisih'] = selisih;
    return data;
  }
}

class TotalData {
  double? totalStock;
  double? totalHargaJualStock;
  double? totalStockTake;
  double? totalHargaJualStocktake;
  double? totalSelisih;
  double? totalSelisihHargaJual;

  TotalData(
      {this.totalStock,
      this.totalHargaJualStock,
      this.totalStockTake,
      this.totalHargaJualStocktake,
      this.totalSelisih,
      this.totalSelisihHargaJual});

  TotalData.fromJson(Map<String, dynamic> json) {
    totalStock = json['total_stock'];
    totalHargaJualStock = json['total_harga_jual_stock'];
    totalStockTake = json['total_stock_take'];
    totalHargaJualStocktake = json['total_harga_jual_stocktake'];
    totalSelisih = json['total_selisih'];
    totalSelisihHargaJual = json['total_selisih_harga_jual'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_stock'] = totalStock;
    data['total_harga_jual_stock'] = totalHargaJualStock;
    data['total_stock_take'] = totalStockTake;
    data['total_harga_jual_stocktake'] = totalHargaJualStocktake;
    data['total_selisih'] = totalSelisih;
    data['total_selisih_harga_jual'] = totalSelisihHargaJual;
    return data;
  }
}
