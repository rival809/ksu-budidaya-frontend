import 'package:ksu_budidaya/core.dart';

class DetailProductResult {
  bool? success;
  DataDetailProduct? data;
  String? message;

  DetailProductResult({this.success, this.data, this.message});

  DetailProductResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data =
        json['data'] != null ? DataDetailProduct.fromJson(json['data']) : null;
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
