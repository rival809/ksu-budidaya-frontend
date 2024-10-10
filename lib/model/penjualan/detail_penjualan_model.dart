import 'package:ksu_budidaya/core.dart';

class DetailPenjualanResult {
  bool? success;
  List<DetailsCreatePenjualan>? details;
  String? message;

  DetailPenjualanResult({this.success, this.details, this.message});

  DetailPenjualanResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      details = <DetailsCreatePenjualan>[];
      json['data'].forEach((v) {
        details!.add(DetailsCreatePenjualan.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (details != null) {
      data['data'] = details!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}
