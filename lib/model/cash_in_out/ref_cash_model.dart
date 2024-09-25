class RefCashResult {
  bool? success;
  List<DataRefCash>? data;
  String? message;

  RefCashResult({this.success, this.data, this.message});

  RefCashResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DataRefCash>[];
      json['data'].forEach((v) {
        data!.add(DataRefCash.fromJson(v));
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

class DataRefCash {
  String? idCash;
  String? nmCash;
  String? createdAt;
  String? updatedAt;

  DataRefCash({this.idCash, this.nmCash, this.createdAt, this.updatedAt});

  DataRefCash.fromJson(Map<String, dynamic> json) {
    idCash = json['id_cash'];
    nmCash = json['nm_cash'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_cash'] = idCash;
    data['nm_cash'] = nmCash;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
