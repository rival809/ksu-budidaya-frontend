import 'package:ksu_budidaya/core.dart';

class DivisiDatabase {
  static DataDivisi dataDivisi = DataDivisi();

  static load() async {
    dataDivisi = mainStorage.get("dataDivisi") ?? DataDivisi();
  }

  static save(DataDivisi dataDivisi) async {
    mainStorage.put("dataDivisi", dataDivisi);
    DivisiDatabase.dataDivisi = dataDivisi;
  }
}
