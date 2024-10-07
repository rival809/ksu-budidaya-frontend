import 'package:ksu_budidaya/core.dart';
part 'divisi_model.g.dart';

class DivisiResult {
  bool? success;
  DataDivisi? data;
  String? message;

  DivisiResult({this.success, this.data, this.message});

  DivisiResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataDivisi.fromJson(json['data']) : null;
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

@HiveType(typeId: 9)
class DataDivisi {
  @HiveField(0)
  List<DataDetailDivisi>? dataDivisi;
  Paging? paging;

  DataDivisi({this.dataDivisi, this.paging});

  DataDivisi.fromJson(Map<String, dynamic> json) {
    if (json['data_divisi'] != null) {
      dataDivisi = <DataDetailDivisi>[];
      json['data_divisi'].forEach((v) {
        dataDivisi!.add(DataDetailDivisi.fromJson(v));
      });
    }
    paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dataDivisi != null) {
      data['data_divisi'] = dataDivisi!.map((v) => v.toJson()).toList();
    }
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 10)
class DataDetailDivisi {
  @HiveField(0)
  String? idDivisi;
  @HiveField(1)
  String? nmDivisi;
  @HiveField(2)
  String? createdAt;
  @HiveField(3)
  String? updatedAt;

  DataDetailDivisi(
      {this.idDivisi, this.nmDivisi, this.createdAt, this.updatedAt});

  DataDetailDivisi.fromJson(Map<String, dynamic> json) {
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

  String divisiAsString() {
    return '${trimString(idDivisi)} - ${trimString(nmDivisi)}';
  }

  DataDetailDivisi copyWith({
    String? idDivisi,
    String? nmDivisi,
    String? createdAt,
    String? updatedAt,
  }) =>
      DataDetailDivisi(
        idDivisi: idDivisi ?? this.idDivisi,
        nmDivisi: nmDivisi ?? this.nmDivisi,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
