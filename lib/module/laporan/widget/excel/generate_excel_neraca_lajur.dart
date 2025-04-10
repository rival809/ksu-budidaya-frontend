import 'package:ksu_budidaya/core.dart';
import 'package:excel/excel.dart' as xls;

doGenerateExcelNeracaLajur({required LaporanController controller}) async {
  var excel = xls.Excel.createExcel();
  xls.Sheet sheetObject = excel['Sheet1'];

  buildHeader(sheetObject: sheetObject, controller: controller);

  sheetObject.setColumnWidth(0, 5);
  sheetObject.setColumnWidth(1, 40);

  int index = 4;

  controller.resultNeracaLajur.data?.dataNeraca?.forEach((key, value) {
    build1Row(
      sheetObject: sheetObject,
      index: index,
      no: index - 3,
      uraian: key,
      neracaAwalD: value?.neracaAwal?.debit?.toInt() ?? 0,
      neracaAwalK: value?.neracaAwal?.kredit?.toInt() ?? 0,
      neracaMutasiD: value?.neracaMutasi?.debit?.toInt() ?? 0,
      neracaMutasiK: value?.neracaMutasi?.kredit?.toInt() ?? 0,
      neracaPercobaanD: value?.neracaPercobaan?.debit?.toInt() ?? 0,
      neracaPercobaanK: value?.neracaPercobaan?.kredit?.toInt() ?? 0,
      neracaSaldoD: value?.neracaSaldo?.debit?.toInt() ?? 0,
      neracaSaldoK: value?.neracaSaldo?.kredit?.toInt() ?? 0,
      neracaHasilUsahaD: value?.hasilUsaha?.debit?.toInt() ?? 0,
      neracaHasilUsahaK: value?.hasilUsaha?.kredit?.toInt() ?? 0,
      neracaAkhirD: value?.neracaAkhir?.debit?.toInt() ?? 0,
      neracaAkhirK: value?.neracaAkhir?.kredit?.toInt() ?? 0,
    );
    index++;
  });

  build1Row(
    sheetObject: sheetObject,
    index: index,
    no: index - 3,
    uraian: "TOTAL",
    neracaAwalD:
        controller.resultNeracaLajur.data?.totalNeraca?.totalNeracaAwal?.debit?.toInt() ?? 0,
    neracaAwalK:
        controller.resultNeracaLajur.data?.totalNeraca?.totalNeracaAwal?.kredit?.toInt() ?? 0,
    neracaMutasiD:
        controller.resultNeracaLajur.data?.totalNeraca?.totalNeracaMutasi?.debit?.toInt() ?? 0,
    neracaMutasiK:
        controller.resultNeracaLajur.data?.totalNeraca?.totalNeracaMutasi?.kredit?.toInt() ?? 0,
    neracaPercobaanD:
        controller.resultNeracaLajur.data?.totalNeraca?.totalNeracaPercobaan?.debit?.toInt() ?? 0,
    neracaPercobaanK:
        controller.resultNeracaLajur.data?.totalNeraca?.totalNeracaPercobaan?.kredit?.toInt() ?? 0,
    neracaSaldoD:
        controller.resultNeracaLajur.data?.totalNeraca?.totalNeracaSaldo?.debit?.toInt() ?? 0,
    neracaSaldoK:
        controller.resultNeracaLajur.data?.totalNeraca?.totalNeracaSaldo?.kredit?.toInt() ?? 0,
    neracaHasilUsahaD:
        controller.resultNeracaLajur.data?.totalNeraca?.totalHasilUsaha?.debit?.toInt() ?? 0,
    neracaHasilUsahaK:
        controller.resultNeracaLajur.data?.totalNeraca?.totalHasilUsaha?.kredit?.toInt() ?? 0,
    neracaAkhirD:
        controller.resultNeracaLajur.data?.totalNeraca?.totalNeracaAkhir?.debit?.toInt() ?? 0,
    neracaAkhirK:
        controller.resultNeracaLajur.data?.totalNeraca?.totalNeracaAkhir?.kredit?.toInt() ?? 0,
  );

  excel.save(fileName: 'Neraca Lajur.xlsx');
}

