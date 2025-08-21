import 'package:flutter/services.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pdf/widgets.dart' as pw;

doGenerateLaporanNeraca({required LaporanController controller}) async {
  showCircleDialogLoading();
  try {
    final pdf = pw.Document();

    DataLaporanNeraca data =
        controller.resultNeraca.data ?? DataLaporanNeraca();
    List<RowLaporanNeraca> rowsActive =
        buildRowsActivaPdf(data.current, data.previous);
    List<RowLaporanNeraca> rowsPassive =
        buildRowsPassivaPdf(data.current, data.previous);

    final ttfBold = await rootBundle.load("assets/fonts/Roboto-Bold.ttf");
    final ttfRegular = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");

    final boldFont = pw.Font.ttf(ttfBold);
    final regularFont = pw.Font.ttf(ttfRegular);

// Helper function to split rows into chunks
    List<List<dynamic>> paginateRows(List<dynamic> rows, int rowsPerPage) {
      final chunked = <List<dynamic>>[];
      for (int i = 0; i < rows.length; i += rowsPerPage) {
        chunked.add(rows.sublist(
            i, i + rowsPerPage > rows.length ? rows.length : i + rowsPerPage));
      }
      return chunked;
    }

// Create a table for a given chunk of data
    pw.Widget createTable(List<dynamic> rows, String title) {
      return pw.Expanded(
        child: pw.TableHelper.fromTextArray(
          headers: [
            'URAIAN',
            '${getNamaMonth(controller.monthNow)} - ${controller.yearNow}',
            subtractOneMonth(controller.monthNow, controller.yearNow),
          ],
          // data: rows
          //     .map((row) => [
          //           row.uraian ?? '',
          //           formatMoney(row.currentMonth?.toString() ?? ''),
          //           formatMoney(row.lastMonth?.toString() ?? ''),
          //         ])
          //     .toList(),
          data: List<List<dynamic>>.generate(rows.length, (row) {
            return List<dynamic>.generate(3, (col) {
              if (col == 0) {
                return Text(
                  rows[row].uraian ?? '',
                  style: pw.TextStyle(
                    fontSize: 8,
                    font: [
                      "ACTIVA LANCAR",
                      "JUMLAH",
                      "HAACTIVA TETAP",
                      "AKUMULASI PENYUSUTAN",
                      "ACTIVA LAIN",
                      "TOTAL ACTIVA",
                      "HUTANG LANCAR",
                      "DANA, MODAL, & SHU",
                      "TOTAL PASSIVA",
                    ].any((element) => element == rows[row].uraian)
                        ? boldFont
                        : regularFont,
                  ),
                );
              } else if (col == 1) {
                return Text(
                  formatMoney(trimString(rows[row].currentMonth.toString())),
                  style: pw.TextStyle(
                    fontSize: 8,
                    font: [
                      "ACTIVA LANCAR",
                      "JUMLAH",
                      "HAACTIVA TETAP",
                      "AKUMULASI PENYUSUTAN",
                      "ACTIVA LAIN",
                      "TOTAL ACTIVA",
                      "HUTANG LANCAR",
                      "DANA, MODAL, & SHU",
                      "TOTAL PASSIVA",
                    ].any((element) => element == rows[row].uraian)
                        ? boldFont
                        : regularFont,
                  ),
                );
              } else if (col == 2) {
                return Text(
                  formatMoney(trimString(rows[row].lastMonth.toString())),
                  style: pw.TextStyle(
                    fontSize: 8,
                    font: [
                      "ACTIVA LANCAR",
                      "JUMLAH",
                      "HAACTIVA TETAP",
                      "AKUMULASI PENYUSUTAN",
                      "ACTIVA LAIN",
                      "TOTAL ACTIVA",
                      "HUTANG LANCAR",
                      "DANA, MODAL, & SHU",
                      "TOTAL PASSIVA",
                    ].any((element) => element == rows[row].uraian)
                        ? boldFont
                        : regularFont,
                  ),
                );
              }
              return '';
            });
          }),
          border: pw.TableBorder.all(),
          headerStyle: pw.TextStyle(
            font: boldFont,
            color: PdfColors.white,
            fontSize: 10,
          ),
          headerDecoration: const pw.BoxDecoration(
            color: PdfColor.fromInt(0xFF017260),
          ),
          cellStyle: pw.TextStyle(
            font: regularFont,
            fontSize: 8,
          ),
          cellHeight: 16,
          cellAlignments: {
            0: pw.Alignment.centerLeft,
            1: pw.Alignment.centerRight,
            2: pw.Alignment.centerRight,
          },
          columnWidths: {
            0: const pw.FlexColumnWidth(4),
            1: const pw.FlexColumnWidth(1),
            2: const pw.FlexColumnWidth(1),
          },
        ),
      );
    }

    pdf.addPage(
      pw.MultiPage(
        pageTheme: const pw.PageTheme(
          orientation: pw.PageOrientation.landscape,
          pageFormat: PdfPageFormat(
              29.7 * PdfPageFormat.cm, 21 * PdfPageFormat.cm,
              marginAll: 8),
        ),
        header: (pw.Context context) => Center(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(
                "LAPORAN NERACA",
                style: pw.TextStyle(
                  font: boldFont,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              pw.Text(
                '${getNamaMonth(controller.monthNow).toUpperCase()} - ${controller.yearNow}',
                style: pw.TextStyle(
                  font: boldFont,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              pw.SizedBox(height: 8),
            ],
          ),
        ),
        build: (pw.Context context) {
          final activeChunks =
              paginateRows(rowsActive, 25); // Split rows into chunks
          final passiveChunks = paginateRows(rowsPassive, 25);

          final pages = <pw.Widget>[];

          for (int i = 0; i < activeChunks.length; i++) {
            pages.add(
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  createTable(activeChunks[i], "Active"),
                  pw.SizedBox(width: 16),
                  if (i >= passiveChunks.length)
                    pw.Expanded(
                      child: pw.Container(),
                    ),
                  if (i < passiveChunks.length)
                    createTable(passiveChunks[i], "Passive"),
                ],
              ),
            );
          }

          return pages;
        },
      ),
    );

    Uint8List pdfData = await pdf.save();

    String fileName =
        'Laporan_Neraca_${controller.monthNow}_${controller.yearNow}.pdf';

    // await Printing.sharePdf(
    //   bytes: pdfData,
    //   filename: fileName,
    // );
    await Printing.layoutPdf(
      format: PdfPageFormat.a4,
      name: fileName,
      onLayout: (PdfPageFormat format) async => pdfData,
    );
  } catch (e) {
    Get.back();
    showInfoDialog(e.toString(), null);
  }

  Get.back();
}

