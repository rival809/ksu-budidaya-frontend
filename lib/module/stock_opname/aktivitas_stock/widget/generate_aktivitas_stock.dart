import 'package:flutter/services.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/model/stock_opname/aktivitas_stock_model.dart';
import 'package:ksu_budidaya/module/stock_opname/aktivitas_stock/controller/aktivitas_stock_controller.dart';
import 'package:pdf/widgets.dart' as pw;

generatePdfAktivitasStock({
  required AktivitasStockController controller,
}) async {
  showCircleDialogLoading();
  await Future.delayed(const Duration(seconds: 1));
  try {
    final ttfRegular = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");
    final regularFont = pw.Font.ttf(ttfRegular);
    final ttfBold = await rootBundle.load("assets/fonts/Roboto-Bold.ttf");
    final boldFont = pw.Font.ttf(ttfBold);
    List<PdfAktivitasStock> listDataPenerimaan = [];

    for (var i = 0;
        i < (controller.dataStockOpname.dataAktivitas?.length ?? 0);
        i++) {
      DataAktivitas dataRekap =
          controller.dataStockOpname.dataAktivitas?[i] ?? DataAktivitas();
      int noUrut = i + 1;

      listDataPenerimaan.add(
        PdfAktivitasStock(
          noUrut.toString(),
          formatDateFullTime(trimString(dataRekap.tgAktivitas)),
          formatDateFullTime(trimString(dataRekap.tgUpdateAktivitas)),
          trimStringStrip(dataRekap.nmProduct),
          trimStringStrip(dataRekap.divisi),
          trimStringStrip(dataRekap.jumlah),
          trimStringStrip(dataRekap.aktivitas),
          trimStringStrip(dataRekap.idAktivitas),
          trimStringStrip(dataRekap.user),
        ),
      );
    }

    pw.Widget contentTable(pw.Context context) {
      //INITITALIZE TITLE
      List<String> itemTitle = [
        "NO",
        "TANGGAL AKTIVITAS",
        "TANGGAL UPDATE AKTIVITAS",
        "NAMA PRODUK",
        "DIVISI",
        "JUMLAH",
        "AKTIVITAS",
        "ID AKTIVITAS",
        "USER",
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
        },
        columnWidths: {
          0: const pw.FixedColumnWidth(26),
          1: const pw.FlexColumnWidth(3),
          2: const pw.FlexColumnWidth(3),
          3: const pw.FlexColumnWidth(4),
          4: const pw.FlexColumnWidth(2),
          5: const pw.FlexColumnWidth(1),
          6: const pw.FlexColumnWidth(2),
          7: const pw.FlexColumnWidth(2),
          8: const pw.FlexColumnWidth(2),
        },
        cellAlignments: {
          0: pw.Alignment.center,
          1: pw.Alignment.centerLeft,
          2: pw.Alignment.centerLeft,
          3: pw.Alignment.centerLeft,
          4: pw.Alignment.centerLeft,
          5: pw.Alignment.center,
          6: pw.Alignment.center,
          7: pw.Alignment.centerLeft,
          8: pw.Alignment.centerLeft,
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
        data: List<List<dynamic>>.generate(listDataPenerimaan.length, (row) {
          return List<dynamic>.generate(itemTitle.length, (col) {
            if (col == 6) {
              return pw.Container(
                decoration: pw.BoxDecoration(
                  borderRadius: const pw.BorderRadius.all(
                    pw.Radius.circular(8.0),
                  ),
                  color: (trimString(listDataPenerimaan[row].getIndex(col))
                              .toUpperCase() ==
                          "PENJUALAN")
                      ? PdfColors.red50
                      : (trimString(listDataPenerimaan[row].getIndex(col))
                                  .toUpperCase() ==
                              "PEMBELIAN")
                          ? PdfColors.green50
                          : PdfColors.blue50,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Text(
                  trimString(listDataPenerimaan[row].getIndex(col)),
                  style: pw.TextStyle(
                    font: regularFont,
                    color: (trimString(listDataPenerimaan[row].getIndex(col))
                                .toUpperCase() ==
                            "PENJUALAN")
                        ? PdfColors.red900
                        : (trimString(listDataPenerimaan[row].getIndex(col))
                                    .toUpperCase() ==
                                "PEMBELIAN")
                            ? PdfColors.green900
                            : PdfColors.blue900,
                    fontSize: 7,
                  ),
                ),
              );
            }
            return trimString(listDataPenerimaan[row].getIndex(col));
          });
        }),
      );
    }

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        maxPages: 1000,
        pageTheme: const pw.PageTheme(
          pageFormat:
              PdfPageFormat(29.7 * PdfPageFormat.cm, 21.0 * PdfPageFormat.cm),
          orientation: pw.PageOrientation.landscape,
          margin: pw.EdgeInsets.all(8),
        ),
        header: (context) => pw.Center(
          child: pw.Container(
            padding: const pw.EdgeInsets.only(bottom: 4),
            child: pw.Text(
              "AKTIVITAS STOCK\nDICETAK TANGGAL: ${formatDateFull(DateTime.now().toString())}\nHalaman Ke - ${context.pageNumber}",
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

    String fileName =
        'Aktivitas_Stock_${controller.dataStockOpname.paging?.page.toString()}.pdf';

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

class PdfAktivitasStock {
  const PdfAktivitasStock(
    this.no,
    this.tgAktivitas,
    this.tgUpdateAktivitas,
    this.nmProduct,
    this.divisi,
    this.jumlah,
    this.aktivitas,
    this.idAktivitas,
    this.user,
  );

  final String no;
  final String tgAktivitas;
  final String tgUpdateAktivitas;
  final String nmProduct;
  final String divisi;
  final String jumlah;
  final String aktivitas;
  final String idAktivitas;
  final String user;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return no;
      case 1:
        return tgAktivitas;
      case 2:
        return tgUpdateAktivitas;
      case 3:
        return nmProduct;
      case 4:
        return divisi;
      case 5:
        return jumlah;
      case 6:
        return aktivitas;
      case 7:
        return idAktivitas;
      case 8:
        return user;
    }
    return '';
  }
}
