import 'package:flutter/services.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pdf/widgets.dart' as pw;

doGenerateTutupKasir({required TutupKasirController controller}) async {
  showCircleDialogLoading();
  try {
    final pdf = pw.Document();

    DataTutupKasir data = controller.result.data ?? DataTutupKasir();

    // Group data by month and year
    Map<String, List<DetailDataTutupKasir>> groupedData = {};
    Map<String, Map<String, double>> monthlyTotals = {};
    Map<String, double> grandTotals = {
      'totalNilaiBeli': 0,
      'totalNilaiJual': 0,
      'totalKeuntungan': 0,
      'tunai': 0,
      'qris': 0,
      'kredit': 0,
      'total': 0,
      'uangTunai': 0,
    };

    for (var i = 0; i < (data.dataTutupKasir?.length ?? 0); i++) {
      DetailDataTutupKasir? dataDetail = data.dataTutupKasir?[i];
      if (dataDetail?.tgTutupKasir != null) {
        try {
          // Parse the date string (format: "dd-MM-yyyy, HH:mm")
          String dateStr = trimString(dataDetail!.tgTutupKasir);
          String yearMonthKey = '';

          if (dateStr.isNotEmpty && dateStr != '-') {
            // Extract date part only (before comma)
            String datePart = dateStr.split(',')[0].trim();
            List<String> dateParts = datePart.split('-');

            if (dateParts.length == 3) {
              int month = int.parse(dateParts[1]);
              int year = int.parse(dateParts[2]);
              yearMonthKey =
                  '$year-${month.toString().padLeft(2, '0')} - ${getNamaMonth(month)} $year';

              // Initialize monthly totals if not exists
              if (!monthlyTotals.containsKey(yearMonthKey)) {
                monthlyTotals[yearMonthKey] = {
                  'totalNilaiBeli': 0,
                  'totalNilaiJual': 0,
                  'totalKeuntungan': 0,
                  'tunai': 0,
                  'qris': 0,
                  'kredit': 0,
                  'total': 0,
                  'uangTunai': 0,
                };
              }

              // Add to monthly totals
              monthlyTotals[yearMonthKey]!['totalNilaiBeli'] =
                  (monthlyTotals[yearMonthKey]!['totalNilaiBeli'] ?? 0) +
                      (double.tryParse(trimString(dataDetail.totalNilaiBeli)) ?? 0);
              monthlyTotals[yearMonthKey]!['totalNilaiJual'] =
                  (monthlyTotals[yearMonthKey]!['totalNilaiJual'] ?? 0) +
                      (double.tryParse(trimString(dataDetail.totalNilaiJual)) ?? 0);
              monthlyTotals[yearMonthKey]!['totalKeuntungan'] =
                  (monthlyTotals[yearMonthKey]!['totalKeuntungan'] ?? 0) +
                      (double.tryParse(trimString(dataDetail.totalKeuntungan)) ?? 0);
              monthlyTotals[yearMonthKey]!['tunai'] = (monthlyTotals[yearMonthKey]!['tunai'] ?? 0) +
                  (double.tryParse(trimString(dataDetail.tunai)) ?? 0);
              monthlyTotals[yearMonthKey]!['qris'] = (monthlyTotals[yearMonthKey]!['qris'] ?? 0) +
                  (double.tryParse(trimString(dataDetail.qris)) ?? 0);
              monthlyTotals[yearMonthKey]!['kredit'] =
                  (monthlyTotals[yearMonthKey]!['kredit'] ?? 0) +
                      (double.tryParse(trimString(dataDetail.kredit)) ?? 0);
              monthlyTotals[yearMonthKey]!['total'] = (monthlyTotals[yearMonthKey]!['total'] ?? 0) +
                  (double.tryParse(trimString(dataDetail.total)) ?? 0);
              monthlyTotals[yearMonthKey]!['uangTunai'] =
                  (monthlyTotals[yearMonthKey]!['uangTunai'] ?? 0) +
                      (double.tryParse(trimString(dataDetail.uangTunai)) ?? 0);

              // Add to grand totals
              grandTotals['totalNilaiBeli'] = (grandTotals['totalNilaiBeli'] ?? 0) +
                  (double.tryParse(trimString(dataDetail.totalNilaiBeli)) ?? 0);
              grandTotals['totalNilaiJual'] = (grandTotals['totalNilaiJual'] ?? 0) +
                  (double.tryParse(trimString(dataDetail.totalNilaiJual)) ?? 0);
              grandTotals['totalKeuntungan'] = (grandTotals['totalKeuntungan'] ?? 0) +
                  (double.tryParse(trimString(dataDetail.totalKeuntungan)) ?? 0);
              grandTotals['tunai'] = (grandTotals['tunai'] ?? 0) +
                  (double.tryParse(trimString(dataDetail.tunai)) ?? 0);
              grandTotals['qris'] =
                  (grandTotals['qris'] ?? 0) + (double.tryParse(trimString(dataDetail.qris)) ?? 0);
              grandTotals['kredit'] = (grandTotals['kredit'] ?? 0) +
                  (double.tryParse(trimString(dataDetail.kredit)) ?? 0);
              grandTotals['total'] = (grandTotals['total'] ?? 0) +
                  (double.tryParse(trimString(dataDetail.total)) ?? 0);
              grandTotals['uangTunai'] = (grandTotals['uangTunai'] ?? 0) +
                  (double.tryParse(trimString(dataDetail.uangTunai)) ?? 0);
            }
          }

          if (yearMonthKey.isEmpty) {
            yearMonthKey = 'Tanggal Tidak Valid';
          }

          if (!groupedData.containsKey(yearMonthKey)) {
            groupedData[yearMonthKey] = [];
          }
          groupedData[yearMonthKey]!.add(dataDetail);
        } catch (e) {
          // If date parsing fails, group under "Tanggal Tidak Valid"
          String fallbackKey = 'Tanggal Tidak Valid';
          if (!groupedData.containsKey(fallbackKey)) {
            groupedData[fallbackKey] = [];
          }
          groupedData[fallbackKey]!.add(dataDetail!);
        }
      }
    }

    // Sort months chronologically
    List<String> sortedMonths = groupedData.keys.toList();
    sortedMonths.sort((a, b) {
      if (a == 'Tanggal Tidak Valid') return 1;
      if (b == 'Tanggal Tidak Valid') return -1;
      return a.compareTo(b);
    });

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
                  pw.SizedBox(height: 8),
                ],
              ),
          build: (pw.Context context) {
            List<pw.Widget> pdfContent = [];

            // Generate content for each month
            for (String monthKey in sortedMonths) {
              List<DetailDataTutupKasir> monthData = groupedData[monthKey]!;

              // Add month separator
              if (monthKey != 'Tanggal Tidak Valid') {
                pdfContent.add(
                  pw.Container(
                    width: double.infinity,
                    padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    margin: const pw.EdgeInsets.only(bottom: 8),
                    decoration: pw.BoxDecoration(
                      color: const PdfColor.fromInt(0xFF017260),
                      borderRadius: pw.BorderRadius.circular(4),
                    ),
                    child: pw.Text(
                      monthKey.split(' - ').length > 1 ? monthKey.split(' - ')[1] : monthKey,
                      style: pw.TextStyle(
                        font: boldFont,
                        color: PdfColors.white,
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                );
              }

              // Convert month data to table format
              List<List<String>> monthRows = monthData
                  .map((dataDetail) => [
                        trimString(dataDetail.tgTutupKasir),
                        trimString(dataDetail.shift),
                        trimString(dataDetail.namaKasir),
                        formatMoney(trimString(dataDetail.totalNilaiBeli)),
                        formatMoney(trimString(dataDetail.totalNilaiJual)),
                        formatMoney(trimString(dataDetail.totalKeuntungan)),
                        formatMoney(trimString(dataDetail.tunai)),
                        formatMoney(trimString(dataDetail.qris)),
                        formatMoney(trimString(dataDetail.kredit)),
                        formatMoney(trimString(dataDetail.total)),
                        formatMoney(trimString(dataDetail.uangTunai)),
                      ].cast<String>())
                  .toList();

              // Add table for this month
              pdfContent.add(
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
                  data: monthRows,
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
              );

              // Add monthly total if we have valid totals for this month
              if (monthlyTotals.containsKey(monthKey)) {
                Map<String, double> totals = monthlyTotals[monthKey]!;
                pdfContent.add(
                  pw.Container(
                    margin: const pw.EdgeInsets.symmetric(vertical: 4),
                    child: pw.TableHelper.fromTextArray(
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
                      },
                      data: [
                        [
                          'TOTAL BULAN INI',
                          formatMoney(totals['totalNilaiBeli']!.toInt().toString()),
                          formatMoney(totals['totalNilaiJual']!.toInt().toString()),
                          formatMoney(totals['totalKeuntungan']!.toInt().toString()),
                          formatMoney(totals['tunai']!.toInt().toString()),
                          formatMoney(totals['qris']!.toInt().toString()),
                          formatMoney(totals['kredit']!.toInt().toString()),
                          formatMoney(totals['total']!.toInt().toString()),
                          formatMoney(totals['uangTunai']!.toInt().toString()),
                        ],
                      ],
                      border:
                          pw.TableBorder.all(color: const PdfColor.fromInt(0xFF017260), width: 1.5),
                      headerStyle: pw.TextStyle(
                        font: regularFont,
                        fontSize: 8,
                        fontWeight: pw.FontWeight.bold,
                      ),
                      cellStyle: pw.TextStyle(
                        font: regularFont,
                        fontSize: 8,
                        fontWeight: pw.FontWeight.bold,
                      ),
                      cellHeight: 12,
                      columnWidths: {
                        0: const pw.FlexColumnWidth(5),
                        1: const pw.FlexColumnWidth(2),
                        2: const pw.FlexColumnWidth(2),
                        3: const pw.FlexColumnWidth(2),
                        4: const pw.FlexColumnWidth(2),
                        5: const pw.FlexColumnWidth(2),
                        6: const pw.FlexColumnWidth(2),
                        7: const pw.FlexColumnWidth(2),
                        8: const pw.FlexColumnWidth(2),
                      },
                    ),
                  ),
                );
              }

              // Add spacing between months
              pdfContent.add(pw.SizedBox(height: 16));
            }

            // Add grand total at the end
            pdfContent.add(
              pw.Container(
                margin: const pw.EdgeInsets.only(top: 8),
                child: pw.TableHelper.fromTextArray(
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
                  },
                  data: [
                    [
                      'TOTAL KESELURUHAN',
                      formatMoney(grandTotals['totalNilaiBeli']!.toInt().toString()),
                      formatMoney(grandTotals['totalNilaiJual']!.toInt().toString()),
                      formatMoney(grandTotals['totalKeuntungan']!.toInt().toString()),
                      formatMoney(grandTotals['tunai']!.toInt().toString()),
                      formatMoney(grandTotals['qris']!.toInt().toString()),
                      formatMoney(grandTotals['kredit']!.toInt().toString()),
                      formatMoney(grandTotals['total']!.toInt().toString()),
                      formatMoney(grandTotals['uangTunai']!.toInt().toString()),
                    ],
                  ],
                  border: pw.TableBorder.all(color: const PdfColor.fromInt(0xFF017260), width: 2),
                  headerStyle: pw.TextStyle(
                    font: regularFont,
                    fontSize: 8,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  cellHeight: 14,
                  columnWidths: {
                    0: const pw.FlexColumnWidth(5),
                    1: const pw.FlexColumnWidth(2),
                    2: const pw.FlexColumnWidth(2),
                    3: const pw.FlexColumnWidth(2),
                    4: const pw.FlexColumnWidth(2),
                    5: const pw.FlexColumnWidth(2),
                    6: const pw.FlexColumnWidth(2),
                    7: const pw.FlexColumnWidth(2),
                    8: const pw.FlexColumnWidth(2),
                  },
                ),
              ),
            );

            return pdfContent;
          }),
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
