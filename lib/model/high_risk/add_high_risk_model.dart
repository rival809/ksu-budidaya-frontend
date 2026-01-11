import 'package:ksu_budidaya/model/high_risk/list_high_risk_model.dart';

class AddHighRiskModel {
  bool? success;
  DataListHighRisk? data;
  String? message;

  AddHighRiskModel({this.success, this.data, this.message});

  AddHighRiskModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataListHighRisk.fromJson(json['data']) : null;
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
