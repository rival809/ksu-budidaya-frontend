import 'package:flutter/services.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/model/stock_opname/stock_take_model.dart';
import 'package:ksu_budidaya/module/stock_opname/stock_take/controller/stock_take_controller.dart';
import 'package:pdf/widgets.dart' as pw;

generatePdfStockTake({
  required StockTakeController controller,
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
      int noUrut = i + 1;

      listDataPenerimaan.add(
        PdfStockTake(
          noUrut.toString(),
          trimString(dataRekap.idProduct),
          trimString(dataRekap.nmProduct),
          trimString(dataRekap.divisi),
          formatMoney(double.tryParse(dataRekap.stock ?? "0")?.toInt() ?? 0),
          formatMoney(double.tryParse(dataRekap.totalHargaJualStock ?? "0")?.toInt() ?? 0),
          formatMoney(double.tryParse(dataRekap.stocktake ?? "0")?.toInt() ?? 0),
          formatMoney(double.tryParse(dataRekap.totalHargaJualStocktake ?? "0")?.toInt() ?? 0),
          formatMoney(double.tryParse(dataRekap.selisih ?? "0")?.toInt() ?? 0),
          formatMoney(double.tryParse(dataRekap.selisihHargaJual ?? "0")?.toInt() ?? 0),
          trimString(dataRekap.petugas),
          trimString(dataRekap.isSelisih.toString()),
        ),
      );
    }

    pw.Widget contentTable(pw.Context context) {
      //INITITALIZE TITLE
      List<String> itemTitle = [
        "NO",
        "ID PRODUK",
        "NAMA PRODUK",
        "DIVISI",
        "STOCK",
        "HARGA JUAL",
        "STOCKETAKE",
        "HARGA JUAL",
        "SELISIH",
        "HARGA JUAL",
        "PETUGAS",
        "KETERANGAN",
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
          10: pw.Alignment.center,
          11: pw.Alignment.center,
        },
        columnWidths: {
          0: const pw.FixedColumnWidth(26),
          4: const pw.FixedColumnWidth(50),
          5: const pw.FixedColumnWidth(50),
          6: const pw.FixedColumnWidth(50),
          7: const pw.FixedColumnWidth(50),
          8: const pw.FixedColumnWidth(50),
          9: const pw.FixedColumnWidth(50),
        },
        cellAlignments: {
          0: pw.Alignment.center,
          1: pw.Alignment.centerLeft,
          2: pw.Alignment.centerLeft,
          3: pw.Alignment.centerLeft,
          4: pw.Alignment.centerRight,
          5: pw.Alignment.centerRight,
          6: pw.Alignment.centerRight,
          7: pw.Alignment.centerRight,
          8: pw.Alignment.centerRight,
          9: pw.Alignment.centerRight,
          10: pw.Alignment.centerLeft,
          11: pw.Alignment.center,
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
            if (col == 11) {
              return pw.Container(
                decoration: pw.BoxDecoration(
                  borderRadius: const pw.BorderRadius.all(
                    pw.Radius.circular(8.0),
                  ),
                  color: (listDataPenerimaan[row].getIndex(col) == "true")
                      ? PdfColors.red50
                      : PdfColors.green50,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Text(
                  (listDataPenerimaan[row].getIndex(col) == "true") ? "SELISIH" : "SEIMBANG",
                  style: pw.TextStyle(
                    font: regularFont,
                    color: (listDataPenerimaan[row].getIndex(col) == "true")
                        ? PdfColors.red900
                        : PdfColors.green900,
                    fontSize: 7,
                  ),
                ),
              );
            }
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
          pageFormat: PdfPageFormat(29.7 * PdfPageFormat.cm, 21.0 * PdfPageFormat.cm),
          orientation: pw.PageOrientation.landscape,
          margin: pw.EdgeInsets.all(16),
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
            height: 16.0,
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
    this.no,
    this.idProduk,
    this.divisi,
    this.namaProduk,
    this.stock,
    this.hargaJualStock,
    this.stocktake,
    this.hargaJualStocktake,
    this.selisih,
    this.selisihHargaJual,
    this.petugas,
    this.isSelisih,
  );

  final String no;
  final String idProduk;
  final String divisi;
  final String namaProduk;
  final String stock;
  final String hargaJualStock;
  final String stocktake;
  final String hargaJualStocktake;
  final String selisih;
  final String selisihHargaJual;
  final String petugas;
  final String isSelisih;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return no;
      case 1:
        return idProduk;
      case 2:
        return divisi;
      case 3:
        return namaProduk;
      case 4:
        return stock;
      case 5:
        return hargaJualStock;
      case 6:
        return stocktake;
      case 7:
        return hargaJualStocktake;
      case 8:
        return selisih;
      case 9:
        return selisihHargaJual;
      case 10:
        return petugas;
      case 11:
        return isSelisih;
    }
    return '';
  }
}
