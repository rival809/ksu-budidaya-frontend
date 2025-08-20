import 'package:flutter/services.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pdf/widgets.dart' as pw;

doGenerateLaporanPembelian({required PembelianController controller}) async {
  showCircleDialogLoading();
  try {
    final pdf = pw.Document();

    DataPembelian data = controller.result.data ?? DataPembelian();

    List<RowDataPembelian> rows = [];
    double totalHargaBeli = 0;
    double totalHargaJual = 0;

    for (var i = 0; i < (data.dataPembelian?.length ?? 0); i++) {
      DetailDataPembelian? dataDetail = data.dataPembelian?[i];
      rows.add(
        RowDataPembelian(
          tgPembelian: dataDetail?.tgPembelian,
          idPembelian: dataDetail?.idPembelian,
          nmSupplier: dataDetail?.nmSupplier,
          jumlah: dataDetail?.jumlah,
          totalHargaBeli: dataDetail?.totalHargaBeli,
          totalHargaJual: dataDetail?.totalHargaJual,
          jenisPembayaran: dataDetail?.jenisPembayaran,
          keterangan: dataDetail?.keterangan,
        ),
      );

      // Hitung total
      totalHargaBeli += double.parse(dataDetail?.totalHargaBeli ?? "0");
      totalHargaJual += double.parse(dataDetail?.totalHargaJual ?? "0");
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
            pageFormat:
                PdfPageFormat(29.7 * cm, 21.0 * cm, marginAll: 1.0 * cm),
            margin: pw.EdgeInsets.all(8),
          ),
          header: (pw.Context context) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Center(
                    child: pw.Text(
                      "LAPORAN DATA PEMBELIAN",
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
                    7: pw.Alignment.center,
                  },
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerLeft,
                    2: pw.Alignment.centerLeft,
                    3: pw.Alignment.centerRight,
                    4: pw.Alignment.centerRight,
                    5: pw.Alignment.centerRight,
                    6: pw.Alignment.centerLeft,
                    7: pw.Alignment.centerLeft,
                  },
                  headers: [
                    'Tanggal Pembelian',
                    'ID Pembelian',
                    'Nama Supplier',
                    'Jumlah',
                    'Total Harga Beli',
                    'Total Harga Jual',
                    'Jenis Pembayaran',
                    'Keterangan',
                  ],
                  data: [
                    // Data rows
                    ...rows
                        .map((row) => [
                              trimString(row.tgPembelian),
                              trimString(row.idPembelian),
                              trimString(row.nmSupplier),
                              trimString(row.jumlah.toString()),
                              formatMoney(trimString(row.totalHargaBeli)),
                              formatMoney(trimString(row.totalHargaJual)),
                              trimString(row.jenisPembayaran),
                              trimString(row.keterangan),
                            ])
                        .toList(),
                    // Total row
                    [
                      'TOTAL',
                      '',
                      '',
                      '',
                      formatMoney(totalHargaBeli.toString()),
                      formatMoney(totalHargaJual.toString()),
                      '',
                      '',
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
                    0: const pw.FlexColumnWidth(2),
                    1: const pw.FlexColumnWidth(2),
                    2: const pw.FlexColumnWidth(3),
                    3: const pw.FlexColumnWidth(1.5),
                    4: const pw.FlexColumnWidth(2),
                    5: const pw.FlexColumnWidth(2),
                    6: const pw.FlexColumnWidth(2),
                    7: const pw.FlexColumnWidth(3),
                  },
                ),
              ]),
    );
    Uint8List pdfData = await pdf.save();

    String fileName = 'Laporan_Data_Pembelian.pdf';

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

class RowDataPembelian {
  final String? tgPembelian;
  final String? idPembelian;
  final String? nmSupplier;
  final int? jumlah;
  final String? totalHargaBeli;
  final String? totalHargaJual;
  final String? jenisPembayaran;
  final String? keterangan;

  RowDataPembelian({
    this.tgPembelian,
    this.idPembelian,
    this.nmSupplier,
    this.jumlah,
    this.totalHargaBeli,
    this.totalHargaJual,
    this.jenisPembayaran,
    this.keterangan,
  });
}