// Helper class untuk row PDF
// class RowLaporanNeraca {
//   final String uraian;
//   final dynamic currentMonth;
//   final dynamic lastMonth;
//   RowLaporanNeraca({required this.uraian, this.currentMonth, this.lastMonth});
// }

List<RowLaporanNeraca> buildRowsActivaPdf(
    DetailLaporanNeraca? current, DetailLaporanNeraca? previous) {
  final List<RowLaporanNeraca> rows = [];
  rows.add(RowLaporanNeraca(uraian: 'ACTIVA LANCAR'));
  if (current?.aktivaLancar != null) {
    current!.aktivaLancar!.forEach((key, value) {
      rows.add(RowLaporanNeraca(
        uraian: key.toString().toUpperCase().replaceAll("_", " "),
        currentMonth: value,
        lastMonth: previous?.aktivaLancar?[key],
      ));
    });
  }
  rows.add(RowLaporanNeraca(uraian: ''));
  rows.add(RowLaporanNeraca(uraian: 'ACTIVA TETAP'));
  if (current?.aktivaTetap != null) {
    rows.add(RowLaporanNeraca(
      uraian: 'INVENTARIS',
      currentMonth: current?.aktivaTetap?.inventaris,
      lastMonth: previous?.aktivaTetap?.inventaris,
    ));
    rows.add(RowLaporanNeraca(
      uraian: 'GEDUNG',
      currentMonth: current?.aktivaTetap?.gedung,
      lastMonth: previous?.aktivaTetap?.gedung,
    ));
    rows.add(RowLaporanNeraca(
      uraian: 'JUMLAH',
      currentMonth: current?.aktivaTetap?.jumlah,
      lastMonth: previous?.aktivaTetap?.jumlah,
    ));
  }
  rows.add(RowLaporanNeraca(uraian: ''));
  rows.add(RowLaporanNeraca(uraian: 'AKUMULASI PENYUSUTAN'));
  if (current?.akumPenyusutan != null) {
    rows.add(RowLaporanNeraca(
      uraian: 'INVENTARIS',
      currentMonth: current?.akumPenyusutan?.inventaris,
      lastMonth: previous?.akumPenyusutan?.inventaris,
    ));
    rows.add(RowLaporanNeraca(
      uraian: 'GEDUNG',
      currentMonth: current?.akumPenyusutan?.gedung,
      lastMonth: previous?.akumPenyusutan?.gedung,
    ));
    rows.add(RowLaporanNeraca(
      uraian: 'JUMLAH',
      currentMonth: current?.akumPenyusutan?.jumlah,
      lastMonth: previous?.akumPenyusutan?.jumlah,
    ));
  }
  rows.add(RowLaporanNeraca(uraian: ''));
  rows.add(RowLaporanNeraca(
    uraian: 'NILAI BUKU ACTIVA TETAP',
    currentMonth: current?.nilaiBukuAktiva,
    lastMonth: previous?.nilaiBukuAktiva,
  ));
  rows.add(RowLaporanNeraca(uraian: ''));
  rows.add(RowLaporanNeraca(uraian: 'ACTIVA LAIN'));
  if (current?.aktivaLain != null) {
    rows.add(RowLaporanNeraca(
      uraian: 'JUMLAH',
      currentMonth: current?.aktivaLain?.jumlah,
      lastMonth: previous?.aktivaLain?.jumlah,
    ));
  }
  rows.add(RowLaporanNeraca(uraian: ''));
  rows.add(RowLaporanNeraca(
    uraian: 'TOTAL ACTIVA',
    currentMonth: current?.totalAktiva,
    lastMonth: previous?.totalAktiva,
  ));
  return rows;
}

