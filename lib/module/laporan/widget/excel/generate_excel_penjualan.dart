import 'package:ksu_budidaya/core.dart';
import 'package:excel/excel.dart' as xls;

doGenerateExcelPenjualan({required LaporanController controller}) async {
  var excel = xls.Excel.createExcel();
  xls.Sheet sheetObject = excel['Sheet1'];

  buildHeaderPenjualan(sheetObject: sheetObject, controller: controller);

  // Set column widths
  sheetObject.setColumnWidth(0, 5); // No
  sheetObject.setColumnWidth(1, 40); // Produk
  sheetObject.setColumnWidth(2, 20); // Metode Pembayaran
  sheetObject.setColumnWidth(3, 15); // Jumlah
  sheetObject.setColumnWidth(4, 18); // Modal
  sheetObject.setColumnWidth(5, 18); // Hasil Penjualan
  sheetObject.setColumnWidth(6, 18); // Keuntungan
  sheetObject.setColumnWidth(7, 12); // Persentase

  int index = 5; // Start from row 5 (after headers)

  // Calculate totals
  double totalJumlah = 0;
  double totalModal = 0;
  double totalHasilPenjualan = 0;
  double totalKeuntungan = 0;

  // Add data rows
  if (controller.resultPenjualan.data?.data != null) {
    for (var item in controller.resultPenjualan.data!.data!) {
      totalJumlah += item.jumlah ?? 0;
      totalModal += item.modal ?? 0;
      totalHasilPenjualan += item.hasilPenjualan ?? 0;
      totalKeuntungan += item.keuntungan ?? 0;

      buildPenjualanRow(
        sheetObject: sheetObject,
        index: index,
        no: index - 4,
        produk: item.produk ?? '',
        metodePembayaran: item.metodePembayaran ?? '',
        jumlah: item.jumlah ?? 0,
        modal: item.modal ?? 0,
        hasilPenjualan: item.hasilPenjualan ?? 0,
        keuntungan: item.keuntungan ?? 0,
        persentase: item.persentase ?? 0,
      );
      index++;
    }
  }

  double totalPersentase = totalModal > 0 ? (totalKeuntungan / totalModal) * 100 : 0;

  // Add total row
  // buildPenjualanRow(
  //   sheetObject: sheetObject,
  //   index: index,
  //   no: null,
  //   produk: "TOTAL",
  //   metodePembayaran: "",
  //   jumlah: totalJumlah,
  //   modal: totalModal,
  //   hasilPenjualan: totalHasilPenjualan,
  //   keuntungan: totalKeuntungan,
  //   persentase: totalPersentase,
  //   isTotal: true,
  // );

  // Format dates for filename
  String formatDate(DateTime date) =>
      "${date.day.toString().padLeft(2, '0')}_${date.month.toString().padLeft(2, '0')}_${date.year}";

  String startDate = controller.dates[0] != null
      ? formatDate(controller.dates[0]!)
      : formatDate(DateTime(controller.yearNow, controller.monthNow, 1));
  String endDate = controller.dates[1] != null
      ? formatDate(controller.dates[1]!)
      : formatDate(DateTime(controller.yearNow, controller.monthNow, 1));

  excel.save(fileName: 'Laporan_Penjualan_${startDate}_$endDate.xlsx');
}

