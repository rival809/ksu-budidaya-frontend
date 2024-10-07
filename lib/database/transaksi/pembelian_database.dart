import 'package:ksu_budidaya/core.dart';

class PembelianDatabase {
  static PembelianResult pembelianResult = PembelianResult();

  static load() async {
    pembelianResult = mainStorage.get("pembelianResult") ?? PembelianResult();
  }

  static save(PembelianResult pembelianResult) async {
    mainStorage.put("pembelianResult", pembelianResult);
    PembelianDatabase.pembelianResult = pembelianResult;
  }
}
