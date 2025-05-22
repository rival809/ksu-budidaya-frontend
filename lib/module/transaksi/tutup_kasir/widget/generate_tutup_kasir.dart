import 'package:flutter/services.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pdf/widgets.dart' as pw;

doGenerateTutupKasir({required TutupKasirController controller}) async {
  showCircleDialogLoading();
  try {
    final pdf = pw.Document();

    DataTutupKasir data = controller.result.data ?? DataTutupKasir();

    List<RowDataTutupKasir> rows = [];

    for (var i = 0; i < (data.dataTutupKasir?.length ?? 0); i++) {
      DetailDataTutupKasir? dataDetail = data.dataTutupKasir?[i];
      rows.add(
        RowDataTutupKasir(
          tgTutupKasir: dataDetail?.tgTutupKasir,
          shift: dataDetail?.shift,
          namaKasir: dataDetail?.namaKasir,
          tunai: dataDetail?.tunai,
          qris: dataDetail?.qris,
          kredit: dataDetail?.kredit,
          total: dataDetail?.total,
          uangTunai: dataDetail?.uangTunai,
          totalNilaiJual: dataDetail?.totalNilaiJual,
          totalNilaiBeli: dataDetail?.totalNilaiBeli,
          totalKeuntungan: dataDetail?.totalKeuntungan,
        ),
      );
    }

    final ttfBold = await rootBundle.load("assets/fonts/Roboto-Bold.ttf");
    final ttfRegular = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");

    final boldFont = pw.Font.ttf(ttfBold);
    final regularFont = pw.Font.ttf(ttfRegular);
    const double inch = 72.0;
    const double cm = inch / 2.54;

    pdf.addPage(
      pw.MultiPage(
          pageTheme: const pw.PageTheme(
            pageFormat: PdfPageFormat(29.7 * cm, 21.0 * cm, marginAll: 1.0 * cm),
            margin: pw.EdgeInsets.all(8),
          ),
          header: (pw.Context context) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Center(
                    child: pw.Text(
                      "RIWAYAT TUTUP KASIR",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: boldFont,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  // pw.Center(
                  //   child: pw.Text(
                  //     '${getNamaMonth(controller.monthNow)} - ${controller.yearNow}',
                  //     textAlign: pw.TextAlign.center,
                  //     style: pw.TextStyle(
                  //       font: boldFont,
                  //       fontWeight: pw.FontWeight.bold,
                  //       fontSize: 12,
                  //     ),
                  //   ),
                  // ),
                  pw.SizedBox(height: 8),
                ],
              ),
          build: (pw.Context context) => [
                pw.TableHelper.fromTextArray(
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
                  },
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerLeft,
                    2: pw.Alignment.centerLeft,
                    3: pw.Alignment.centerRight,
                    4: pw.Alignment.centerRight,
                    5: pw.Alignment.centerRight,
                    6: pw.Alignment.centerRight,
                    7: pw.Alignment.centerRight,
                    8: pw.Alignment.centerRight,
                    9: pw.Alignment.centerRight,
                    10: pw.Alignment.centerRight,
                  },
                  headers: [
                    'Tanggal Tutup Kasir',
                    'Shift',
                    'Nama Kasir',
                    'Total Nilai Beli',
                    'Total Nilai Jual',
                    'Total Keuntungan',
                    'Tunai',
                    'QRIS',
                    'Kredit',
                    'Total',
                    'Uang Tunai',
                  ],
                  data: rows
                      .map((row) => [
                            trimString(row.tgTutupKasir),
                            trimString(row.shift),
                            trimString(row.namaKasir),
                            formatMoney(trimString(row.totalNilaiBeli)),
                            formatMoney(trimString(row.totalNilaiJual)),
                            formatMoney(trimString(row.totalKeuntungan)),
                            formatMoney(trimString(row.tunai)),
                            formatMoney(trimString(row.qris)),
                            formatMoney(trimString(row.kredit)),
                            formatMoney(trimString(row.total)),
                            formatMoney(trimString(row.uangTunai)),
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
                  cellHeight: 12,
                  columnWidths: {
                    0: const pw.FlexColumnWidth(2),
                    1: const pw.FlexColumnWidth(1),
                    2: const pw.FlexColumnWidth(2),
                    3: const pw.FlexColumnWidth(2),
                    4: const pw.FlexColumnWidth(2),
                    5: const pw.FlexColumnWidth(2),
                    6: const pw.FlexColumnWidth(2),
                    7: const pw.FlexColumnWidth(2),
                    8: const pw.FlexColumnWidth(2),
                    9: const pw.FlexColumnWidth(2),
                    10: const pw.FlexColumnWidth(2),
                  },
                ),
              ]),
    );
    Uint8List pdfData = await pdf.save();

    // String fileName = 'Riwayat_Tutup_kasir${controller.monthNow}_${controller.yearNow}.pdf';
    String fileName = 'Riwayat_Tutup_kasir.pdf';

    // await Printing.sharePdf(
    //   bytes: pdfData,
    //   filename: fileName,
    // );
    await Printing.layoutPdf(
      format: const PdfPageFormat(29.7 * cm, 21.0 * cm, marginAll: 1.0 * cm),
      name: fileName,
      onLayout: (PdfPageFormat format) async {
        return pdfData;
      },
    );
  } catch (e) {
    Get.back();
    showInfoDialog(e.toString(), null);
  }

  Get.back();
}
