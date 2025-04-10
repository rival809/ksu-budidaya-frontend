import 'package:flutter/services.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pdf/widgets.dart' as pw;

doGenerateLaporanNeraca({required LaporanController controller}) async {
  showCircleDialogLoading();
  try {
    final pdf = pw.Document();

    DataLaporanHasilUsaha data = controller.resultNeraca.data ?? DataLaporanHasilUsaha();

    List<RowLaporanNeraca> rowsActive = [
      RowLaporanNeraca(
        uraian: "ACTIVA LANCAR",
        currentMonth: null,
        lastMonth: null,
      ),
      RowLaporanNeraca(
        uraian: "KAS",
        currentMonth: 1000000,
        lastMonth: 1000000,
      ),
      RowLaporanNeraca(
        uraian: "BRI 1",
        currentMonth: 1000000,
        lastMonth: 1000000,
      ),
      RowLaporanNeraca(
        uraian: 'PIUTANG ANGGOTA',
        currentMonth: 100000,
        lastMonth: 10000,
      ),
      RowLaporanNeraca(
        uraian: 'PERSEDIAAN BARANG',
        currentMonth: 100000,
        lastMonth: 10000,
      ),
      RowLaporanNeraca(
        uraian: 'PENGHAPUSAN PERSEDIAAN',
        currentMonth: 100000,
        lastMonth: 10000,
      ),
      RowLaporanNeraca(
        uraian: 'JUMLAH',
        currentMonth: 100000,
        lastMonth: 10000,
      ),
      RowLaporanNeraca(
        uraian: "",
        currentMonth: 100000,
        lastMonth: 10000,
      ),
      RowLaporanNeraca(
        uraian: 'ACTIVA TETAP',
        currentMonth: 100000,
        lastMonth: 10000,
      ),
      RowLaporanNeraca(
        uraian: 'INVENTARIS',
        currentMonth: 100000,
        lastMonth: 10000,
      ),
      RowLaporanNeraca(
        uraian: 'GEDUNG',
        currentMonth: 100000,
        lastMonth: 10000,
      ),
      RowLaporanNeraca(
        uraian: 'JUMLAH',
        currentMonth: 100000,
        lastMonth: 10000,
      ),
      RowLaporanNeraca(
        uraian: '',
        currentMonth: 100000,
        lastMonth: 10000,
      ),
      RowLaporanNeraca(
        uraian: 'AKUMULASI PENYUSUTAN',
        currentMonth: 100000,
        lastMonth: 10000,
      ),
      RowLaporanNeraca(
        uraian: 'INVENTARIS',
        currentMonth: 100000,
        lastMonth: 10000,
      ),
      RowLaporanNeraca(
        uraian: 'GEDUNG',
        currentMonth: 100000,
        lastMonth: 10000,
      ),
      RowLaporanNeraca(
        uraian: 'JUMLAH',
        currentMonth: 100000,
        lastMonth: 10000,
      ),
      RowLaporanNeraca(
        uraian: '',
        currentMonth: 100000,
        lastMonth: 10000,
      ),
      RowLaporanNeraca(
        uraian: 'NILAI BUKU ACTIVA TETAP',
        currentMonth: 100000,
        lastMonth: 10000,
      ),
      RowLaporanNeraca(
        uraian: '',
        currentMonth: 100000,
        lastMonth: 10000,
      ),
      RowLaporanNeraca(
        uraian: 'ACTIVA LAIN',
        currentMonth: 100000,
        lastMonth: 10000,
      ),
      RowLaporanNeraca(
        uraian: 'JUMLAH',
        currentMonth: 100000,
        lastMonth: 10000,
      ),
      RowLaporanNeraca(
        uraian: '',
        currentMonth: 100000,
        lastMonth: 10000,
      ),
      RowLaporanNeraca(
        uraian: 'TOTAL ACTIVA',
        currentMonth: 100000,
        lastMonth: 10000,
      ),
    ];

    List<RowLaporanNeraca> rowsPassive = [
      RowLaporanNeraca(
        uraian: 'HUTANG LANCAR',
        currentMonth: null,
        lastMonth: null,
      ),
      RowLaporanNeraca(
        uraian: 'HUTANG DAGANG',
        currentMonth: 12000,
        lastMonth: 12000,
      ),
      RowLaporanNeraca(
        uraian: 'MODAL TIDAK TETAP',
        currentMonth: 0,
        lastMonth: 0,
      ),
      RowLaporanNeraca(
        uraian: 'JUMLAH',
        currentMonth: 0,
        lastMonth: 0,
      ),
      RowLaporanNeraca(
        uraian: '',
        currentMonth: 0,
        lastMonth: 0,
      ),
      RowLaporanNeraca(
        uraian: 'UTANG TOKO KE SP',
        currentMonth: 0,
        lastMonth: 0,
      ),
      RowLaporanNeraca(
        uraian: 'JUMLAH',
        currentMonth: 0,
        lastMonth: 0,
      ),
      RowLaporanNeraca(
        uraian: '',
        currentMonth: 0,
        lastMonth: 0,
      ),
      RowLaporanNeraca(
        uraian: 'DANA, MODAL, & SHU',
        currentMonth: 0,
        lastMonth: 0,
      ),
      RowLaporanNeraca(
        uraian: 'DANA USAHA LAIN-LAIN',
        currentMonth: 0,
        lastMonth: 0,
      ),
      RowLaporanNeraca(
        uraian: 'MODAL DISETOR',
        currentMonth: 0,
        lastMonth: 0,
      ),
      RowLaporanNeraca(
        uraian: 'MODAL UNIT TOKO',
        currentMonth: 0,
        lastMonth: 0,
      ),
      RowLaporanNeraca(
        uraian: 'SHU TH. 2023',
        currentMonth: 0,
        lastMonth: 0,
      ),
      RowLaporanNeraca(
        uraian: 'SHU TH. 2024',
        currentMonth: 0,
        lastMonth: 0,
      ),
      RowLaporanNeraca(
        uraian: 'HUTANG DAGANG',
        currentMonth: 0,
        lastMonth: 0,
      ),
      RowLaporanNeraca(
        uraian: 'JUMLAH',
        currentMonth: 0,
        lastMonth: 0,
      ),
      RowLaporanNeraca(
        uraian: '',
        currentMonth: null,
        lastMonth: null,
      ),
      RowLaporanNeraca(
        uraian: '',
        currentMonth: null,
        lastMonth: null,
      ),
      RowLaporanNeraca(
        uraian: '',
        currentMonth: null,
        lastMonth: null,
      ),
      RowLaporanNeraca(
        uraian: '',
        currentMonth: null,
        lastMonth: null,
      ),
      RowLaporanNeraca(
        uraian: '',
        currentMonth: null,
        lastMonth: null,
      ),
      RowLaporanNeraca(
        uraian: '',
        currentMonth: null,
        lastMonth: null,
      ),
      RowLaporanNeraca(
        uraian: '',
        currentMonth: null,
        lastMonth: null,
      ),
      RowLaporanNeraca(
        uraian: 'TOTAL PASSIVA',
        currentMonth: 0,
        lastMonth: 0,
      ),
    ];

    final ttfBold = await rootBundle.load("assets/fonts/Roboto-Bold.ttf");
    final ttfRegular = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");

    final boldFont = pw.Font.ttf(ttfBold);
    final regularFont = pw.Font.ttf(ttfRegular);

// Helper function to split rows into chunks
    List<List<dynamic>> paginateRows(List<dynamic> rows, int rowsPerPage) {
      final chunked = <List<dynamic>>[];
      for (int i = 0; i < rows.length; i += rowsPerPage) {
        chunked.add(rows.sublist(i, i + rowsPerPage > rows.length ? rows.length : i + rowsPerPage));
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
          data: rows
              .map((row) => [
                    row.uraian ?? '',
                    formatMoney(row.currentMonth?.toString() ?? ''),
                    formatMoney(row.lastMonth?.toString() ?? ''),
                  ])
              .toList(),
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
          cellHeight: 30,
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
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.all(16),
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
                  fontSize: 20,
                ),
              ),
              pw.Text(
                '${getNamaMonth(controller.monthNow).toUpperCase()} - ${controller.yearNow}',
                style: pw.TextStyle(
                  font: boldFont,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              pw.SizedBox(height: 16),
            ],
          ),
        ),
        build: (pw.Context context) {
          final activeChunks = paginateRows(rowsActive, 15); // Split rows into chunks
          final passiveChunks = paginateRows(rowsPassive, 15);

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
                  if (i < passiveChunks.length) createTable(passiveChunks[i], "Passive"),
                ],
              ),
            );
          }

          return pages;
        },
      ),
    );

    Uint8List pdfData = await pdf.save();

    String fileName = 'Laporan_Neraca_${controller.monthNow}_${controller.yearNow}.pdf';

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
