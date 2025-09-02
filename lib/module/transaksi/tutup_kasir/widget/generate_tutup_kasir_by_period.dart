import 'package:flutter/services.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pdf/widgets.dart' as pw;

doGenerateTutupKasirByPeriod({
  required TutupKasirController controller,
  required int selectedMonth,
  required int selectedYear,
}) async {
  showCircleDialogLoading();
  try {
    final pdf = pw.Document();

    DataTutupKasir data = controller.result.data ?? DataTutupKasir();

    // Filter data by selected month and year
    List<DetailDataTutupKasir> filteredData = [];
    Map<String, double> periodTotals = {
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

          if (dateStr.isNotEmpty && dateStr != '-') {
            // Extract date part only (before comma)
            String datePart = dateStr.split(',')[0].trim();
            List<String> dateParts = datePart.split('-');

            if (dateParts.length == 3) {
              int month = int.parse(dateParts[1]);
              int year = int.parse(dateParts[2]);

              // Check if this record matches selected period
              if (month == selectedMonth && year == selectedYear) {
                filteredData.add(dataDetail);

                // Add to period totals
                periodTotals['totalNilaiBeli'] = (periodTotals['totalNilaiBeli'] ?? 0) +
                    (double.tryParse(trimString(dataDetail.totalNilaiBeli)) ?? 0);
                periodTotals['totalNilaiJual'] = (periodTotals['totalNilaiJual'] ?? 0) +
                    (double.tryParse(trimString(dataDetail.totalNilaiJual)) ?? 0);
                periodTotals['totalKeuntungan'] = (periodTotals['totalKeuntungan'] ?? 0) +
                    (double.tryParse(trimString(dataDetail.totalKeuntungan)) ?? 0);
                periodTotals['tunai'] = (periodTotals['tunai'] ?? 0) +
                    (double.tryParse(trimString(dataDetail.tunai)) ?? 0);
                periodTotals['qris'] = (periodTotals['qris'] ?? 0) +
                    (double.tryParse(trimString(dataDetail.qris)) ?? 0);
                periodTotals['kredit'] = (periodTotals['kredit'] ?? 0) +
                    (double.tryParse(trimString(dataDetail.kredit)) ?? 0);
                periodTotals['total'] = (periodTotals['total'] ?? 0) +
                    (double.tryParse(trimString(dataDetail.total)) ?? 0);
                periodTotals['uangTunai'] = (periodTotals['uangTunai'] ?? 0) +
                    (double.tryParse(trimString(dataDetail.uangTunai)) ?? 0);
              }
            }
          }
        } catch (e) {
          // Skip invalid dates
        }
      }
    }

    final ttfBold = await rootBundle.load("assets/fonts/Roboto-Bold.ttf");
    final ttfRegular = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");

    final boldFont = pw.Font.ttf(ttfBold);
    final regularFont = pw.Font.ttf(ttfRegular);
    const double inch = 72.0;
    const double cm = inch / 2.54;

    // Convert filtered data to table format
    List<List<String>> tableRows = filteredData
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
                  pw.Center(
                    child: pw.Text(
                      '${getNamaMonth(selectedMonth)} $selectedYear',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: boldFont,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 8),
                ],
              ),
          build: (pw.Context context) {
            List<pw.Widget> pdfContent = [];

            if (filteredData.isEmpty) {
              // No data message
              pdfContent.add(
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.all(20),
                  child: pw.Center(
                    child: pw.Text(
                      'Tidak ada data tutup kasir untuk periode ${getNamaMonth(selectedMonth)} $selectedYear',
                      style: pw.TextStyle(
                        font: regularFont,
                        fontSize: 12,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ),
              );
            } else {
              // Add main table
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
                  data: tableRows,
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

              // Add period total
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
                        'TOTAL ${getNamaMonth(selectedMonth).toUpperCase()} $selectedYear',
                        formatMoney(periodTotals['totalNilaiBeli']!.toInt().toString()),
                        formatMoney(periodTotals['totalNilaiJual']!.toInt().toString()),
                        formatMoney(periodTotals['totalKeuntungan']!.toInt().toString()),
                        formatMoney(periodTotals['tunai']!.toInt().toString()),
                        formatMoney(periodTotals['qris']!.toInt().toString()),
                        formatMoney(periodTotals['kredit']!.toInt().toString()),
                        formatMoney(periodTotals['total']!.toInt().toString()),
                        formatMoney(periodTotals['uangTunai']!.toInt().toString()),
                      ],
                    ],
                    border: pw.TableBorder.all(color: const PdfColor.fromInt(0xFF017260), width: 2),
                    headerStyle: pw.TextStyle(
                      font: boldFont,
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
            }

            return pdfContent;
          }),
    );

    Uint8List pdfData = await pdf.save();

    String fileName = 'Riwayat_Tutup_kasir_${getNamaMonth(selectedMonth)}_$selectedYear.pdf';

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
