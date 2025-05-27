import 'package:flutter/services.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/model/stock_opname/stock_take_model.dart';
import 'package:ksu_budidaya/module/stock_opname/stock_take_divisi/controller/stock_take_divisi_controller.dart';
import 'package:pdf/widgets.dart' as pw;

generatePdfStockTake({
  required StockTakeDivisiController controller,
}) async {
  showCircleDialogLoading();
  await Future.delayed(const Duration(seconds: 1));
  try {
    final ttfRegular = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");
    final regularFont = pw.Font.ttf(ttfRegular);
    final ttfBold = await rootBundle.load("assets/fonts/Roboto-Bold.ttf");
    final boldFont = pw.Font.ttf(ttfBold);
    List<PdfStockTake> listDataPenerimaan = [];

    for (var i = 0; i < (controller.dataStockOpname.dataStock?.length ?? 0); i++) {
      DetailDataStockTake dataRekap =
          controller.dataStockOpname.dataStock?[i] ?? DetailDataStockTake();
      // int noUrut = i + 1;

      listDataPenerimaan.add(
        PdfStockTake(
          trimString(dataRekap.idDivisi),
          trimString(dataRekap.nmDivisi),
          formatMoney(double.tryParse(dataRekap.stock ?? "0")?.toInt() ?? 0),
          formatMoney(double.tryParse(dataRekap.totalHargaJualStock ?? "0")?.toInt() ?? 0),
          formatMoney(double.tryParse(dataRekap.stockTake ?? "0")?.toInt() ?? 0),
          formatMoney(double.tryParse(dataRekap.totalHargaJualStocktake ?? "0")?.toInt() ?? 0),
          formatMoney(double.tryParse(dataRekap.selisih ?? "0")?.toInt() ?? 0),
          formatMoney(double.tryParse(dataRekap.selisihHargaJual ?? "0")?.toInt() ?? 0),
        ),
      );
    }

    listDataPenerimaan.add(
      PdfStockTake(
        "",
        trimString("TOTAL"),
        formatMoney(controller.dataStockOpname.totalData?.totalStock ?? 0),
        formatMoney(controller.dataStockOpname.totalData?.totalHargaJualStock ?? 0),
        formatMoney(controller.dataStockOpname.totalData?.totalStockTake ?? 0),
        formatMoney(controller.dataStockOpname.totalData?.totalHargaJualStocktake ?? 0),
        formatMoney(controller.dataStockOpname.totalData?.totalSelisih ?? 0),
        formatMoney(controller.dataStockOpname.totalData?.totalSelisihHargaJual ?? 0),
      ),
    );

    pw.Widget contentTable(pw.Context context) {
      //INITITALIZE TITLE
      List<String> itemTitle = [
        "ID DIVISI",
        "NAMA DIVISI",
        "STOCK",
        "HARGA JUAL",
        "STOCK TAKE",
        "HARGA JUAL",
        "SELISIH",
        "HARGA JUAL",
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
        },
        columnWidths: {
          0: const pw.FlexColumnWidth(1),
          1: const pw.FlexColumnWidth(3),
          2: const pw.FlexColumnWidth(1),
          3: const pw.FlexColumnWidth(2),
          4: const pw.FlexColumnWidth(1),
          5: const pw.FlexColumnWidth(2),
          6: const pw.FlexColumnWidth(1),
          7: const pw.FlexColumnWidth(2),
        },
        cellAlignments: {
          0: pw.Alignment.center,
          1: pw.Alignment.centerLeft,
          2: pw.Alignment.centerRight,
          3: pw.Alignment.centerRight,
          4: pw.Alignment.centerRight,
          5: pw.Alignment.centerRight,
          6: pw.Alignment.centerRight,
          7: pw.Alignment.centerRight,
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
        cellStyle: pw.TextStyle(
          font: regularFont,
          color: PdfColor.fromHex("#212121"),
          fontSize: 7,
        ),
        headers: List<String>.generate(
          itemTitle.length,
          (col) => itemTitle[col],
        ),
        data: List<List<dynamic>>.generate(listDataPenerimaan.length, (row) {
          return List<dynamic>.generate(itemTitle.length, (col) {
            return listDataPenerimaan[row].getIndex(col);
          });
        }),
      );
    }

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        maxPages: 1000,
        pageTheme: const pw.PageTheme(
          pageFormat: PdfPageFormat(21.0 * PdfPageFormat.cm, 29.7 * PdfPageFormat.cm),
          margin: pw.EdgeInsets.all(8),
        ),
        header: (context) => pw.Center(
          child: pw.Text(
            "STOCKTAKE\nDICETAK TANGGAL: ${formatDateFull(DateTime.now().toString())}\nHalaman Ke - ${context.pageNumber}",
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        build: (context) => [
          pw.SizedBox(
            height: 4.0,
          ),
          contentTable(context),
        ],
      ),
    );
    Uint8List pdfData = await pdf.save();

    String fileName = 'StockTake_Halaman_${controller.dataStockOpname.paging?.page.toString()}.pdf';

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

class PdfStockTake {
  const PdfStockTake(
    this.idDivisi,
    this.nmDivisi,
    this.stock,
    this.hargaJualStock,
    this.stocktake,
    this.hargaJualStocktake,
    this.selisih,
    this.selisihHargaJual,
  );

  final String idDivisi;
  final String nmDivisi;
  final String stock;
  final String hargaJualStock;
  final String stocktake;
  final String hargaJualStocktake;
  final String selisih;
  final String selisihHargaJual;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return idDivisi;
      case 1:
        return nmDivisi;
      case 2:
        return stock;
      case 3:
        return hargaJualStock;
      case 4:
        return stocktake;
      case 5:
        return hargaJualStocktake;
      case 6:
        return selisih;
      case 7:
        return selisihHargaJual;
    }
    return '';
  }
}
