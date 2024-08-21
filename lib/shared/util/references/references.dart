import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

PlutoGridLocaleText configLocale = const PlutoGridLocaleText(
  unfreezeColumn: 'Lepas Pin',
  freezeColumnToStart: 'Pin kolom di awal',
  freezeColumnToEnd: 'Pin kolom di akhir',
  autoFitColumn: 'Sesuaikan kolom otomatis',
  hideColumn: 'Sembunyikan kolom',
  setColumns: 'Atur kolom',
  setFilter: 'Atur filter',
  resetFilter: 'Reset filter',
  setColumnsTitle: 'Judul kolom',
  filterColumn: 'Kolom',
  filterType: 'Tipe',
  filterValue: 'Nilai',
  filterAllColumns: 'Semua kolom',
  filterContains: 'Mengandung',
  filterEquals: 'Sama dengan',
  filterStartsWith: 'Dimulai dengan',
  filterEndsWith: 'Diakhiri dengan',
  filterGreaterThan: 'Lebih besar dari',
  filterGreaterThanOrEqualTo: 'Lebih besar atau sama dengan',
  filterLessThan: 'Lebih kecil dari',
  filterLessThanOrEqualTo: 'Lebih kecil atau sama dengan',
  sunday: 'Mg',
  monday: 'Sn',
  tuesday: 'Sl',
  wednesday: 'Rb',
  thursday: 'Km',
  friday: 'Jm',
  saturday: 'Sb',
  hour: 'Jam',
  minute: 'Menit',
  loadingText: 'Memuat',
);

// getNmKelurahan(String kdKelurahan, List<DataKelurahan> dataKelurahan) {
//   String nmKelurahan = "";
//   for (var i = 0; i < dataKelurahan.length; i++) {
//     if (kdKelurahan == trimString(dataKelurahan[i].kdKelurahan)) {
//       nmKelurahan = trimString(dataKelurahan[i].nmKelurahan);
//     }
//   }
//   return nmKelurahan;
// }

getNmCC(String idBbm) {
  String isListrik = "CC";
  if (idBbm == "4" || idBbm == "7") {
    isListrik = "WATT";
  }
  return isListrik;
}

int calcStringNumber(List<dynamic> items) {
  int result = 0;
  for (var item in items) {
    if (item == null || item is num || item is String) {
      result += int.tryParse(item.toString()) ?? 0;
    } else {
      result += 0;
    }
  }
  return result;
}

String mergeKdMohon(
  String kdMohon1,
  String kdMohon2,
  String kdMohon3,
  String kdMohon4,
  String kdMohon5,
  String kdMohon6,
) {
  return kdMohon1 + kdMohon2 + kdMohon3 + kdMohon4 + kdMohon5 + kdMohon6;
}

String setKeyPeriode(String value) {
  String returned = "";
  switch (value) {
    case "Tanggal Bayar":
      returned = "tg_bayar";
      break;
    case "Tanggal Penetapan":
      returned = "tg_tetap";
      break;
    case "Tanggal Cetak TNAB":
      returned = "tg_cetak_tnab";
      break;
    default:
      returned = "";
  }
  return returned;
}

String splitString(String? originalString, bool? isFirstString) {
  if (originalString != null || trimString(originalString).isNotEmpty) {
    RegExp regExp = RegExp(r'^(.*?) - (.*?)$');
    Match? match = regExp.firstMatch(trimString(originalString));

    if (match != null) {
      String firstPart = match.group(1)!.trim();
      String secondPart = match.group(2)!.trim();
      if (isFirstString ?? true == true) {
        return firstPart;
      } else {
        return secondPart;
      }
    } else {
      return "-";
    }
  } else {
    return "-";
  }
}

String? splitNomorAlatBerat(String? originalString, String? noAlatBerat) {
  if (originalString != null || trimString(originalString).isNotEmpty) {
    List splitedString = [];
    splitedString.addAll(trimString(originalString).split("-"));
    if (splitedString.isEmpty) {
      return trimString(originalString);
    } else if (splitedString.length == 1) {
      switch (noAlatBerat) {
        case "1":
          return splitedString[0];
        case "2":
          return null;
        case "3":
          return null;
      }
    } else if (splitedString.length == 2) {
      switch (noAlatBerat) {
        case "1":
          return splitedString[0];
        case "2":
          return splitedString[1];
        case "3":
          return null;
      }
    } else if (splitedString.length == 3) {
      switch (noAlatBerat) {
        case "1":
          return splitedString[0];
        case "2":
          return splitedString[1];
        case "3":
          return splitedString[2];
      }
    } else {
      return "-";
    }
  } else {
    return "-";
  }
  return null;
}

// List<String> setItemPenggunaan() {
//   List<String> itemValue = [];
//   for (var i = 0;
//       i < (ReferencesDatabase.jenisKepemilikanResult.data?.length ?? 0);
//       i++) {
//     itemValue.add(trimString(
//             ReferencesDatabase.jenisKepemilikanResult.data?[i].kdKepemilikan) +
//         " - " +
//         trimString(
//             ReferencesDatabase.jenisKepemilikanResult.data?[i].nmKepemilikan));
//   }
//   return itemValue;
// }

