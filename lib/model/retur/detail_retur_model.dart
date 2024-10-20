import 'package:ksu_budidaya/core.dart';

class DetailReturResult {
  bool? success;
  List<DetailsReturPayload>? data;
  String? message;

  DetailReturResult({this.success, this.data, this.message});

  DetailReturResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DetailsReturPayload>[];
      json['data'].forEach((v) {
        data!.add(DetailsReturPayload.fromJson(v));
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
