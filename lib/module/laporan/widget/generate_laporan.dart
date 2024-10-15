import 'package:flutter/services.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pdf/widgets.dart' as pw;

doGenerateLaporanHasilUsaha({required LaporanController controller}) async {
  showCircleDialogLoading();
  try {
    final pdf = pw.Document();

    DataLaporanHasilUsaha data =
        controller.resultHasilUsaha.data ?? DataLaporanHasilUsaha();

    List<RowLaporanHasilUsaha> rows = [
      RowLaporanHasilUsaha(
        no: "A",
        uraian: "PENJUALAN",
        currentMonth: null,
        lastMonth: null,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "TUNAI",
        currentMonth: data.penjualan?.currentMonthCashSale,
        lastMonth: data.penjualan?.lastMonthCashSale,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "KREDIT",
        currentMonth: data.penjualan?.currentMonthCreditSale,
        lastMonth: data.penjualan?.lastMonthCreditSale,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "QRIS",
        currentMonth: data.penjualan?.currentMonthQrisSale,
        lastMonth: data.penjualan?.lastMonthQrisSale,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "TOTAL",
        currentMonth: data.penjualan?.totalCurrentMonthSale,
        lastMonth: data.penjualan?.totalLastMonthSale,
      ),
      RowLaporanHasilUsaha(),
      //B
      RowLaporanHasilUsaha(
        no: "B",
        uraian: "HARGA POKOK PENJUALAN",
        currentMonth: null,
        lastMonth: null,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "PERSEDIAAN AWAL",
        currentMonth: data.hargaPokokPenjualan?.persediaanAwal,
        lastMonth: data.hargaPokokPenjualan?.persediaanAwalLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "PEMBELIAN TUNAI",
        currentMonth: data.hargaPokokPenjualan?.pembelianTunai,
        lastMonth: data.hargaPokokPenjualan?.pembelianTunaiLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "PEMBELIAN KREDIT",
        currentMonth: data.hargaPokokPenjualan?.pembelianKredit,
        lastMonth: data.hargaPokokPenjualan?.pembelianKreditLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "RETUR PEMBELIAN",
        currentMonth: data.hargaPokokPenjualan?.retur,
        lastMonth: data.hargaPokokPenjualan?.returLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "PEMBELIAN BERSIH",
        currentMonth: data.hargaPokokPenjualan?.pembelianBersih,
        lastMonth: data.hargaPokokPenjualan?.pembelianBersihLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "BARANG SIAP JUAL",
        currentMonth: data.hargaPokokPenjualan?.barangSiapJual,
        lastMonth: data.hargaPokokPenjualan?.barangSiapJualLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "PERSEDIAAN AKHIR",
        currentMonth: data.hargaPokokPenjualan?.persediaanAkhir,
        lastMonth: data.hargaPokokPenjualan?.persediaanAkhirLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "HARGA POKOK PENJUALAN",
        currentMonth: data.hargaPokokPenjualan?.hargaPokokPenjualan,
        lastMonth: data.hargaPokokPenjualan?.hargaPokokPenjualanLastMonth,
      ),
      RowLaporanHasilUsaha(),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "HASIL USAHA KOTOR",
        currentMonth: data.hargaPokokPenjualan?.hasilUsahaKotor,
        lastMonth: data.hargaPokokPenjualan?.hasilUsahaKotorLastMonth,
      ),
      RowLaporanHasilUsaha(),
      //C
      RowLaporanHasilUsaha(
        no: "C",
        uraian: "BEBAN OPERASIONAL",
        currentMonth: null,
        lastMonth: null,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "BEBAN GAJI/INSENTIF",
        currentMonth: data.bebanOperasional?.bebanGaji,
        lastMonth: data.bebanOperasional?.bebanGajiLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "UANG MAKAN KARYAWAN",
        currentMonth: data.bebanOperasional?.uangMakan,
        lastMonth: data.bebanOperasional?.uangMakanLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "THR KARYAWAN",
        currentMonth: data.bebanOperasional?.thrKaryawan,
        lastMonth: data.bebanOperasional?.thrKaryawanLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "BEBAN ADM. & UMUM",
        currentMonth: data.bebanOperasional?.bebanAdm,
        lastMonth: data.bebanOperasional?.bebanAdmLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "BEBAN PERLENGKAPAN",
        currentMonth: data.bebanOperasional?.bebanPerlengkapan,
        lastMonth: data.bebanOperasional?.bebanPerlengkapanLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "BEBAN PENY. INVENTARIS",
        currentMonth: data.bebanOperasional?.bebanPenyInventaris,
        lastMonth: data.bebanOperasional?.bebanPenyInventarisLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "BEBAN PENY. GEDUNG",
        currentMonth: data.bebanOperasional?.bebanPenyGedung,
        lastMonth: data.bebanOperasional?.bebanPenyGedungLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "PEMELIHARAAN INVENTARIS",
        currentMonth: data.bebanOperasional?.pemeliharaanInventaris,
        lastMonth: data.bebanOperasional?.pemeliharaanInventarisLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "PEMELIHARAAN GEDUNG",
        currentMonth: data.bebanOperasional?.pemeliharaanGedung,
        lastMonth: data.bebanOperasional?.pemeliharaanGedungLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "PENGELUARAN LAIN-LAIN",
        currentMonth: data.bebanOperasional?.pengeluaranLain,
        lastMonth: data.bebanOperasional?.pengeluaranLainLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "TOTAL BEBAN OPERASIONAL",
        currentMonth: data.bebanOperasional?.totalBebanOperasional,
        lastMonth: data.bebanOperasional?.totalBebanOperasionalLastMonth,
      ),
      RowLaporanHasilUsaha(),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "HASIL USAHA BERSIH",
        currentMonth: data.bebanOperasional?.hasilUsahaBersih,
        lastMonth: data.bebanOperasional?.hasilUsahaBersihLastMonth,
      ),
      RowLaporanHasilUsaha(),
      //D
      RowLaporanHasilUsaha(
        no: "D",
        uraian: "PENDAPATAN LAIN-LAIN",
        currentMonth: null,
        lastMonth: null,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "TENANT",
        currentMonth: data.pendapatanLain?.tenant,
        lastMonth: data.pendapatanLain?.tenantLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "PENDAPATAN LAIN-LAIN",
        currentMonth: data.pendapatanLain?.lainLain,
        lastMonth: data.pendapatanLain?.lainLainLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "TOTAL PENDAPATAN LAIN-LAIN",
        currentMonth: data.pendapatanLain?.totalPendapatanLain,
        lastMonth: data.pendapatanLain?.totalPendapatanLainLastMonth,
      ),
      RowLaporanHasilUsaha(),
      //E
      RowLaporanHasilUsaha(
        no: "E",
        uraian: "Sisa Hasil Usaha",
        currentMonth: data.sisaHasilUsaha?.sisaHasilUsaha,
        lastMonth: data.sisaHasilUsaha?.sisaHasilUsahaLastMonth,
      ),
    ];

    final ttfBold = await rootBundle.load("assets/fonts/Roboto-Bold.ttf");
    final ttfRegular = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");

    final boldFont = pw.Font.ttf(ttfBold);
    final regularFont = pw.Font.ttf(ttfRegular);

    pdf.addPage(
      pw.MultiPage(
          pageTheme: const pw.PageTheme(
            pageFormat: PdfPageFormat.a4,
            margin: pw.EdgeInsets.all(16),
          ),
          header: (pw.Context context) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Center(
                    child: pw.Text(
                      "LAPORAN HASIL USAHA",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: boldFont,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 16),
                  pw.Center(
                    child: pw.Text(
                      '${getNamaMonth(controller.monthNow)} - ${controller.yearNow}',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: boldFont,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 16),
                ],
              ),
          build: (pw.Context context) => [
                pw.TableHelper.fromTextArray(
                  headerAlignments: {
                    0: pw.Alignment.center,
                    1: pw.Alignment.center,
                    2: pw.Alignment.center,
                    3: pw.Alignment.center,
                  },
                  cellAlignments: {
                    0: pw.Alignment.center,
                    1: pw.Alignment.centerLeft,
                    2: pw.Alignment.centerRight,
                    3: pw.Alignment.centerRight,
                  },
                  headers: [
                    'No.',
                    'URAIAN',
                    '${getNamaMonth(controller.monthNow)}\n${controller.yearNow}',
                    subtractTitleOneMonth(
                        controller.monthNow, controller.yearNow)
                  ],
                  data: rows
                      .map((row) => [
                            row.no ?? '',
                            row.uraian ?? '',
                            formatMoney(row.currentMonth?.toString() ?? ''),
                            formatMoney(row.lastMonth?.toString() ?? '')
                          ])
                      .toList(),
                  border: pw.TableBorder.all(),
                  headerStyle: pw.TextStyle(
                    font: boldFont,
                    color: PdfColors.white,
                    fontSize: 14,
                  ),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColor.fromInt(0xFF017260),
                  ),
                  cellStyle: pw.TextStyle(
                    font: regularFont,
                    fontSize: 12,
                  ),
                  cellHeight: 30,
                  columnWidths: {
                    0: const pw.FlexColumnWidth(1),
                    1: const pw.FlexColumnWidth(2),
                    2: const pw.FlexColumnWidth(1),
                    3: const pw.FlexColumnWidth(1),
                  },
                ),
              ]),
    );
    Uint8List pdfData = await pdf.save();

    String fileName =
        'Laporan_Hasil_Usaha_${controller.monthNow}_${controller.yearNow}.pdf';

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