setKodeStatus() {
  var data = Dictionary.kodeStatus;
  List<String> itemValue = [];

  for (var element in data) {
    itemValue.add(element["label"]);
  }
  return itemValue;
}

getKodeStatus(String kdStatus) {
  var data = Dictionary.kodeStatus;
  String kdStatusValue = "";

  for (var element in data) {
    if (element["value"] == kdStatus) {
      kdStatusValue = element["label"];
    }
  }

  return kdStatusValue;
}

getProsesEdit(String prosesEdit) {
  var data = Dictionary.prosesEdit;
  String prosesEditValue = "";

  for (var element in data) {
    if (element["value"] == prosesEdit) {
      prosesEditValue = element["label"];
    }
  }

  return prosesEditValue;
}

// List<String> setItemNamaKodeMohon() {
//   List<String> itemValue = [];
//   for (var i = 0;
//       i < (ReferencesDatabase.kodeMohonResult.data?.length ?? 0);
//       i++) {
//     itemValue.add(
//       "${mergeKdMohon(
//         trimString(ReferencesDatabase.kodeMohonResult.data?[i].kdMohon1),
//         trimString(ReferencesDatabase.kodeMohonResult.data?[i].kdMohon2),
//         trimString(ReferencesDatabase.kodeMohonResult.data?[i].kdMohon3),
//         trimString(ReferencesDatabase.kodeMohonResult.data?[i].kdMohon4),
//         trimString(ReferencesDatabase.kodeMohonResult.data?[i].kdMohon5),
//         trimString(ReferencesDatabase.kodeMohonResult.data?[i].kdMohon6),
//       )} - ${trimString(ReferencesDatabase.kodeMohonResult.data?[i].nmMohon)}",
//     );
//   }
//   return itemValue;
// }

List<String> splitDigits(int number) {
  // Convert the number to a string
  String numberStr = number.toString();

  // Check if the number has exactly 6 digits
  if (numberStr.length != 6) {
    return ["Input must be a 6-digit number"];
  }

  // Split the digits and store them in a list of strings
  List<String> digits = [];
  for (int i = 0; i < numberStr.length; i++) {
    digits.add(numberStr[i]);
  }

  return digits;
}

getNamaMohon(
  String kdMohon1,
  String kdMohon2,
  String kdMohon3,
  String kdMohon4,
  String kdMohon5,
  String kdMohon6,
) {
  var data = Dictionary.namaLayanan;
  String kdMohon = kdMohon1.trim() +
      kdMohon2.trim() +
      kdMohon3.trim() +
      kdMohon4.trim() +
      kdMohon5.trim() +
      kdMohon6.trim();
  String nmMohon = "";

  for (var element in data) {
    if (element["kd_mohon"] == kdMohon) {
      nmMohon =
          "${element["kd_mohon"]} - ${element["nm_mohon"].toString().toUpperCase()}";
    }
  }
  return nmMohon;
}

splitSelangHari(String? valueSelangHari) {
  if (valueSelangHari != null || trimString(valueSelangHari).isNotEmpty) {
    List<String> splitedString = trimString(valueSelangHari).split(" ");
    String? selangTahun = splitedString[0];
    String? selangBulan = splitedString[2];
    String? selangHari = splitedString[4];
    return [selangTahun, selangBulan, selangHari];
  } else {
    return ["0", "0", "0"];
  }
}

getNamaKodeSingkat(String kdMohon1) {
  var data = Dictionary.kodeMohonToKode;
  String kdSingkat = "";

  for (var element in data) {
    if (element["kd_mohon1"] == kdMohon1.trim()) {
      kdSingkat = element["kd_singkat"];
    }
  }
  return kdSingkat;
}

// getNamaKodeKepemilikan(String kdKepemilikan) {
//   var data = ReferencesDatabase.jenisKepemilikanResult.data ?? [];
//   String nmKepemilikan = "";

//   for (var element in data) {
//     if (trimString(element.kdKepemilikan) == trimString(kdKepemilikan)) {
//       nmKepemilikan = trimString(element.nmKepemilikan);
//     }
//   }
//   return nmKepemilikan;
// }

List<String> getPageList(String? maxNumber) {
  List<String> numberList = [];

  if (maxNumber == null) {
    return [];
  } else if (maxNumber == "         ") {
    return [];
  } else if (maxNumber.contains("null")) {
    return [];
  } else {
    int? totalPage = int.tryParse((maxNumber)) ?? 0;
    for (int i = 1; i <= totalPage; i++) {
      numberList.add(i.toString());
    }
    return numberList;
  }
}

String getNamaMetodeBayar(String kdChannelBayar) {
  String nmChannelBayar = "-";

  switch (kdChannelBayar) {
    case "0":
      nmChannelBayar = "Semua";
      break;
    case "1":
      nmChannelBayar = "VA";
      break;
    // case "2":
    //   return "QRIS";
    // case "3":
    //   return "Kode Bayar";
    default:
      nmChannelBayar;
  }

  return nmChannelBayar;
}
