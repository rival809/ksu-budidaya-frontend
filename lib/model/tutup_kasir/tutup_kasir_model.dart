import 'package:ksu_budidaya/model/tutup_kasir/list_tutup_kasir_model.dart';

class TutupKasirResult {
  bool? success;
  DetailDataTutupKasir? data;
  String? message;

  TutupKasirResult({this.success, this.data, this.message});

  TutupKasirResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? DetailDataTutupKasir.fromJson(json['data'])
        : null;
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
