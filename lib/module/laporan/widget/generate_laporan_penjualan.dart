import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pdf/widgets.dart' as pw;

doGenerateLaporanPenjualan({required LaporanController controller}) async {
  showCircleDialogLoading();
  try {
    // Validasi data
    if (controller.resultPenjualan.data?.data == null ||
        controller.resultPenjualan.data!.data!.isEmpty) {
      Get.back();
      showInfoDialog("Tidak ada data untuk dicetak", null);
      return;
    }

    final pdf = pw.Document();

    final ttfBold = await rootBundle.load("assets/fonts/Roboto-Bold.ttf");
    final ttfRegular = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");

    final boldFont = pw.Font.ttf(ttfBold);
    final regularFont = pw.Font.ttf(ttfRegular);

    // Format dates for display
    String formatDate(DateTime date) =>
        "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";

    String startDate = controller.dates.isNotEmpty && controller.dates[0] != null
        ? formatDate(controller.dates[0]!)
        : formatDate(DateTime(controller.yearNow, controller.monthNow, 1));
    String endDate = controller.dates.length > 1 && controller.dates[1] != null
        ? formatDate(controller.dates[1]!)
        : formatDate(DateTime(controller.yearNow, controller.monthNow, 1));

    String metodePembayaran = controller.selectedMetodePembayaran == "SEMUA"
        ? "SEMUA METODE PEMBAYARAN"
        : controller.selectedMetodePembayaran;

    // Calculate totals
    double totalJumlah = 0;
    double totalModal = 0;
    double totalHasilPenjualan = 0;
    double totalKeuntungan = 0;

    if (controller.resultPenjualan.data?.data != null) {
      for (var item in controller.resultPenjualan.data!.data!) {
        totalJumlah += item.jumlah ?? 0;
        totalModal += item.modal ?? 0;
        totalHasilPenjualan += item.hasilPenjualan ?? 0;
        totalKeuntungan += item.keuntungan ?? 0;
      }
    }

    double totalPersentase = totalModal > 0 ? (totalKeuntungan / totalModal) * 100 : 0;

    // Prepare data untuk table
    List<List<String>> tableData = [];

    // Add data rows
    if (controller.resultPenjualan.data?.data != null) {
      for (var item in controller.resultPenjualan.data!.data!) {
        tableData.add([
          item.produk?.toString() ?? '',
          item.metodePembayaran?.toString() ?? '',
          formatMoneyDouble(item.jumlah?.toInt() ?? 0),
          formatMoneyDouble(item.modal?.toInt() ?? 0),
          formatMoneyDouble(item.hasilPenjualan?.toInt() ?? 0),
          formatMoneyDouble(item.keuntungan?.toInt() ?? 0),
          '${(item.persentase ?? 0).toStringAsFixed(1)}%',
        ]);
      }
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        header: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Center(
              child: pw.Text(
                "LAPORAN PENJUALAN",
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  font: boldFont,
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Center(
              child: pw.Text(
                'Periode: $startDate s/d $endDate',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  font: boldFont,
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Center(
              child: pw.Text(
                'Metode Pembayaran: $metodePembayaran',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  font: regularFont,
                  fontSize: 10,
                ),
              ),
            ),
            pw.SizedBox(height: 16),
          ],
        ),
        build: (pw.Context context) => [
          pw.Table(
            border: pw.TableBorder.all(),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(2.5),
              4: const pw.FlexColumnWidth(2.5),
              5: const pw.FlexColumnWidth(2.5),
              6: const pw.FlexColumnWidth(1.5),
            },
            children: [
              // Header row
              pw.TableRow(
                decoration: const pw.BoxDecoration(
                  color: PdfColor.fromInt(0xFF017260),
                ),
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text(
                      'PRODUK',
                      style: pw.TextStyle(
                        font: boldFont,
                        color: PdfColors.white,
                        fontSize: 10,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text(
                      'METODE\nPEMBAYARAN',
                      style: pw.TextStyle(
                        font: boldFont,
                        color: PdfColors.white,
                        fontSize: 10,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text(
                      'JUMLAH',
                      style: pw.TextStyle(
                        font: boldFont,
                        color: PdfColors.white,
                        fontSize: 10,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text(
                      'MODAL',
                      style: pw.TextStyle(
                        font: boldFont,
                        color: PdfColors.white,
                        fontSize: 10,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text(
                      'HASIL\nPENJUALAN',
                      style: pw.TextStyle(
                        font: boldFont,
                        color: PdfColors.white,
                        fontSize: 10,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text(
                      'KEUNTUNGAN',
                      style: pw.TextStyle(
                        font: boldFont,
                        color: PdfColors.white,
                        fontSize: 10,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text(
                      '%',
                      style: pw.TextStyle(
                        font: boldFont,
                        color: PdfColors.white,
                        fontSize: 10,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ],
              ),
              // Data rows
              ...tableData.asMap().entries.map((entry) {
                int index = entry.key;
                List<String> row = entry.value;
                String produk = row[0];

                // Determine background color
                pw.BoxDecoration? decoration;
                pw.TextStyle textStyle = pw.TextStyle(
                  font: regularFont,
                  fontSize: 9,
                );

                // Check for TOTAL PENJUALAN in product name (case insensitive)
                if (produk.toUpperCase().contains("TOTAL PENJUALAN") ||
                    produk.toUpperCase().contains("TOTAL") &&
                        produk.toUpperCase().contains("PENJUALAN")) {
                  // Dark background for TOTAL PENJUALAN rows - using darker gray
                  decoration = const pw.BoxDecoration(
                    color: PdfColors.grey200, // Gray-400 (darker)
                  );
                  textStyle = pw.TextStyle(
                    font: boldFont,
                    fontSize: 9,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.black,
                  );
                } else if (index % 2 == 1) {
                  // Zebra striping for odd rows
                  decoration = const pw.BoxDecoration(
                    color: PdfColor.fromInt(0xFFF5F5F5),
                  );
                }

                return pw.TableRow(
                  decoration: decoration,
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        row[0],
                        style: textStyle,
                        textAlign: pw.TextAlign.left,
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        row[1],
                        style: textStyle,
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        row[2],
                        style: textStyle,
                        textAlign: pw.TextAlign.right,
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        row[3],
                        style: textStyle,
                        textAlign: pw.TextAlign.right,
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        row[4],
                        style: textStyle,
                        textAlign: pw.TextAlign.right,
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        row[5],
                        style: textStyle,
                        textAlign: pw.TextAlign.right,
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        row[6],
                        style: textStyle,
                        textAlign: pw.TextAlign.right,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ],
        footer: (pw.Context context) => pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'Dicetak pada: ${formatDate(DateTime.now())}',
              style: pw.TextStyle(
                font: regularFont,
                fontSize: 8,
                color: PdfColors.grey700,
              ),
            ),
            pw.Text(
              'Halaman ${context.pageNumber} dari ${context.pagesCount}',
              style: pw.TextStyle(
                font: regularFont,
                fontSize: 8,
                color: PdfColors.grey700,
              ),
            ),
          ],
        ),
      ),
    );

    Uint8List pdfData = await pdf.save();

    String fileName =
        'Laporan_Penjualan_${startDate.replaceAll('-', '_')}_${endDate.replaceAll('-', '_')}.pdf';

    await Printing.layoutPdf(
      format: PdfPageFormat.a4,
      name: fileName,
      onLayout: (PdfPageFormat format) async => pdfData,
    );
  } catch (e) {
    Get.back();
    print("Error generating PDF: $e"); // Debug print
    showInfoDialog("Error saat membuat PDF: ${e.toString()}", null);
    return;
  }

  Get.back();
}
