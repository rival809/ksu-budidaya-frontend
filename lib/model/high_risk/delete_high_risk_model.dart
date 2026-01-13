class DeleteHighRiskModel {
  bool? success;
  DataDeleteHighRisk? data;
  String? message;

  DeleteHighRiskModel({this.success, this.data, this.message});

  DeleteHighRiskModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataDeleteHighRisk.fromJson(json['data']) : null;
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

class DataDeleteHighRisk {
  String? message;

  DataDeleteHighRisk({this.message});

  DataDeleteHighRisk.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}