buildHeader({required xls.Sheet sheetObject, required LaporanController controller}) {
  sheetObject.merge(
    xls.CellIndex.indexByString("A1"),
    xls.CellIndex.indexByString("N1"),
    customValue: xls.TextCellValue(
      "LAPORAN NERACA LAJUR \n\n ${getNamaMonth(controller.monthNow).toUpperCase()} - ${controller.yearNow}",
    ),
  );
  var header = sheetObject.setMergedCellStyle(
    xls.CellIndex.indexByString("A1"),
    xls.CellStyle(
      bold: true,
      textWrapping: xls.TextWrapping.WrapText,
      horizontalAlign: xls.HorizontalAlign.Center,
      verticalAlign: xls.VerticalAlign.Center,
      rightBorder: xls.Border(
        borderStyle: xls.getBorderStyleByName("thin"),
        borderColorHex: xls.ExcelColor.black,
      ),
      leftBorder: xls.Border(
        borderStyle: xls.getBorderStyleByName("thin"),
        borderColorHex: xls.ExcelColor.black,
      ),
      topBorder: xls.Border(
        borderStyle: xls.getBorderStyleByName("thin"),
        borderColorHex: xls.ExcelColor.black,
      ),
      bottomBorder: xls.Border(
        borderStyle: xls.getBorderStyleByName("thin"),
        borderColorHex: xls.ExcelColor.black,
      ),
    ),
  );

  sheetObject.setRowHeight(0, 75);

  List<Map<String, dynamic>> headers = [
    {"range": "A2:A3", "value": "NO."},
    {"range": "B2:B3", "value": "URAIAN"},
    {
      "range": "C2:D2",
      "value": "NERACA AWAL",
      "subHeaders": ["C3:D", "D3:K"]
    },
    {
      "range": "E2:F2",
      "value": "NERACA MUTASI",
      "subHeaders": ["E3:D", "F3:K"]
    },
    {
      "range": "G2:H2",
      "value": "NERACA PERCOBAAN",
      "subHeaders": ["G3:D", "H3:K"]
    },
    {
      "range": "I2:J2",
      "value": "NERACA SALDO",
      "subHeaders": ["I3:D", "J3:K"]
    },
    {
      "range": "K2:L2",
      "value": "HASIL USAHA",
      "subHeaders": ["K3:D", "L3:K"]
    },
    {
      "range": "M2:N2",
      "value": "NERACA AKHIR",
      "subHeaders": ["M3:D", "N3:K"]
    },
  ];

  for (var header in headers) {
    sheetObject.merge(
      xls.CellIndex.indexByString(header["range"]!.split(":")[0]),
      xls.CellIndex.indexByString(header["range"]!.split(":")[1]),
      customValue: xls.TextCellValue(header["value"]!),
    );
    sheetObject.setMergedCellStyle(
      xls.CellIndex.indexByString(header["range"]!.split(":")[0]),
      xls.CellStyle(
        bold: true,
        textWrapping: xls.TextWrapping.WrapText,
        horizontalAlign: xls.HorizontalAlign.Center,
        verticalAlign: xls.VerticalAlign.Center,
        rightBorder: xls.Border(
          borderStyle: xls.getBorderStyleByName("thin"),
          borderColorHex: xls.ExcelColor.black,
        ),
        leftBorder: xls.Border(
          borderStyle: xls.getBorderStyleByName("thin"),
          borderColorHex: xls.ExcelColor.black,
        ),
        topBorder: xls.Border(
          borderStyle: xls.getBorderStyleByName("thin"),
          borderColorHex: xls.ExcelColor.black,
        ),
        bottomBorder: xls.Border(
          borderStyle: xls.getBorderStyleByName("thin"),
          borderColorHex: xls.ExcelColor.black,
        ),
      ),
    );

    if (header.containsKey("subHeaders")) {
      for (var subHeader in header["subHeaders"]!) {
        final parts = subHeader.split(":");
        sheetObject.cell(xls.CellIndex.indexByString(parts[0])).value = xls.TextCellValue(parts[1]);
        sheetObject.cell(xls.CellIndex.indexByString(parts[0])).cellStyle = xls.CellStyle(
          bold: true,
          textWrapping: xls.TextWrapping.WrapText,
          horizontalAlign: xls.HorizontalAlign.Center,
          verticalAlign: xls.VerticalAlign.Center,
          rightBorder: xls.Border(
            borderStyle: xls.getBorderStyleByName("thin"),
            borderColorHex: xls.ExcelColor.black,
          ),
          leftBorder: xls.Border(
            borderStyle: xls.getBorderStyleByName("thin"),
            borderColorHex: xls.ExcelColor.black,
          ),
          topBorder: xls.Border(
            borderStyle: xls.getBorderStyleByName("thin"),
            borderColorHex: xls.ExcelColor.black,
          ),
          bottomBorder: xls.Border(
            borderStyle: xls.getBorderStyleByName("thin"),
            borderColorHex: xls.ExcelColor.black,
          ),
        );
      }
    }
  }
}

