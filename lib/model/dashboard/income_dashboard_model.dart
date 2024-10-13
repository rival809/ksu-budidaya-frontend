class IncomeDashboardResult {
  bool? success;
  DataIncomeDashboard? data;
  String? message;

  IncomeDashboardResult({this.success, this.data, this.message});

  IncomeDashboardResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? DataIncomeDashboard.fromJson(json['data'])
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

class DataIncomeDashboard {
  int? totalIncomeToday;
  int? totalIncomeYesterday;
  double? percentage;

  DataIncomeDashboard(
      {this.totalIncomeToday, this.totalIncomeYesterday, this.percentage});

  DataIncomeDashboard.fromJson(Map<String, dynamic> json) {
    totalIncomeToday = json['total_income_today'];
    totalIncomeYesterday = json['total_income_yesterday'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_income_today'] = totalIncomeToday;
    data['total_income_yesterday'] = totalIncomeYesterday;
    data['percentage'] = percentage;
    return data;
  }
}
