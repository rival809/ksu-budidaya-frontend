import 'package:ksu_budidaya/core.dart';

class RefJenisCashResult {
  bool? success;
  List<DataRefJenisCash>? data;
  String? message;

  RefJenisCashResult({this.success, this.data, this.message});

  RefJenisCashResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DataRefJenisCash>[];
      json['data'].forEach((v) {
        data!.add(DataRefJenisCash.fromJson(v));
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

class DataRefJenisCash {
  int? idJenis;
  String? nmJenis;
  String? idCash;
  String? createdAt;
  String? updatedAt;

  DataRefJenisCash(
      {this.idJenis,
      this.nmJenis,
      this.idCash,
      this.createdAt,
      this.updatedAt});

  DataRefJenisCash.fromJson(Map<String, dynamic> json) {
    idJenis = json['id_jenis'];
    nmJenis = json['nm_jenis'];
    idCash = json['id_cash'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_jenis'] = idJenis;
    data['nm_jenis'] = nmJenis;
    data['id_cash'] = idCash;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  String jenisAsString() {
    return '${trimString(idJenis.toString())} - ${trimString(nmJenis)}';
  }
}
