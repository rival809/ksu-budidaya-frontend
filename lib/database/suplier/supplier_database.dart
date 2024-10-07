import 'package:ksu_budidaya/core.dart';

class SupplierDatabase {
  static DataSupplier dataSupplier = DataSupplier();

  static load() async {
    dataSupplier = mainStorage.get("dataSupplier") ?? DataSupplier();
  }

  static save(DataSupplier dataSupplier) async {
    mainStorage.put("dataSupplier", dataSupplier);
    SupplierDatabase.dataSupplier = dataSupplier;
  }
}
