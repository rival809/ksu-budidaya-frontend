import 'package:flutter/services.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pdf/widgets.dart' as pw;

doGenerateLaporanNeracaLajur({required LaporanController controller}) async {
  showCircleDialogLoading();
  try {
    final pdf = pw.Document();

    DataNeracaLajur data = controller.resultNeracaLajur.data ?? DataNeracaLajur();

    Map<String, DataNeraca?>? dataNeraca = data.dataNeraca ?? {};
    TotalNeraca dataTotal = data.totalNeraca ?? TotalNeraca();

    List<RowLaporanNeracaLajur> rows = [];

    dataNeraca.forEach((key, value) {
      rows.add(RowLaporanNeracaLajur(
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
      ));
    });

    rows.add(
      RowLaporanNeracaLajur(
        uraian: 'TOTAL',
        neracaAwalD: dataTotal.totalNeracaAwal?.debit ?? 0,
        neracaAwalK: dataTotal.totalNeracaAwal?.kredit ?? 0,
        neracaMutasiD: dataTotal.totalNeracaMutasi?.debit ?? 0,
        neracaMutasiK: dataTotal.totalNeracaMutasi?.kredit ?? 0,
        neracaPercobaanD: dataTotal.totalNeracaPercobaan?.debit ?? 0,
        neracaPercobaanK: dataTotal.totalNeracaPercobaan?.kredit ?? 0,
        neracaSaldoD: dataTotal.totalNeracaSaldo?.debit ?? 0,
        neracaSaldoK: dataTotal.totalNeracaSaldo?.kredit ?? 0,
        neracaHasilUsahaD: dataTotal.totalHasilUsaha?.debit ?? 0,
        neracaHasilUsahaK: dataTotal.totalHasilUsaha?.kredit ?? 0,
        neracaAkhirD: dataTotal.totalNeracaAkhir?.debit ?? 0,
        neracaAkhirK: dataTotal.totalNeracaAkhir?.kredit ?? 0,
      ),
    );

    final ttfBold = await rootBundle.load("assets/fonts/Roboto-Bold.ttf");
    final ttfRegular = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");

    final boldFont = pw.Font.ttf(ttfBold);
    final regularFont = pw.Font.ttf(ttfRegular);

    pdf.addPage(
      pw.MultiPage(
          pageTheme: const pw.PageTheme(
            orientation: pw.PageOrientation.landscape,
            pageFormat: PdfPageFormat(29.7 * PdfPageFormat.cm, 21 * PdfPageFormat.cm, marginAll: 8),
          ),
          header: (pw.Context context) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Center(
                    child: pw.Text(
                      "LAPORAN NERACA LAJUR",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: boldFont,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Center(
                    child: pw.Text(
                      '${getNamaMonth(controller.monthNow).toUpperCase()} - ${controller.yearNow}',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: boldFont,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 4),
                ],
              ),
          build: (pw.Context context) => [
                pw.TableHelper.fromTextArray(
                  border: pw.TableBorder.all(),
                  headerStyle: pw.TextStyle(
                    font: boldFont,
                    color: PdfColors.white,
                    fontSize: 9,
                  ),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColor.fromInt(0xFF017260),
                  ),
                  headerAlignments: {
                    0: pw.Alignment.center,
                    1: pw.Alignment.center,
                    2: pw.Alignment.center,
                    3: pw.Alignment.center,
                    4: pw.Alignment.center,
                    5: pw.Alignment.center,
                    6: pw.Alignment.center,
                  },
                  columnWidths: {
                    0: const pw.FlexColumnWidth(11),
                    1: const pw.FlexColumnWidth(10),
                    2: const pw.FlexColumnWidth(10),
                    3: const pw.FlexColumnWidth(10),
                    4: const pw.FlexColumnWidth(10),
                    5: const pw.FlexColumnWidth(10),
                    6: const pw.FlexColumnWidth(10),
                  },
                  headers: [
                    '',
                    'NERACA AWAL',
                    'NERACA MUTASI',
                    'NERACA PERCOBAAN',
                    'NERACA SALDO',
                    'NERACA HASIL USAHA',
                    'NERACA AKHIR',
                  ],
                  data: [],
                ),
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
                    11: pw.Alignment.center,
                    12: pw.Alignment.center,
                  },
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerRight,
                    2: pw.Alignment.centerRight,
                    3: pw.Alignment.centerRight,
                    4: pw.Alignment.centerRight,
                    5: pw.Alignment.centerRight,
                    6: pw.Alignment.centerRight,
                    7: pw.Alignment.centerRight,
                    8: pw.Alignment.centerRight,
                    9: pw.Alignment.centerRight,
                    10: pw.Alignment.centerRight,
                    11: pw.Alignment.centerRight,
                    12: pw.Alignment.centerRight,
                  },
                  headers: [
                    "URAIAN",
                    'D',
                    "K",
                    'D',
                    "K",
                    'D',
                    "K",
                    'D',
                    "K",
                    'D',
                    "K",
                    'D',
                    "K",
                  ],
                  data: rows
                      .map((row) => [
                            row.uraian ?? '',
                            formatMoneyDouble(row.neracaAwalD?.toInt() ?? 0),
                            formatMoneyDouble(row.neracaAwalK?.toInt() ?? 0),
                            formatMoneyDouble(row.neracaMutasiD?.toInt() ?? 0),
                            formatMoneyDouble(row.neracaMutasiK?.toInt() ?? 0),
                            formatMoneyDouble(row.neracaPercobaanD?.toInt() ?? 0),
                            formatMoneyDouble(row.neracaPercobaanK?.toInt() ?? 0),
                            formatMoneyDouble(row.neracaSaldoD?.toInt() ?? 0),
                            formatMoneyDouble(row.neracaSaldoK?.toInt() ?? 0),
                            formatMoneyDouble(row.neracaHasilUsahaD?.toInt() ?? 0),
                            formatMoneyDouble(row.neracaHasilUsahaK?.toInt() ?? 0),
                            formatMoneyDouble(row.neracaAkhirD?.toInt() ?? 0),
                            formatMoneyDouble(row.neracaAkhirK?.toInt() ?? 0),
                          ])
                      .toList(),
                  border: pw.TableBorder.all(),
                  cellPadding: const pw.EdgeInsets.all(2),
                  headerStyle: pw.TextStyle(
                    font: boldFont,
                    color: PdfColors.white,
                    fontSize: 9,
                  ),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColor.fromInt(0xFF017260),
                  ),
                  cellStyle: pw.TextStyle(
                    font: regularFont,
                    fontSize: 7,
                  ),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(11),
                    1: const pw.FlexColumnWidth(5),
                    2: const pw.FlexColumnWidth(5),
                    3: const pw.FlexColumnWidth(5),
                    4: const pw.FlexColumnWidth(5),
                    5: const pw.FlexColumnWidth(5),
                    6: const pw.FlexColumnWidth(5),
                    7: const pw.FlexColumnWidth(5),
                    8: const pw.FlexColumnWidth(5),
                    9: const pw.FlexColumnWidth(5),
                    10: const pw.FlexColumnWidth(5),
                    11: const pw.FlexColumnWidth(5),
                    12: const pw.FlexColumnWidth(5),
                  },
                ),
              ]),
    );
    Uint8List pdfData = await pdf.save();

    String fileName = 'Laporan_Neraca_Lajur_${controller.monthNow}_${controller.yearNow}.pdf';

    // await Printing.sharePdf(
    //   bytes: pdfData,
    //   filename: fileName,
    // );
    await Printing.layoutPdf(
      format: const PdfPageFormat(29.7 * PdfPageFormat.cm, 21 * PdfPageFormat.cm, marginAll: 8),
      name: fileName,
      onLayout: (PdfPageFormat format) async => pdfData,
    );
  } catch (e) {
    Get.back();
    showInfoDialog(e.toString(), null);
  }

  Get.back();
}
