import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/model/stock_opname/stock_opname_model.dart';

class HistoryStockOpnameModel {
  bool? success;
  DataHistoryStockOpname? data;
  String? message;

  HistoryStockOpnameModel({this.success, this.data, this.message});

  HistoryStockOpnameModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataHistoryStockOpname.fromJson(json['data']) : null;
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

class DataHistoryStockOpname {
  List<DataStockOpname>? dataStock;
  Paging? paging;

  DataHistoryStockOpname({this.dataStock, this.paging});

  DataHistoryStockOpname.fromJson(Map<String, dynamic> json) {
    if (json['data_stock'] != null) {
      dataStock = <DataStockOpname>[];
      json['data_stock'].forEach((v) {
        dataStock!.add(DataStockOpname.fromJson(v));
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
