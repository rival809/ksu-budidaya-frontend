import 'package:ksu_budidaya/core.dart';

class RefCashDatabase {
  static RefCashResult refCashResult = RefCashResult();

  static load() async {
    refCashResult = mainStorage.get("refCashResult") ?? RefCashResult();
  }

  static save(RefCashResult refCashResult) async {
    mainStorage.put("refCashResult", refCashResult);
    RefCashDatabase.refCashResult = refCashResult;
  }
}
