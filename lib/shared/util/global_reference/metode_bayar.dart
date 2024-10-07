import 'package:ksu_budidaya/core.dart';

class MetodeBayar {
  MetodeBayar({
    this.metode,
  });

  String? metode;

  String metodeBayarAsString() {
    return trimString(metode);
  }
}

List<MetodeBayar> metodeBayarList = [
  MetodeBayar(metode: 'tunai'),
  MetodeBayar(metode: 'qris'),
  MetodeBayar(metode: 'kredit'),
];
