import 'package:ksu_budidaya/core.dart';

class AnggotaDatabase {
  static DataAnggota dataAnggota = DataAnggota();

  static load() async {
    dataAnggota = mainStorage.get("dataAnggota") ?? DataAnggota();
  }

  static save(DataAnggota dataAnggota) async {
    mainStorage.put("dataAnggota", dataAnggota);
    AnggotaDatabase.dataAnggota = dataAnggota;
  }
}