List<RowLaporanNeraca> buildRowsPassivaPdf(
    DetailLaporanNeraca? current, DetailLaporanNeraca? previous) {
  final List<RowLaporanNeraca> rows = [];
  rows.add(RowLaporanNeraca(uraian: 'HUTANG LANCAR'));
  if (current?.hutangLancar != null) {
    rows.add(RowLaporanNeraca(
      uraian: 'HUTANG DAGANG',
      currentMonth: current?.hutangLancar?.hutangDagang,
      lastMonth: previous?.hutangLancar?.hutangDagang,
    ));
    rows.add(RowLaporanNeraca(
      uraian: 'MODAL TIDAK TETAP',
      currentMonth: current?.hutangLancar?.modalTidakTetap,
      lastMonth: previous?.hutangLancar?.modalTidakTetap,
    ));
    rows.add(RowLaporanNeraca(
      uraian: 'JUMLAH',
      currentMonth: current?.hutangLancar?.jumlah,
      lastMonth: previous?.hutangLancar?.jumlah,
    ));
  }
  rows.add(RowLaporanNeraca(uraian: ''));
  if (current?.utangDariSp != null) {
    rows.add(RowLaporanNeraca(
      uraian: 'UTANG TOKO KE SP',
      currentMonth: current?.utangDariSp?.utangDariSp,
      lastMonth: previous?.utangDariSp?.utangDariSp,
    ));
    rows.add(RowLaporanNeraca(
      uraian: 'JUMLAH',
      currentMonth: current?.utangDariSp?.jumlah,
      lastMonth: previous?.utangDariSp?.jumlah,
    ));
  }
  rows.add(RowLaporanNeraca(uraian: ''));
  rows.add(RowLaporanNeraca(uraian: 'DANA, MODAL, & SHU'));
  if (current?.danaModalShu != null) {
    current!.danaModalShu!.forEach((key, value) {
      rows.add(RowLaporanNeraca(
        uraian: key.toString().toUpperCase().replaceAll("_", " "),
        currentMonth: value,
        lastMonth: previous?.danaModalShu?[key],
      ));
    });
  }
  rows.add(RowLaporanNeraca(uraian: ''));
  rows.add(RowLaporanNeraca(
    uraian: 'TOTAL PASSIVA',
    currentMonth: current?.totalPasiva,
    lastMonth: previous?.totalPasiva,
  ));
  return rows;
}
