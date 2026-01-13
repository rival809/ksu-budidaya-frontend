import 'package:ksu_budidaya/core.dart';
part 'product_model.g.dart';

@HiveType(typeId: 16)
class ProductResult {
  @HiveField(0)
  bool? success;
  @HiveField(1)
  DataProduct? data;
  @HiveField(2)
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

@HiveType(typeId: 17)
class DataProduct {
  @HiveField(0)
  List<DataDetailProduct>? dataProduct;
  @HiveField(1)
  PagingRole? paging;
  @HiveField(2)
  TotalKeseluruhan? totalKeseluruhan;

  DataProduct({this.dataProduct, this.paging, this.totalKeseluruhan});

  DataProduct.fromJson(Map<String, dynamic> json) {
    if (json['data_product'] != null) {
      dataProduct = <DataDetailProduct>[];
      json['data_product'].forEach((v) {
        dataProduct!.add(DataDetailProduct.fromJson(v));
      });
    }
    paging = json['paging'] != null ? PagingRole.fromJson(json['paging']) : null;
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

@HiveType(typeId: 18)
class DataDetailProduct {
  @HiveField(0)
  String? idProduct;
  @HiveField(1)
  String? nmProduct;
  @HiveField(2)
  String? idDivisi;
  @HiveField(3)
  String? idSupplier;
  @HiveField(4)
  String? hargaJual;
  @HiveField(5)
  String? hargaBeli;
  @HiveField(6)
  bool? statusProduct;
  @HiveField(7)
  int? jumlah;
  @HiveField(8)
  String? keterangan;
  @HiveField(9)
  String? createdAt;
  @HiveField(10)
  String? updatedAt;
  @HiveField(11)
  double? totalJual;
  @HiveField(12)
  double? totalBeli;

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

  DataDetailProduct copyWith({
    String? idProduct,
    String? nmProduct,
    String? idDivisi,
    String? idSupplier,
    String? hargaJual,
    String? hargaBeli,
    bool? statusProduct,
    int? jumlah,
    String? keterangan,
    String? createdAt,
    String? updatedAt,
    double? totalJual,
    double? totalBeli,
  }) =>
      DataDetailProduct(
        idProduct: idProduct ?? this.idProduct,
        nmProduct: nmProduct ?? this.nmProduct,
        idDivisi: idDivisi ?? this.idDivisi,
        idSupplier: idSupplier ?? this.idSupplier,
        hargaJual: hargaJual ?? this.hargaJual,
        hargaBeli: hargaBeli ?? this.hargaBeli,
        statusProduct: statusProduct ?? this.statusProduct,
        jumlah: jumlah ?? this.jumlah,
        keterangan: keterangan ?? this.keterangan,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        totalJual: totalJual ?? this.totalJual,
        totalBeli: totalBeli ?? this.totalBeli,
      );

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

@HiveType(typeId: 19)
class TotalKeseluruhan {
  @HiveField(0)
  double? totalJumlah;
  @HiveField(1)
  double? totalJual;
  @HiveField(2)
  double? totalBeli;

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
