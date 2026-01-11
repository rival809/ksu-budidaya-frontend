import 'package:flutter/services.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pdf/widgets.dart' as pw;

generatePdfStockOpname({
  required StockOpnameHarianController controller,
}) async {
  showCircleDialogLoading();
  await Future.delayed(const Duration(seconds: 1));
  try {
    final ttfRegular = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");
    final regularFont = pw.Font.ttf(ttfRegular);
    final ttfBold = await rootBundle.load("assets/fonts/Roboto-Bold.ttf");
    final boldFont = pw.Font.ttf(ttfBold);
    List<PdfStockOpnameItem> listDataStockOpname = [];

    for (var i = 0; i < (controller.itemsData.data?.length ?? 0); i++) {
      DetailListStocktakeItemsilDataListStocktakeItems dataItem =
          controller.itemsData.data?[i] ?? DetailListStocktakeItemsilDataListStocktakeItems();
      int noUrut = i + 1;

      // Calculate values
      double hargaJual = double.tryParse(dataItem.hargaJual ?? "0") ?? 0;
      double stokSistem = dataItem.stokSistem ?? 0;
      double stokFisik = dataItem.stokFisik ?? 0;
      double selisih = dataItem.selisih ?? 0;

      listDataStockOpname.add(
        PdfStockOpnameItem(
          noUrut.toString(),
          trimString(dataItem.idProduct),
          trimString(dataItem.nmProduct),
          trimString(dataItem.nmDivisi),
          formatMoney(stokSistem.toInt()),
          formatMoney((stokSistem * hargaJual).toInt()),
          formatMoney(stokFisik.toInt()),
          formatMoney((stokFisik * hargaJual).toInt()),
          formatMoney(selisih.toInt()),
          formatMoney((selisih * hargaJual).toInt()),
          dataItem.isCounted == true ? "Sudah SO" : "Belum SO",
          trimString(dataItem.notes),
        ),
      );
    }

    pw.Widget contentTable(pw.Context context) {
      //INITIALIZE TITLE
      List<String> itemTitle = [
        "NO",
        "ID",
        "NAMA PRODUK",
        "DIVISI",
        "STOK SISTEM\nJML",
        "STOK SISTEM\nHARGA",
        "STOK FISIK\nJML",
        "STOK FISIK\nHARGA",
        "SELISIH\nJML",
        "SELISIH\nHARGA",
        "STATUS",
        "NOTES",
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
          0: const pw.FlexColumnWidth(0.5),
          1: const pw.FlexColumnWidth(1.5),
          2: const pw.FlexColumnWidth(3),
          3: const pw.FlexColumnWidth(1.5),
          4: const pw.FlexColumnWidth(1),
          5: const pw.FlexColumnWidth(1.5),
          6: const pw.FlexColumnWidth(1),
          7: const pw.FlexColumnWidth(1.5),
          8: const pw.FlexColumnWidth(1),
          9: const pw.FlexColumnWidth(1.5),
          10: const pw.FlexColumnWidth(1.2),
          11: const pw.FlexColumnWidth(2),
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
          10: pw.Alignment.center,
          11: pw.Alignment.centerLeft,
        },
        headerStyle: pw.TextStyle(
          color: PdfColor.fromHex("#212121"),
          fontSize: 6,
          font: boldFont,
          fontWeight: pw.FontWeight.bold,
        ),
        headerCellDecoration: pw.BoxDecoration(
          color: PdfColor.fromHex("#F4F5F8"),
        ),
        cellStyle: pw.TextStyle(
          font: regularFont,
          color: PdfColor.fromHex("#212121"),
          fontSize: 6,
        ),
        headers: List<String>.generate(
          itemTitle.length,
          (col) => itemTitle[col],
        ),
        data: List<List<dynamic>>.generate(listDataStockOpname.length, (row) {
          return List<dynamic>.generate(itemTitle.length, (col) {
            return listDataStockOpname[row].getIndex(col);
          });
        }),
      );
    }

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        maxPages: 1000,
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4.landscape,
          margin: const pw.EdgeInsets.all(8),
        ),
        header: (context) => pw.Center(
          child: pw.Text(
            "STOCK OPNAME ${controller.stocktakeType}\nSESI: ${controller.sessionData?.idStocktakeSession ?? '-'}\nDICETAK TANGGAL: ${formatDateFull(DateTime.now().toString())}\nHalaman Ke - ${context.pageNumber}",
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
              font: boldFont,
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

    String fileName =
        'StockOpname_${controller.stocktakeType}_${controller.sessionData?.idStocktakeSession ?? 'Session'}_Hal_${controller.page}.pdf';

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

class PdfStockOpnameItem {
  const PdfStockOpnameItem(
    this.no,
    this.idProduct,
    this.nmProduct,
    this.nmDivisi,
    this.stokSistemJml,
    this.stokSistemHarga,
    this.stokFisikJml,
    this.stokFisikHarga,
    this.selisihJml,
    this.selisihHarga,
    this.status,
    this.notes,
  );

  final String no;
  final String idProduct;
  final String nmProduct;
  final String nmDivisi;
  final String stokSistemJml;
  final String stokSistemHarga;
  final String stokFisikJml;
  final String stokFisikHarga;
  final String selisihJml;
  final String selisihHarga;
  final String status;
  final String notes;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return no;
      case 1:
        return idProduct;
      case 2:
        return nmProduct;
      case 3:
        return nmDivisi;
      case 4:
        return stokSistemJml;
      case 5:
        return stokSistemHarga;
      case 6:
        return stokFisikJml;
      case 7:
        return stokFisikHarga;
      case 8:
        return selisihJml;
      case 9:
        return selisihHarga;
      case 10:
        return status;
      case 11:
        return notes;
    }
    return '';
  }
}
