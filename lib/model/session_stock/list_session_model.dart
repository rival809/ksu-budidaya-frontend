import 'package:ksu_budidaya/model/session_stock/detail_session_model.dart';

class ListSessionModel {
  bool? success;
  DataLListSession? data;
  String? message;

  ListSessionModel({this.success, this.data, this.message});

  ListSessionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataLListSession.fromJson(json['data']) : null;
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

class DataLListSession {
  List<DataDetailSession>? data;
  Pagination? pagination;

  DataLListSession({this.data, this.pagination});

  DataLListSession.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataDetailSession>[];
      json['data'].forEach((v) {
        data!.add(DataDetailSession.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Pagination {
  int? page;
  int? limit;
  int? total;
  int? totalPages;

  Pagination({this.page, this.limit, this.total, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['total'] = total;
    data['total_pages'] = totalPages;
    return data;
  }
}
