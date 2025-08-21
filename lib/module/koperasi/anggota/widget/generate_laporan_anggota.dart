import 'package:flutter/services.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pdf/widgets.dart' as pw;

doGenerateLaporanAnggota({required AnggotaController controller}) async {
  showCircleDialogLoading();
  try {
    final pdf = pw.Document();

    DataAnggota data = controller.result.data ?? DataAnggota();

    List<RowDataAnggota> rows = [];
    double totalNominalTransaksi = 0;
    double totalHutang = 0;

    for (var i = 0; i < (data.dataAnggota?.length ?? 0); i++) {
      DataDetailAnggota? dataDetail = data.dataAnggota?[i];
      rows.add(
        RowDataAnggota(
          idAnggota: dataDetail?.idAnggota,
          nmAnggota: dataDetail?.nmAnggota,
          alamat: dataDetail?.alamat,
          noWa: dataDetail?.noWa,
          totalNominalTransaksi: dataDetail?.totalNominalTransaksi,
          limitPinjaman: dataDetail?.limitPinjaman,
          hutang: dataDetail?.hutang,
        ),
      );

      // Hitung total
      totalNominalTransaksi += double.parse(dataDetail?.totalNominalTransaksi ?? "0");
      totalHutang += double.parse(dataDetail?.hutang ?? "0");
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
                      "LAPORAN DATA ANGGOTA KOPERASI",
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
                  },
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerLeft,
                    2: pw.Alignment.centerLeft,
                    3: pw.Alignment.centerLeft,
                    4: pw.Alignment.centerRight,
                    5: pw.Alignment.centerRight,
                    6: pw.Alignment.centerRight,
                  },
                  headers: [
                    'ID Anggota',
                    'Nama Anggota',
                    'Alamat',
                    'No WhatsApp',
                    'Total Nominal Transaksi',
                    'Limit Pinjaman',
                    'Hutang',
                  ],
                  data: [
                    // Data rows
                    ...rows
                        .map((row) => [
                              trimString(row.idAnggota),
                              trimString(row.nmAnggota),
                              trimString(row.alamat),
                              trimString(row.noWa),
                              formatMoney(trimString(row.totalNominalTransaksi)),
                              formatMoney(trimString(row.limitPinjaman)),
                              formatMoney(trimString(row.hutang)),
                            ])
                        .toList(),
                    // Total row
                    [
                      'TOTAL',
                      '',
                      '',
                      '',
                      formatMoney(totalNominalTransaksi.toString()),
                      '',
                      formatMoney(totalHutang.toString()),
                    ],
                  ],
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
                  oddRowDecoration: const pw.BoxDecoration(
                    color: PdfColor.fromInt(0xFFF5F5F5),
                  ),
                  cellHeight: 12,
                  columnWidths: {
                    0: const pw.FlexColumnWidth(1.5),
                    1: const pw.FlexColumnWidth(3),
                    2: const pw.FlexColumnWidth(4),
                    3: const pw.FlexColumnWidth(2),
                    4: const pw.FlexColumnWidth(2.5),
                    5: const pw.FlexColumnWidth(2),
                    6: const pw.FlexColumnWidth(2),
                  },
                ),
              ]),
    );
    Uint8List pdfData = await pdf.save();

    String fileName = 'Laporan_Data_Anggota_Koperasi.pdf';

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

class RowDataAnggota {
  final String? idAnggota;
  final String? nmAnggota;
  final String? alamat;
  final String? noWa;
  final String? totalNominalTransaksi;
  final String? limitPinjaman;
  final String? hutang;

  RowDataAnggota({
    this.idAnggota,
    this.nmAnggota,
    this.alamat,
    this.noWa,
    this.totalNominalTransaksi,
    this.limitPinjaman,
    this.hutang,
  });
}
