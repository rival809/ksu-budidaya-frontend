class ListHighRiskModel {
  bool? success;
  List<DataListHighRisk>? data;
  String? message;

  ListHighRiskModel({this.success, this.data, this.message});

  ListHighRiskModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DataListHighRisk>[];
      json['data'].forEach((v) {
        data!.add(DataListHighRisk.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class DataListHighRisk {
  int? idHighRisk;
  String? idProduct;
  String? nmProduct;
  String? category;
  String? reason;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  ProductHighRisk? product;

  DataListHighRisk(
      {this.idHighRisk,
      this.idProduct,
      this.nmProduct,
      this.category,
      this.reason,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.product});

  DataListHighRisk.fromJson(Map<String, dynamic> json) {
    idHighRisk = json['id_high_risk'];
    idProduct = json['id_product'];
    nmProduct = json['nm_product'];
    category = json['category'];
    reason = json['reason'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product = json['product'] != null ? ProductHighRisk.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_high_risk'] = idHighRisk;
    data['id_product'] = idProduct;
    data['nm_product'] = nmProduct;
    data['category'] = category;
    data['reason'] = reason;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }

  DataListHighRisk copyWith({
    int? idHighRisk,
    String? idProduct,
    String? nmProduct,
    String? category,
    String? reason,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
    ProductHighRisk? product,
  }) {
    return DataListHighRisk(
      idHighRisk: idHighRisk ?? this.idHighRisk,
      idProduct: idProduct ?? this.idProduct,
      nmProduct: nmProduct ?? this.nmProduct,
      category: category ?? this.category,
      reason: reason ?? this.reason,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      product: product ?? this.product,
    );
  }
}

class ProductHighRisk {
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
  DivisiHighRisk? divisi;

  ProductHighRisk(
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
      this.divisi});

  ProductHighRisk.fromJson(Map<String, dynamic> json) {
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
    divisi = json['divisi'] != null ? DivisiHighRisk.fromJson(json['divisi']) : null;
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
    if (divisi != null) {
      data['divisi'] = divisi!.toJson();
    }
    return data;
  }
}

class DivisiHighRisk {
  String? idDivisi;
  String? nmDivisi;
  String? createdAt;
  String? updatedAt;

  DivisiHighRisk({this.idDivisi, this.nmDivisi, this.createdAt, this.updatedAt});

  DivisiHighRisk.fromJson(Map<String, dynamic> json) {
    idDivisi = json['id_divisi'];
    nmDivisi = json['nm_divisi'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_divisi'] = idDivisi;
    data['nm_divisi'] = nmDivisi;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