buildHeaderPenjualan({required xls.Sheet sheetObject, required LaporanController controller}) {
  // Format dates for display
  String formatDate(DateTime date) =>
      "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";

  String startDate = controller.dates[0] != null
      ? formatDate(controller.dates[0]!)
      : formatDate(DateTime(controller.yearNow, controller.monthNow, 1));
  String endDate = controller.dates[1] != null
      ? formatDate(controller.dates[1]!)
      : formatDate(DateTime(controller.yearNow, controller.monthNow, 1));

  String metodePembayaran = controller.selectedMetodePembayaran == "SEMUA"
      ? "SEMUA METODE PEMBAYARAN"
      : controller.selectedMetodePembayaran;

  // Main title
  sheetObject.merge(
    xls.CellIndex.indexByString("A1"),
    xls.CellIndex.indexByString("H1"),
    customValue: xls.TextCellValue("LAPORAN PENJUALAN"),
  );
  sheetObject.setMergedCellStyle(
    xls.CellIndex.indexByString("A1"),
    xls.CellStyle(
      bold: true,
      fontSize: 16,
      horizontalAlign: xls.HorizontalAlign.Center,
      verticalAlign: xls.VerticalAlign.Center,
    ),
  );

  // Period
  sheetObject.merge(
    xls.CellIndex.indexByString("A2"),
    xls.CellIndex.indexByString("H2"),
    customValue: xls.TextCellValue("Periode: $startDate s/d $endDate"),
  );
  sheetObject.setMergedCellStyle(
    xls.CellIndex.indexByString("A2"),
    xls.CellStyle(
      bold: true,
      fontSize: 12,
      horizontalAlign: xls.HorizontalAlign.Center,
      verticalAlign: xls.VerticalAlign.Center,
    ),
  );

  // Payment method
  sheetObject.merge(
    xls.CellIndex.indexByString("A3"),
    xls.CellIndex.indexByString("H3"),
    customValue: xls.TextCellValue("Metode Pembayaran: $metodePembayaran"),
  );
  sheetObject.setMergedCellStyle(
    xls.CellIndex.indexByString("A3"),
    xls.CellStyle(
      fontSize: 10,
      horizontalAlign: xls.HorizontalAlign.Center,
      verticalAlign: xls.VerticalAlign.Center,
    ),
  );

  sheetObject.setRowHeight(0, 25);
  sheetObject.setRowHeight(1, 20);
  sheetObject.setRowHeight(2, 20);

  // Column headers
  List<String> headers = [
    "NO.",
    "PRODUK",
    "METODE PEMBAYARAN",
    "JUMLAH",
    "MODAL",
    "HASIL PENJUALAN",
    "KEUNTUNGAN",
    "%"
  ];

  for (int i = 0; i < headers.length; i++) {
    String cellAddress = "${String.fromCharCode(65 + i)}4"; // A4, B4, C4, etc.
    sheetObject.cell(xls.CellIndex.indexByString(cellAddress)).value =
        xls.TextCellValue(headers[i]);
    sheetObject.cell(xls.CellIndex.indexByString(cellAddress)).cellStyle = xls.CellStyle(
      bold: true,
      backgroundColorHex: xls.ExcelColor.fromHexString("#017260"),
      fontColorHex: xls.ExcelColor.white,
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

  sheetObject.setRowHeight(3, 30);
}

buildPenjualanRow({
  required xls.Sheet sheetObject,
  required int index,
  int? no,
  required String produk,
  required String metodePembayaran,
  required double jumlah,
  required double modal,
  required double hasilPenjualan,
  required double keuntungan,
  required double persentase,
  bool isTotal = false,
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
    bold: isTotal,
    backgroundColorHex: isTotal ? xls.ExcelColor.fromHexString("#F0F0F0") : xls.ExcelColor.white,
  );

  var numberStyle = xls.CellStyle(
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
    bold: isTotal,
    backgroundColorHex: isTotal ? xls.ExcelColor.fromHexString("#F0F0F0") : xls.ExcelColor.white,
  );

  var centerStyle = xls.CellStyle(
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
    bold: isTotal,
    backgroundColorHex: isTotal ? xls.ExcelColor.fromHexString("#F0F0F0") : xls.ExcelColor.white,
  );

  // No
  if (no != null) {
    sheetObject.cell(xls.CellIndex.indexByString("A$index"))
      ..value = xls.IntCellValue(no)
      ..cellStyle = centerStyle;
  } else {
    sheetObject.cell(xls.CellIndex.indexByString("A$index"))
      ..value = xls.TextCellValue("")
      ..cellStyle = centerStyle;
  }

  // Produk
  sheetObject.cell(xls.CellIndex.indexByString("B$index"))
    ..value = xls.TextCellValue(produk.toUpperCase())
    ..cellStyle = textStyle;

  // Metode Pembayaran
  sheetObject.cell(xls.CellIndex.indexByString("C$index"))
    ..value = xls.TextCellValue(metodePembayaran)
    ..cellStyle = centerStyle;

  // Jumlah
  sheetObject.cell(xls.CellIndex.indexByString("D$index"))
    ..value = xls.DoubleCellValue(jumlah)
    ..cellStyle = numberStyle;

  // Modal
  sheetObject.cell(xls.CellIndex.indexByString("E$index"))
    ..value = xls.DoubleCellValue(modal)
    ..cellStyle = numberStyle;

  // Hasil Penjualan
  sheetObject.cell(xls.CellIndex.indexByString("F$index"))
    ..value = xls.DoubleCellValue(hasilPenjualan)
    ..cellStyle = numberStyle;

  // Keuntungan
  sheetObject.cell(xls.CellIndex.indexByString("G$index"))
    ..value = xls.DoubleCellValue(keuntungan)
    ..cellStyle = numberStyle;

  // Persentase
  sheetObject.cell(xls.CellIndex.indexByString("H$index"))
    ..value = xls.TextCellValue("${persentase.toStringAsFixed(1)}%")
    ..cellStyle = centerStyle;
}
