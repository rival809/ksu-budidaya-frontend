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
      neracaAwalD: value?.neracaAwal?.debit ?? 0,
      neracaAwalK: value?.neracaAwal?.kredit ?? 0,
      neracaMutasiD: value?.neracaMutasi?.debit ?? 0,
      neracaMutasiK: value?.neracaMutasi?.kredit ?? 0,
      neracaPercobaanD: value?.neracaPercobaan?.debit ?? 0,
      neracaPercobaanK: value?.neracaPercobaan?.kredit ?? 0,
      neracaSaldoD: value?.neracaSaldo?.debit ?? 0,
      neracaSaldoK: value?.neracaSaldo?.kredit ?? 0,
      neracaHasilUsahaD: value?.hasilUsaha?.debit ?? 0,
      neracaHasilUsahaK: value?.hasilUsaha?.kredit ?? 0,
      neracaAkhirD: value?.neracaAkhir?.debit ?? 0,
      neracaAkhirK: value?.neracaAkhir?.kredit ?? 0,
    );
    index++;
  });

  build1Row(
    sheetObject: sheetObject,
    index: index,
    no: index - 3,
    uraian: "TOTAL",
    neracaAwalD: controller.resultNeracaLajur.data?.totalNeraca?.totalNeracaAwal?.debit ?? 0,
    neracaAwalK: controller.resultNeracaLajur.data?.totalNeraca?.totalNeracaAwal?.kredit ?? 0,
    neracaMutasiD: controller.resultNeracaLajur.data?.totalNeraca?.totalNeracaMutasi?.debit ?? 0,
    neracaMutasiK: controller.resultNeracaLajur.data?.totalNeraca?.totalNeracaMutasi?.kredit ?? 0,
    neracaPercobaanD:
        controller.resultNeracaLajur.data?.totalNeraca?.totalNeracaPercobaan?.debit ?? 0,
    neracaPercobaanK:
        controller.resultNeracaLajur.data?.totalNeraca?.totalNeracaPercobaan?.kredit ?? 0,
    neracaSaldoD: controller.resultNeracaLajur.data?.totalNeraca?.totalNeracaSaldo?.debit ?? 0,
    neracaSaldoK: controller.resultNeracaLajur.data?.totalNeraca?.totalNeracaSaldo?.kredit ?? 0,
    neracaHasilUsahaD: controller.resultNeracaLajur.data?.totalNeraca?.totalHasilUsaha?.debit ?? 0,
    neracaHasilUsahaK: controller.resultNeracaLajur.data?.totalNeraca?.totalHasilUsaha?.kredit ?? 0,
    neracaAkhirD: controller.resultNeracaLajur.data?.totalNeraca?.totalNeracaAkhir?.debit ?? 0,
    neracaAkhirK: controller.resultNeracaLajur.data?.totalNeraca?.totalNeracaAkhir?.kredit ?? 0,
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
  required double neracaAwalD,
  required double neracaAwalK,
  required double neracaMutasiD,
  required double neracaMutasiK,
  required double neracaPercobaanD,
  required double neracaPercobaanK,
  required double neracaSaldoD,
  required double neracaSaldoK,
  required double neracaHasilUsahaD,
  required double neracaHasilUsahaK,
  required double neracaAkhirD,
  required double neracaAkhirK,
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
    numberFormat: xls.NumFormat.standard_4,
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
    ..value = xls.DoubleCellValue(neracaAwalD)
    ..cellStyle = numberFormat;
  sheetObject.cell(xls.CellIndex.indexByString("D$index"))
    ..value = xls.DoubleCellValue(neracaAwalK)
    ..cellStyle = numberFormat;
  sheetObject.cell(xls.CellIndex.indexByString("E$index"))
    ..value = xls.DoubleCellValue(neracaMutasiD)
    ..cellStyle = numberFormat;
  sheetObject.cell(xls.CellIndex.indexByString("F$index"))
    ..value = xls.DoubleCellValue(neracaMutasiK)
    ..cellStyle = numberFormat;
  sheetObject.cell(xls.CellIndex.indexByString("G$index"))
    ..value = xls.DoubleCellValue(neracaPercobaanD)
    ..cellStyle = numberFormat;
  sheetObject.cell(xls.CellIndex.indexByString("H$index"))
    ..value = xls.DoubleCellValue(neracaPercobaanK)
    ..cellStyle = numberFormat;
  sheetObject.cell(xls.CellIndex.indexByString("I$index"))
    ..value = xls.DoubleCellValue(neracaSaldoD)
    ..cellStyle = numberFormat;
  sheetObject.cell(xls.CellIndex.indexByString("J$index"))
    ..value = xls.DoubleCellValue(neracaSaldoK)
    ..cellStyle = numberFormat;
  sheetObject.cell(xls.CellIndex.indexByString("K$index"))
    ..value = xls.DoubleCellValue(neracaHasilUsahaD)
    ..cellStyle = numberFormat;
  sheetObject.cell(xls.CellIndex.indexByString("L$index"))
    ..value = xls.DoubleCellValue(neracaHasilUsahaK)
    ..cellStyle = numberFormat;
  sheetObject.cell(xls.CellIndex.indexByString("M$index"))
    ..value = xls.DoubleCellValue(neracaAkhirD)
    ..cellStyle = numberFormat;
  sheetObject.cell(xls.CellIndex.indexByString("N$index"))
    ..value = xls.DoubleCellValue(neracaAkhirK)
    ..cellStyle = numberFormat;
}
