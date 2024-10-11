class IncomeMonthlyResult {
  bool? success;
  DataIncomeMonthly? data;
  String? message;

  IncomeMonthlyResult({this.success, this.data, this.message});

  IncomeMonthlyResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data =
        json['data'] != null ? DataIncomeMonthly.fromJson(json['data']) : null;
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

class DataIncomeMonthly {
  int? totalIncome;
  double? percentageIncome;
  int? totalExpense;
  double? percentageExpense;
  int? totalProfit;
  double? percentageProfit;

  DataIncomeMonthly(
      {this.totalIncome,
      this.percentageIncome,
      this.totalExpense,
      this.percentageExpense,
      this.totalProfit,
      this.percentageProfit});

  DataIncomeMonthly.fromJson(Map<String, dynamic> json) {
    totalIncome = json['total_income'];
    percentageIncome = json['percentage_income'];
    totalExpense = json['total_expense'];
    percentageExpense = json['percentage_expense'];
    totalProfit = json['total_profit'];
    percentageProfit = json['percentage_profit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_income'] = totalIncome;
    data['percentage_income'] = percentageIncome;
    data['total_expense'] = totalExpense;
    data['percentage_expense'] = percentageExpense;
    data['total_profit'] = totalProfit;
    data['percentage_profit'] = percentageProfit;
    return data;
  }
}
