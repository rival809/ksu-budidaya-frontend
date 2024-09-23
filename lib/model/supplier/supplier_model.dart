import 'package:ksu_budidaya/core.dart';
part 'supplier_model.g.dart';

class SupplierResult {
  bool? success;
  DataSupplier? data;
  String? message;

  SupplierResult({this.success, this.data, this.message});

  SupplierResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataSupplier.fromJson(json['data']) : null;
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

@HiveType(typeId: 7)
class DataSupplier {
  @HiveField(0)
  List<DataDetailSupplier>? dataSupplier;
  Paging? paging;

  DataSupplier({this.dataSupplier, this.paging});

  DataSupplier.fromJson(Map<String, dynamic> json) {
    if (json['data_supplier'] != null) {
      dataSupplier = <DataDetailSupplier>[];
      json['data_supplier'].forEach((v) {
        dataSupplier!.add(DataDetailSupplier.fromJson(v));
      });
    }
    paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dataSupplier != null) {
      data['data_supplier'] = dataSupplier!.map((v) => v.toJson()).toList();
    }
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 8)
class DataDetailSupplier {
  @HiveField(0)
  String? idSupplier;
  @HiveField(1)
  String? nmSupplier;
  @HiveField(2)
  String? nmPemilik;
  @HiveField(3)
  String? nmPic;
  @HiveField(4)
  String? noWa;
  @HiveField(5)
  String? alamat;
  @HiveField(6)
  String? hutangDagang;
  @HiveField(7)
  String? createdAt;
  @HiveField(8)
  String? updatedAt;

  DataDetailSupplier(
      {this.idSupplier,
      this.nmSupplier,
      this.nmPemilik,
      this.nmPic,
      this.noWa,
      this.alamat,
      this.hutangDagang,
      this.createdAt,
      this.updatedAt});

  DataDetailSupplier.fromJson(Map<String, dynamic> json) {
    idSupplier = json['id_supplier'];
    nmSupplier = json['nm_supplier'];
    nmPemilik = json['nm_pemilik'];
    nmPic = json['nm_pic'];
    noWa = json['no_wa'];
    alamat = json['alamat'];
    hutangDagang = json['hutang_dagang'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_supplier'] = idSupplier;
    data['nm_supplier'] = nmSupplier;
    data['nm_pemilik'] = nmPemilik;
    data['nm_pic'] = nmPic;
    data['no_wa'] = noWa;
    data['alamat'] = alamat;
    data['hutang_dagang'] = hutangDagang;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  DataDetailSupplier copyWith({
    String? idSupplier,
    String? nmSupplier,
    String? nmPemilik,
    String? nmPic,
    String? noWa,
    String? alamat,
    String? hutangDagang,
    String? createdAt,
    String? updatedAt,
  }) =>
      DataDetailSupplier(
        idSupplier: idSupplier ?? this.idSupplier,
        nmSupplier: nmSupplier ?? this.nmSupplier,
        nmPemilik: nmPemilik ?? this.nmPemilik,
        nmPic: nmPic ?? this.nmPic,
        noWa: noWa ?? this.noWa,
        alamat: alamat ?? this.alamat,
        hutangDagang: hutangDagang ?? this.hutangDagang,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
