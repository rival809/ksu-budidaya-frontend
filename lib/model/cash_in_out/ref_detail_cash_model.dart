class RefDetailCashResult {
  bool? success;
  List<DataRefDetailCash>? data;
  String? message;

  RefDetailCashResult({this.success, this.data, this.message});

  RefDetailCashResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DataRefDetailCash>[];
      json['data'].forEach((v) {
        data!.add(DataRefDetailCash.fromJson(v));
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

class DataRefDetailCash {
  int? idDetail;
  String? nmDetail;
  String? idCash;
  int? idJenis;
  String? createdAt;
  String? updatedAt;

  DataRefDetailCash(
      {this.idDetail,
      this.nmDetail,
      this.idCash,
      this.idJenis,
      this.createdAt,
      this.updatedAt});

  DataRefDetailCash.fromJson(Map<String, dynamic> json) {
    idDetail = json['id_detail'];
    nmDetail = json['nm_detail'];
    idCash = json['id_cash'];
    idJenis = json['id_jenis'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_detail'] = idDetail;
    data['nm_detail'] = nmDetail;
    data['id_cash'] = idCash;
    data['id_jenis'] = idJenis;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
