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

  DataStockTake({this.dataStock, this.paging});

  DataStockTake.fromJson(Map<String, dynamic> json) {
    if (json['data_stock'] != null) {
      dataStock = <DetailDataStockTake>[];
      json['data_stock'].forEach((v) {
        dataStock!.add(DetailDataStockTake.fromJson(v));
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

class DetailDataStockTake {
  String? idProduct;
  String? nmProduct;
  String? divisi;
  String? sisa;
  String? stock;
  String? selisih;
  String? petugas;
  bool? isSelisih;

  DetailDataStockTake(
      {this.idProduct,
      this.nmProduct,
      this.divisi,
      this.sisa,
      this.stock,
      this.selisih,
      this.petugas,
      this.isSelisih});

  DetailDataStockTake.fromJson(Map<String, dynamic> json) {
    idProduct = checkModel(json['id_product']);
    nmProduct = checkModel(json['nm_product']);
    divisi = checkModel(json['divisi']);
    sisa = checkModel(json['sisa']);
    stock = checkModel(json['stock']);
    selisih = checkModel(json['selisih']);
    petugas = checkModel(json['petugas']);
    isSelisih = checkModel(json['is_selisih']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_product'] = idProduct;
    data['nm_product'] = nmProduct;
    data['divisi'] = divisi;
    data['sisa'] = sisa;
    data['stock'] = stock;
    data['selisih'] = selisih;
    data['petugas'] = petugas;
    data['is_selisih'] = isSelisih;
    return data;
  }
}
