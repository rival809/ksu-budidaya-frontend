class Month {
  final int id;
  final String month;

  Month({required this.id, required this.month});

  factory Month.fromJson(Map<String, dynamic> json) {
    return Month(
      id: json['id'],
      month: json['month'],
    );
  }

  String monthAsString() {
    return month;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'month': month,
    };
  }
}

class Year {
  final List<Month> months;

  Year({required this.months});

  factory Year.fromJson(List<dynamic> json) {
    return Year(
      months: json.map((e) => Month.fromJson(e)).toList(),
    );
  }

  List<Map<String, dynamic>> toJson() {
    return months.map((e) => e.toJson()).toList();
  }
}

List<Map<String, dynamic>> monthData = [
  {"id": 1, "month": "Januari"},
  {"id": 2, "month": "Februari"},
  {"id": 3, "month": "Maret"},
  {"id": 4, "month": "April"},
  {"id": 5, "month": "Mei"},
  {"id": 6, "month": "Juni"},
  {"id": 7, "month": "Juli"},
  {"id": 8, "month": "Agustus"},
  {"id": 9, "month": "September"},
  {"id": 10, "month": "Oktober"},
  {"id": 11, "month": "November"},
  {"id": 12, "month": "Desember"}
];
