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
        uraian: "Penjualan",
        currentMonth: null,
        lastMonth: null,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Penjualan Tunai",
        currentMonth: data.penjualan?.currentMonthCashSale,
        lastMonth: data.penjualan?.lastMonthCashSale,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Penjualan Kredit",
        currentMonth: data.penjualan?.currentMonthCreditSale,
        lastMonth: data.penjualan?.lastMonthCreditSale,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Penjualan QRIS",
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
        uraian: "Harga Pokok Penjualan",
        currentMonth: null,
        lastMonth: null,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Persediaan Awal",
        currentMonth: data.hargaPokokPenjualan?.persediaanAwal,
        lastMonth: data.hargaPokokPenjualan?.persediaanAwalLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Pembelian Tunai",
        currentMonth: data.hargaPokokPenjualan?.pembelianTunai,
        lastMonth: data.hargaPokokPenjualan?.pembelianTunaiLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Pembelian Kredit",
        currentMonth: data.hargaPokokPenjualan?.pembelianKredit,
        lastMonth: data.hargaPokokPenjualan?.pembelianKreditLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Pembelian Bersih",
        currentMonth: data.hargaPokokPenjualan?.pembelianBersih,
        lastMonth: data.hargaPokokPenjualan?.pembelianBersihLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Barang Siap Jual",
        currentMonth: data.hargaPokokPenjualan?.barangSiapJual,
        lastMonth: data.hargaPokokPenjualan?.barangSiapJualLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Persediaan Akhir",
        currentMonth: data.hargaPokokPenjualan?.persediaanAkhir,
        lastMonth: data.hargaPokokPenjualan?.persediaanAkhirLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Harga Pokok Penjualan",
        currentMonth: data.hargaPokokPenjualan?.hargaPokokPenjualan,
        lastMonth: data.hargaPokokPenjualan?.hargaPokokPenjualanLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Hasil Usaha Kotor",
        currentMonth: data.hargaPokokPenjualan?.hasilUsahaKotor,
        lastMonth: data.hargaPokokPenjualan?.hasilUsahaKotorLastMonth,
      ),
      RowLaporanHasilUsaha(),
      //C
      RowLaporanHasilUsaha(
        no: "C",
        uraian: "Beban Operasional",
        currentMonth: null,
        lastMonth: null,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Beban Gaji/ Insentif",
        currentMonth: data.bebanOperasional?.bebanGaji,
        lastMonth: data.bebanOperasional?.bebanGajiLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Uang Makan Karyawan",
        currentMonth: data.bebanOperasional?.uangMakan,
        lastMonth: data.bebanOperasional?.uangMakanLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "THR Karyawan",
        currentMonth: data.bebanOperasional?.thrKaryawan,
        lastMonth: data.bebanOperasional?.thrKaryawanLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Tunjangan Pangan",
        currentMonth: data.bebanOperasional?.tunjanganPangan,
        lastMonth: data.bebanOperasional?.tunjanganPanganLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Beban Adm. & Umum",
        currentMonth: data.bebanOperasional?.bebanAdm,
        lastMonth: data.bebanOperasional?.bebanAdmLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Beban Perlengkapan",
        currentMonth: data.bebanOperasional?.bebanPerlengkapan,
        lastMonth: data.bebanOperasional?.bebanPerlengkapanLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Tunjangan Kesehatan",
        currentMonth: data.bebanOperasional?.tunjanganKesehatan,
        lastMonth: data.bebanOperasional?.tunjanganKesehatanLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Beban Peny. Inventaris",
        currentMonth: data.bebanOperasional?.bebanPenyInventaris,
        lastMonth: data.bebanOperasional?.bebanPenyInventarisLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Beban Peny. Gedung",
        currentMonth: data.bebanOperasional?.bebanPenyGedung,
        lastMonth: data.bebanOperasional?.bebanPenyGedungLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Pemeliharaan Inventaris",
        currentMonth: data.bebanOperasional?.pemeliharaanInventaris,
        lastMonth: data.bebanOperasional?.pemeliharaanInventarisLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Pemeliharaan Gedung",
        currentMonth: data.bebanOperasional?.pemeliharaanGedung,
        lastMonth: data.bebanOperasional?.pemeliharaanGedungLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Pengeluaran Lain-lain",
        currentMonth: data.bebanOperasional?.pengeluaranLain,
        lastMonth: data.bebanOperasional?.pengeluaranLainLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Total Beban Operasional",
        currentMonth: data.bebanOperasional?.bebanOperasional,
        lastMonth: data.bebanOperasional?.bebanOperasionalLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Hasil Usaha Bersih",
        currentMonth: data.bebanOperasional?.hasilUsahaBersih,
        lastMonth: data.bebanOperasional?.hasilUsahaBersihLastMonth,
      ),
      RowLaporanHasilUsaha(),
      //D
      RowLaporanHasilUsaha(
        no: "D",
        uraian: "Pendapatan Lain-lain",
        currentMonth: null,
        lastMonth: null,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Jasa Bank",
        currentMonth: data.pendapatanLain?.penarikanBank,
        lastMonth: data.pendapatanLain?.penarikanBankLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Tenant",
        currentMonth: data.pendapatanLain?.tenant,
        lastMonth: data.pendapatanLain?.tenantLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Pendapatan Lain-lain",
        currentMonth: data.pendapatanLain?.lainLain,
        lastMonth: data.pendapatanLain?.lainLainLastMonth,
      ),
      RowLaporanHasilUsaha(
        no: "",
        uraian: "Total Pendapatan Lain-Lain",
        currentMonth: data.pendapatanLain?.pendapatanLain,
        lastMonth: data.pendapatanLain?.pendapatanLainLastMonth,
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
          header: (pw.Context context) => pw.Center(
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
          build: (pw.Context context) => [
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
