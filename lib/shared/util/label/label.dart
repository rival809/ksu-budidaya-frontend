import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

getLabelStatusPendaftaran(String kdStatus) {
  switch (kdStatus) {
    case "Y":
      return const CardLabel(
        cardColor: green50,
        cardTitle: "Sudah Daftar",
        cardTitleColor: green900,
        cardBorderColor: green200,
      );
    case "T":
      return const CardLabel(
        cardColor: red50,
        cardTitle: "Belum Daftar",
        cardTitleColor: red900,
        cardBorderColor: red200,
      );
    default:
      return const CardLabel(
        cardColor: red50,
        cardTitle: "Belum Daftar",
        cardTitleColor: red900,
        cardBorderColor: red200,
      );
  }
}

// getLabelKdMohon(String kdMohon) {
//   String dataLabel = "-";

//   if (trimString(kdMohon).isEmpty || kdMohon.contains("null")) {
//     return const Text("-");
//   }
//   for (var i = 0;
//       i < (ReferencesDatabase.kodeMohonResult.data?.length ?? 0);
//       i++) {
//     String dataKdMohon = mergeKdMohon(
//       trimString(ReferencesDatabase.kodeMohonResult.data?[i].kdMohon1),
//       trimString(ReferencesDatabase.kodeMohonResult.data?[i].kdMohon2),
//       trimString(ReferencesDatabase.kodeMohonResult.data?[i].kdMohon3),
//       trimString(ReferencesDatabase.kodeMohonResult.data?[i].kdMohon4),
//       trimString(ReferencesDatabase.kodeMohonResult.data?[i].kdMohon5),
//       trimString(ReferencesDatabase.kodeMohonResult.data?[i].kdMohon6),
//     );
//     if (dataKdMohon == kdMohon) {
//       dataLabel =
//           trimStringStrip(ReferencesDatabase.kodeMohonResult.data?[i].nmMohon);
//       return CardLabelMohon(cardTitle: dataLabel);
//     }
//   }

//   return CardLabelMohon(
//     cardTitle: dataLabel,
//   );
// }

getLabelKdStatus(String kdStatus) {
  switch (kdStatus) {
    case "1":
      return const CardLabel(
        cardColor: yellow50,
        cardTitle: "Belum dikoreksi",
        cardTitleColor: yellow900,
        cardBorderColor: yellow200,
      );
    case "2":
      return const CardLabel(
        cardColor: green50,
        cardTitle: "Sudah dikoreksi",
        cardTitleColor: green900,
        cardBorderColor: green200,
      );

    default:
      return Container();
  }
}

getLabelProgramStatus(String programStatus) {
  if (programStatus == "7" || programStatus == "8" || programStatus == "9") {
    return true;
  } else {
    return false;
  }
}

getLabelStatus(String kdBlockir) {
  switch (kdBlockir) {
    case "0":
      return const CardLabel(
        cardColor: green50,
        cardTitle: "Terdaftar",
        cardTitleColor: green700,
        cardBorderColor: green100,
      );
    case "2":
      return const CardLabel(
        cardColor: blue50,
        cardTitle: "Minta Buka Proteksi",
        cardTitleColor: blue700,
        cardBorderColor: blue100,
      );
    case "3":
      return const CardLabel(
        cardColor: yellow50,
        cardTitle: "Minta Proteksi",
        cardTitleColor: yellow700,
        cardBorderColor: yellow100,
      );
    default:
      return const CardLabel(
        cardColor: red50,
        cardTitle: "Terproteksi",
        cardTitleColor: red700,
        cardBorderColor: red100,
      );
  }
}
