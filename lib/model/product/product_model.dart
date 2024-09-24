import 'package:ksu_budidaya/core.dart';

class ProductResult {
  bool? success;
  DataProduct? data;
  String? message;

  ProductResult({this.success, this.data, this.message});

  ProductResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataProduct.fromJson(json['data']) : null;
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

class DataProduct {
  List<DataDetailProduct>? dataProduct;
  Paging? paging;
  TotalKeseluruhan? totalKeseluruhan;

  DataProduct({this.dataProduct, this.paging, this.totalKeseluruhan});

  DataProduct.fromJson(Map<String, dynamic> json) {
    if (json['data_product'] != null) {
      dataProduct = <DataDetailProduct>[];
      json['data_product'].forEach((v) {
        dataProduct!.add(DataDetailProduct.fromJson(v));
      });
    }
    paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
    totalKeseluruhan = json['total_keseluruhan'] != null
        ? TotalKeseluruhan.fromJson(json['total_keseluruhan'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dataProduct != null) {
      data['data_product'] = dataProduct!.map((v) => v.toJson()).toList();
    }
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    if (totalKeseluruhan != null) {
      data['total_keseluruhan'] = totalKeseluruhan!.toJson();
    }
    return data;
  }
}

class DataDetailProduct {
  String? idProduct;
  String? nmProduct;
  String? idDivisi;
  String? idSupplier;
  String? hargaJual;
  String? hargaBeli;
  bool? statusProduct;
  int? jumlah;
  String? keterangan;
  String? createdAt;
  String? updatedAt;
  int? totalJual;
  int? totalBeli;

  DataDetailProduct(
      {this.idProduct,
      this.nmProduct,
      this.idDivisi,
      this.idSupplier,
      this.hargaJual,
      this.hargaBeli,
      this.statusProduct,
      this.jumlah,
      this.keterangan,
      this.createdAt,
      this.updatedAt,
      this.totalJual,
      this.totalBeli});

  DataDetailProduct.fromJson(Map<String, dynamic> json) {
    idProduct = json['id_product'];
    nmProduct = json['nm_product'];
    idDivisi = json['id_divisi'];
    idSupplier = json['id_supplier'];
    hargaJual = json['harga_jual'];
    hargaBeli = json['harga_beli'];
    statusProduct = json['status_product'];
    jumlah = json['jumlah'];
    keterangan = json['keterangan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalJual = json['total_jual'];
    totalBeli = json['total_beli'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_product'] = idProduct;
    data['nm_product'] = nmProduct;
    data['id_divisi'] = idDivisi;
    data['id_supplier'] = idSupplier;
    data['harga_jual'] = hargaJual;
    data['harga_beli'] = hargaBeli;
    data['status_product'] = statusProduct;
    data['jumlah'] = jumlah;
    data['keterangan'] = keterangan;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['total_jual'] = totalJual;
    data['total_beli'] = totalBeli;
    return data;
  }
}

class TotalKeseluruhan {
  int? totalJumlah;
  int? totalJual;
  int? totalBeli;

  TotalKeseluruhan({this.totalJumlah, this.totalJual, this.totalBeli});

  TotalKeseluruhan.fromJson(Map<String, dynamic> json) {
    totalJumlah = json['total_jumlah'];
    totalJual = json['total_jual'];
    totalBeli = json['total_beli'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_jumlah'] = totalJumlah;
    data['total_jual'] = totalJual;
    data['total_beli'] = totalBeli;
    return data;
  }
}