build1Row({
  required xls.Sheet sheetObject,
  required int index,
  required int no,
  required String uraian,
  required int neracaAwalD,
  required int neracaAwalK,
  required int neracaMutasiD,
  required int neracaMutasiK,
  required int neracaPercobaanD,
  required int neracaPercobaanK,
  required int neracaSaldoD,
  required int neracaSaldoK,
  required int neracaHasilUsahaD,
  required int neracaHasilUsahaK,
  required int neracaAkhirD,
  required int neracaAkhirK,
}) {
  var textStyle = xls.CellStyle(
    textWrapping: xls.TextWrapping.WrapText,
    horizontalAlign: xls.HorizontalAlign.Left,
    verticalAlign: xls.VerticalAlign.Center,
    rightBorder: xls.Border(
      borderStyle: xls.getBorderStyleByName("thin"),
      borderColorHex: xls.ExcelColor.black,
    ),
    leftBorder: xls.Border(
      borderStyle: xls.getBorderStyleByName("thin"),
      borderColorHex: xls.ExcelColor.black,
    ),
    topBorder: xls.Border(
      borderStyle: xls.getBorderStyleByName("thin"),
      borderColorHex: xls.ExcelColor.black,
    ),
    bottomBorder: xls.Border(
      borderStyle: xls.getBorderStyleByName("thin"),
      borderColorHex: xls.ExcelColor.black,
    ),
  );
  sheetObject.cell(xls.CellIndex.indexByString("A$index"))
    ..value = xls.IntCellValue(no)
    ..cellStyle = textStyle;
  sheetObject.cell(xls.CellIndex.indexByString("B$index"))
    ..value = xls.TextCellValue(uraian.toUpperCase().replaceAll("_", " "))
    ..cellStyle = textStyle;

  var numberFormat = xls.CellStyle(
    numberFormat: xls.NumFormat.standard_3,
    textWrapping: xls.TextWrapping.WrapText,
    horizontalAlign: xls.HorizontalAlign.Right,
    verticalAlign: xls.VerticalAlign.Center,
    rightBorder: xls.Border(
      borderStyle: xls.getBorderStyleByName("thin"),
      borderColorHex: xls.ExcelColor.black,
    ),
    leftBorder: xls.Border(
      borderStyle: xls.getBorderStyleByName("thin"),
      borderColorHex: xls.ExcelColor.black,
    ),
    topBorder: xls.Border(
      borderStyle: xls.getBorderStyleByName("thin"),
      borderColorHex: xls.ExcelColor.black,
    ),
    bottomBorder: xls.Border(
      borderStyle: xls.getBorderStyleByName("thin"),
      borderColorHex: xls.ExcelColor.black,
    ),
  );

  sheetObject.cell(xls.CellIndex.indexByString("C$index"))
    ..value = xls.IntCellValue(neracaAwalD)
    ..cellStyle = numberFormat;
  sheetObject.cell(xls.CellIndex.indexByString("D$index"))
    ..value = xls.IntCellValue(neracaAwalK)
    ..cellStyle = numberFormat;
  sheetObject.cell(xls.CellIndex.indexByString("E$index"))
    ..value = xls.IntCellValue(neracaMutasiD)
    ..cellStyle = numberFormat;
  sheetObject.cell(xls.CellIndex.indexByString("F$index"))
    ..value = xls.IntCellValue(neracaMutasiK)
    ..cellStyle = numberFormat;
  sheetObject.cell(xls.CellIndex.indexByString("G$index"))
    ..value = xls.IntCellValue(neracaPercobaanD)
    ..cellStyle = numberFormat;
  sheetObject.cell(xls.CellIndex.indexByString("H$index"))
    ..value = xls.IntCellValue(neracaPercobaanK)
    ..cellStyle = numberFormat;
  sheetObject.cell(xls.CellIndex.indexByString("I$index"))
    ..value = xls.IntCellValue(neracaSaldoD)
    ..cellStyle = numberFormat;
  sheetObject.cell(xls.CellIndex.indexByString("J$index"))
    ..value = xls.IntCellValue(neracaSaldoK)
    ..cellStyle = numberFormat;
  sheetObject.cell(xls.CellIndex.indexByString("K$index"))
    ..value = xls.IntCellValue(neracaHasilUsahaD)
    ..cellStyle = numberFormat;
  sheetObject.cell(xls.CellIndex.indexByString("L$index"))
    ..value = xls.IntCellValue(neracaHasilUsahaK)
    ..cellStyle = numberFormat;
  sheetObject.cell(xls.CellIndex.indexByString("M$index"))
    ..value = xls.IntCellValue(neracaAkhirD)
    ..cellStyle = numberFormat;
  sheetObject.cell(xls.CellIndex.indexByString("N$index"))
    ..value = xls.IntCellValue(neracaAkhirK)
    ..cellStyle = numberFormat;
}
