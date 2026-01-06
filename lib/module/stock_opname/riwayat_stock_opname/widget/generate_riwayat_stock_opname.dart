import 'package:flutter/services.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/model/stock_opname/stock_opname_model.dart';
import 'package:ksu_budidaya/module/stock_opname/riwayat_stock_opname/controller/riwayat_stock_opname_controller.dart';
import 'package:pdf/widgets.dart' as pw;

generatePdfRiwayatStockOpname({
  required RiwayatStockOpnameController controller,
}) async {
  showCircleDialogLoading();
  await Future.delayed(const Duration(seconds: 1));
  try {
    final ttfRegular = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");
    final regularFont = pw.Font.ttf(ttfRegular);
    final ttfBold = await rootBundle.load("assets/fonts/Roboto-Bold.ttf");
    final boldFont = pw.Font.ttf(ttfBold);
    List<PdfRiwayatStockOpname> listDataRiwayat = [];

    for (var i = 0; i < (controller.dataStockOpname.dataStock?.length ?? 0); i++) {
      DataStockOpname dataRekap = controller.dataStockOpname.dataStock?[i] ?? DataStockOpname();
      int noUrut = i + 1;

      listDataRiwayat.add(
        PdfRiwayatStockOpname(
          noUrut.toString(),
          trimStringStrip(dataRekap.tgStocktake),
          trimStringStrip(dataRekap.name),
          trimStringStrip(dataRekap.nmProduct),
          trimStringStrip(dataRekap.stokAwal),
          formatMoney(trimStringStrip(dataRekap.totalHargaJualStock)),
          trimStringStrip(dataRekap.stokAkhir),
          formatMoney(trimStringStrip(dataRekap.totalHargaJualStocktake)),
          trimStringStrip(dataRekap.selisih),
          formatMoney(trimStringStrip(dataRekap.selisihHargaJual)),
        ),
      );
    }

    pw.Widget contentTable(pw.Context context) {
      //INITITALIZE TITLE
      List<String> itemTitle = [
        "NO",
        "TANGGAL STOCKTAKE",
        "NAMA",
        "NAMA PRODUK",
        "STOK AWAL",
        "TOTAL HARGA JUAL STOCK",
        "STOK AKHIR",
        "TOTAL HARGA JUAL STOCKTAKE",
        "SELISIH",
        "SELISIH HARGA JUAL",
      ];
//END INITIALIZE TITLE

      return pw.TableHelper.fromTextArray(
        border: pw.TableBorder.all(
          color: PdfColor.fromHex("#E3E7ED"),
          width: 1,
        ),
        headerAlignment: pw.Alignment.center,
        cellAlignment: pw.Alignment.center,
        defaultColumnWidth: const pw.IntrinsicColumnWidth(flex: 1),
        headerAlignments: {
          0: pw.Alignment.center,
          1: pw.Alignment.center,
          2: pw.Alignment.center,
          3: pw.Alignment.center,
          4: pw.Alignment.center,
          5: pw.Alignment.center,
          6: pw.Alignment.center,
          7: pw.Alignment.center,
          8: pw.Alignment.center,
          9: pw.Alignment.center,
        },
        columnWidths: {
          0: const pw.FixedColumnWidth(26),
          1: const pw.FlexColumnWidth(2.5),
          2: const pw.FlexColumnWidth(2.5),
          3: const pw.FlexColumnWidth(3),
          4: const pw.FlexColumnWidth(1.5),
          5: const pw.FlexColumnWidth(2.5),
          6: const pw.FlexColumnWidth(1.5),
          7: const pw.FlexColumnWidth(2.5),
          8: const pw.FlexColumnWidth(1.5),
          9: const pw.FlexColumnWidth(2.5),
        },
        cellAlignments: {
          0: pw.Alignment.center,
          1: pw.Alignment.centerLeft,
          2: pw.Alignment.centerLeft,
          3: pw.Alignment.centerLeft,
          4: pw.Alignment.center,
          5: pw.Alignment.centerRight,
          6: pw.Alignment.center,
          7: pw.Alignment.centerRight,
          8: pw.Alignment.center,
          9: pw.Alignment.centerRight,
        },
        headerStyle: pw.TextStyle(
          color: PdfColor.fromHex("#212121"),
          fontSize: 7,
          font: boldFont,
          fontWeight: pw.FontWeight.bold,
        ),
        headerCellDecoration: pw.BoxDecoration(
          color: PdfColor.fromHex("#F4F5F8"),
        ),
        cellPadding: const pw.EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 2,
        ),
        cellStyle: pw.TextStyle(
          font: regularFont,
          color: PdfColor.fromHex("#212121"),
          fontSize: 7,
        ),
        cellHeight: 16,
        headers: List<String>.generate(
          itemTitle.length,
          (col) => itemTitle[col],
        ),
        data: List<List<dynamic>>.generate(listDataRiwayat.length, (row) {
          return List<dynamic>.generate(itemTitle.length, (col) {
            if (col == 8) {
              // Kolom selisih dengan warna berdasarkan nilai
              String selisihValue = trimString(listDataRiwayat[row].getIndex(col));
              double selisih = double.tryParse(selisihValue) ?? 0;

              return pw.Container(
                decoration: pw.BoxDecoration(
                  borderRadius: const pw.BorderRadius.all(
                    pw.Radius.circular(8.0),
                  ),
                  color: selisih == 0
                      ? PdfColors.green50
                      : selisih > 0
                          ? PdfColors.blue50
                          : PdfColors.red50,
                ),
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: pw.Text(
                  selisihValue,
                  style: pw.TextStyle(
                    font: regularFont,
                    color: selisih == 0
                        ? PdfColors.green900
                        : selisih > 0
                            ? PdfColors.blue900
                            : PdfColors.red900,
                    fontSize: 7,
                  ),
                ),
              );
            }
            return trimString(listDataRiwayat[row].getIndex(col));
          });
        }),
      );
    }

    final pdf = pw.Document();

    // Build header title with period info if available
    String headerTitle = "RIWAYAT STOCK OPNAME";
    if (controller.monthNow != null && controller.yearNow != null) {
      headerTitle +=
          "\nPERIODE: ${getNamaMonth(controller.monthNow!).toUpperCase()} ${controller.yearNow}";
    } else if (controller.yearNow != null) {
      headerTitle += "\nTAHUN: ${controller.yearNow}";
    }

    // Add filter info
    if (controller.dropdown != "SEMUA") {
      headerTitle += "\nFILTER: ${controller.dropdown}";
    }

    headerTitle += "\nDICETAK TANGGAL: ${formatDateFull(DateTime.now().toString())}\nHalaman Ke - ";

    pdf.addPage(
      pw.MultiPage(
        maxPages: 10000,
        pageTheme: const pw.PageTheme(
          pageFormat: PdfPageFormat(29.7 * PdfPageFormat.cm, 21.0 * PdfPageFormat.cm),
          orientation: pw.PageOrientation.landscape,
          margin: pw.EdgeInsets.all(8),
        ),
        header: (context) => pw.Center(
          child: pw.Container(
            padding: const pw.EdgeInsets.only(bottom: 4),
            child: pw.Text(
              "$headerTitle${context.pageNumber}",
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
        ),
        build: (context) => [
          contentTable(context),
        ],
      ),
    );
    Uint8List pdfData = await pdf.save();

    // Build filename with period info if available
    String fileNamePeriod = "";
    if (controller.monthNow != null && controller.yearNow != null) {
      fileNamePeriod = "_${getNamaMonth(controller.monthNow!)}_${controller.yearNow}";
    } else if (controller.yearNow != null) {
      fileNamePeriod = "_${controller.yearNow}";
    }

    String fileName =
        'Riwayat_Stock_Opname${fileNamePeriod}_Hal_${controller.dataStockOpname.paging?.page.toString()}.pdf';

    await Printing.layoutPdf(
      name: fileName,
      onLayout: (PdfPageFormat format) async {
        return pdfData;
      },
    );
  } catch (e) {
    Get.back();
    showInfoDialog(e.toString(), globalContext);
  }

  Get.back();
}

class PdfRiwayatStockOpname {
  const PdfRiwayatStockOpname(
    this.no,
    this.tgStocktake,
    this.name,
    this.nmProduct,
    this.stokAwal,
    this.totalHargaJualStock,
    this.stokAkhir,
    this.totalHargaJualStocktake,
    this.selisih,
    this.selisihHargaJual,
  );

  final String no;
  final String tgStocktake;
  final String name;
  final String nmProduct;
  final String stokAwal;
  final String totalHargaJualStock;
  final String stokAkhir;
  final String totalHargaJualStocktake;
  final String selisih;
  final String selisihHargaJual;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return no;
      case 1:
        return tgStocktake;
      case 2:
        return name;
      case 3:
        return nmProduct;
      case 4:
        return stokAwal;
      case 5:
        return totalHargaJualStock;
      case 6:
        return stokAkhir;
      case 7:
        return totalHargaJualStocktake;
      case 8:
        return selisih;
      case 9:
        return selisihHargaJual;
    }
    return '';
  }
}
