import 'package:flutter/services.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pdf/widgets.dart' as pw;

doGenerateLaporanRealisasiPendapatan(
    {required LaporanController controller}) async {
  showCircleDialogLoading();
  try {
    final pdf = pw.Document();

    DataRealisasiPendapatan data =
        controller.resultRealisasiPendapatan.data ?? DataRealisasiPendapatan();

    List<RowLaporanRealisasiPendapatan> rows = [
      RowLaporanRealisasiPendapatan(
        uraian: "PENJUALAN",
        jan: null,
        feb: null,
        mar: null,
        apr: null,
        mei: null,
        jun: null,
        jul: null,
        agu: null,
        sep: null,
        okt: null,
        nov: null,
        des: null,
        jumlah: null,
      ),
      RowLaporanRealisasiPendapatan(
        uraian: "Hasil Usaha Waserda",
        jan: (data.pendapatan?.hasilUsahaWaserda?.data?[0].totalNilaiJual)
            ?.toDouble(),
        feb: (data.pendapatan?.hasilUsahaWaserda?.data?[1].totalNilaiJual)
            ?.toDouble(),
        mar: (data.pendapatan?.hasilUsahaWaserda?.data?[2].totalNilaiJual)
            ?.toDouble(),
        apr: (data.pendapatan?.hasilUsahaWaserda?.data?[3].totalNilaiJual)
            ?.toDouble(),
        mei: (data.pendapatan?.hasilUsahaWaserda?.data?[4].totalNilaiJual)
            ?.toDouble(),
        jun: (data.pendapatan?.hasilUsahaWaserda?.data?[5].totalNilaiJual)
            ?.toDouble(),
        jul: (data.pendapatan?.hasilUsahaWaserda?.data?[6].totalNilaiJual)
            ?.toDouble(),
        agu: (data.pendapatan?.hasilUsahaWaserda?.data?[7].totalNilaiJual)
            ?.toDouble(),
        sep: (data.pendapatan?.hasilUsahaWaserda?.data?[8].totalNilaiJual)
            ?.toDouble(),
        okt: (data.pendapatan?.hasilUsahaWaserda?.data?[9].totalNilaiJual)
            ?.toDouble(),
        nov: (data.pendapatan?.hasilUsahaWaserda?.data?[10].totalNilaiJual)
            ?.toDouble(),
        des: (data.pendapatan?.hasilUsahaWaserda?.data?[11].totalNilaiJual)
            ?.toDouble(),
        jumlah: (data.pendapatan?.hasilUsahaWaserda?.jumlah)?.toDouble(),
      ),
      RowLaporanRealisasiPendapatan(
        uraian: "Pendapatan Lain-lain",
        jan:
            (data.pendapatan?.pendapatanLainlain?.data?[0].nominal)?.toDouble(),
        feb:
            (data.pendapatan?.pendapatanLainlain?.data?[1].nominal)?.toDouble(),
        mar:
            (data.pendapatan?.pendapatanLainlain?.data?[2].nominal)?.toDouble(),
        apr:
            (data.pendapatan?.pendapatanLainlain?.data?[3].nominal)?.toDouble(),
        mei:
            (data.pendapatan?.pendapatanLainlain?.data?[4].nominal)?.toDouble(),
        jun:
            (data.pendapatan?.pendapatanLainlain?.data?[5].nominal)?.toDouble(),
        jul:
            (data.pendapatan?.pendapatanLainlain?.data?[6].nominal)?.toDouble(),
        agu:
            (data.pendapatan?.pendapatanLainlain?.data?[7].nominal)?.toDouble(),
        sep:
            (data.pendapatan?.pendapatanLainlain?.data?[8].nominal)?.toDouble(),
        okt:
            (data.pendapatan?.pendapatanLainlain?.data?[9].nominal)?.toDouble(),
        nov: (data.pendapatan?.pendapatanLainlain?.data?[10].nominal)
            ?.toDouble(),
        des: (data.pendapatan?.pendapatanLainlain?.data?[11].nominal)
            ?.toDouble(),
        jumlah: (data.pendapatan?.pendapatanLainlain?.jumlah)?.toDouble(),
      ),
      RowLaporanRealisasiPendapatan(
        uraian: "Retur Pembelian",
        jan: (data.pendapatan?.returPembelian?.data?[0].totalNilaiBeli)
            ?.toDouble(),
        feb: (data.pendapatan?.returPembelian?.data?[1].totalNilaiBeli)
            ?.toDouble(),
        mar: (data.pendapatan?.returPembelian?.data?[2].totalNilaiBeli)
            ?.toDouble(),
        apr: (data.pendapatan?.returPembelian?.data?[3].totalNilaiBeli)
            ?.toDouble(),
        mei: (data.pendapatan?.returPembelian?.data?[4].totalNilaiBeli)
            ?.toDouble(),
        jun: (data.pendapatan?.returPembelian?.data?[5].totalNilaiBeli)
            ?.toDouble(),
        jul: (data.pendapatan?.returPembelian?.data?[6].totalNilaiBeli)
            ?.toDouble(),
        agu: (data.pendapatan?.returPembelian?.data?[7].totalNilaiBeli)
            ?.toDouble(),
        sep: (data.pendapatan?.returPembelian?.data?[8].totalNilaiBeli)
            ?.toDouble(),
        okt: (data.pendapatan?.returPembelian?.data?[9].totalNilaiBeli)
            ?.toDouble(),
        nov: (data.pendapatan?.returPembelian?.data?[10].totalNilaiBeli)
            ?.toDouble(),
        des: (data.pendapatan?.returPembelian?.data?[11].totalNilaiBeli)
            ?.toDouble(),
        jumlah: (data.pendapatan?.returPembelian?.jumlah)?.toDouble(),
      ),
      RowLaporanRealisasiPendapatan(
        uraian: "JUMLAH",
        jan:
            (data.pendapatan?.totalPendapatanPerBulan?.data?[0].totalPendapatan)
                ?.toDouble(),
        feb:
            (data.pendapatan?.totalPendapatanPerBulan?.data?[1].totalPendapatan)
                ?.toDouble(),
        mar:
            (data.pendapatan?.totalPendapatanPerBulan?.data?[2].totalPendapatan)
                ?.toDouble(),
        apr:
            (data.pendapatan?.totalPendapatanPerBulan?.data?[3].totalPendapatan)
                ?.toDouble(),
        mei:
            (data.pendapatan?.totalPendapatanPerBulan?.data?[4].totalPendapatan)
                ?.toDouble(),
        jun:
            (data.pendapatan?.totalPendapatanPerBulan?.data?[5].totalPendapatan)
                ?.toDouble(),
        jul:
            (data.pendapatan?.totalPendapatanPerBulan?.data?[6].totalPendapatan)
                ?.toDouble(),
        agu:
            (data.pendapatan?.totalPendapatanPerBulan?.data?[7].totalPendapatan)
                ?.toDouble(),
        sep:
            (data.pendapatan?.totalPendapatanPerBulan?.data?[8].totalPendapatan)
                ?.toDouble(),
        okt:
            (data.pendapatan?.totalPendapatanPerBulan?.data?[9].totalPendapatan)
                ?.toDouble(),
        nov: (data
                .pendapatan?.totalPendapatanPerBulan?.data?[10].totalPendapatan)
            ?.toDouble(),
        des: (data
                .pendapatan?.totalPendapatanPerBulan?.data?[11].totalPendapatan)
            ?.toDouble(),
        jumlah: (data.pendapatan?.totalPendapatanPerBulan?.jumlah)?.toDouble(),
      ),
      RowLaporanRealisasiPendapatan(),
      RowLaporanRealisasiPendapatan(
        uraian: "PENGELUARAN",
        jan: null,
        feb: null,
        mar: null,
        apr: null,
        mei: null,
        jun: null,
        jul: null,
        agu: null,
        sep: null,
        okt: null,
        nov: null,
        des: null,
        jumlah: null,
      ),
      RowLaporanRealisasiPendapatan(
        uraian: "Beban Gaji/ Insentif",
        jan: (data.pengeluaran?.bebanGaji?.data?[0].nominal)?.toDouble(),
        feb: (data.pengeluaran?.bebanGaji?.data?[1].nominal)?.toDouble(),
        mar: (data.pengeluaran?.bebanGaji?.data?[2].nominal)?.toDouble(),
        apr: (data.pengeluaran?.bebanGaji?.data?[3].nominal)?.toDouble(),
        mei: (data.pengeluaran?.bebanGaji?.data?[4].nominal)?.toDouble(),
        jun: (data.pengeluaran?.bebanGaji?.data?[5].nominal)?.toDouble(),
        jul: (data.pengeluaran?.bebanGaji?.data?[6].nominal)?.toDouble(),
        agu: (data.pengeluaran?.bebanGaji?.data?[7].nominal)?.toDouble(),
        sep: (data.pengeluaran?.bebanGaji?.data?[8].nominal)?.toDouble(),
        okt: (data.pengeluaran?.bebanGaji?.data?[9].nominal)?.toDouble(),
        nov: (data.pengeluaran?.bebanGaji?.data?[10].nominal)?.toDouble(),
        des: (data.pengeluaran?.bebanGaji?.data?[11].nominal)?.toDouble(),
        jumlah: (data.pengeluaran?.bebanGaji?.jumlah)?.toDouble(),
      ),
      RowLaporanRealisasiPendapatan(
        uraian: "Uang Makan Karyawan",
        jan: (data.pengeluaran?.uangMakan?.data?[0].nominal)?.toDouble(),
        feb: (data.pengeluaran?.uangMakan?.data?[1].nominal)?.toDouble(),
        mar: (data.pengeluaran?.uangMakan?.data?[2].nominal)?.toDouble(),
        apr: (data.pengeluaran?.uangMakan?.data?[3].nominal)?.toDouble(),
        mei: (data.pengeluaran?.uangMakan?.data?[4].nominal)?.toDouble(),
        jun: (data.pengeluaran?.uangMakan?.data?[5].nominal)?.toDouble(),
        jul: (data.pengeluaran?.uangMakan?.data?[6].nominal)?.toDouble(),
        agu: (data.pengeluaran?.uangMakan?.data?[7].nominal)?.toDouble(),
        sep: (data.pengeluaran?.uangMakan?.data?[8].nominal)?.toDouble(),
        okt: (data.pengeluaran?.uangMakan?.data?[9].nominal)?.toDouble(),
        nov: (data.pengeluaran?.uangMakan?.data?[10].nominal)?.toDouble(),
        des: (data.pengeluaran?.uangMakan?.data?[11].nominal)?.toDouble(),
        jumlah: (data.pengeluaran?.uangMakan?.jumlah)?.toDouble(),
      ),
      RowLaporanRealisasiPendapatan(
        uraian: "THR Karyawan",
        jan: (data.pengeluaran?.thr?.data?[0].nominal)?.toDouble(),
        feb: (data.pengeluaran?.thr?.data?[1].nominal)?.toDouble(),
        mar: (data.pengeluaran?.thr?.data?[2].nominal)?.toDouble(),
        apr: (data.pengeluaran?.thr?.data?[3].nominal)?.toDouble(),
        mei: (data.pengeluaran?.thr?.data?[4].nominal)?.toDouble(),
        jun: (data.pengeluaran?.thr?.data?[5].nominal)?.toDouble(),
        jul: (data.pengeluaran?.thr?.data?[6].nominal)?.toDouble(),
        agu: (data.pengeluaran?.thr?.data?[7].nominal)?.toDouble(),
        sep: (data.pengeluaran?.thr?.data?[8].nominal)?.toDouble(),
        okt: (data.pengeluaran?.thr?.data?[9].nominal)?.toDouble(),
        nov: (data.pengeluaran?.thr?.data?[10].nominal)?.toDouble(),
        des: (data.pengeluaran?.thr?.data?[11].nominal)?.toDouble(),
        jumlah: (data.pengeluaran?.thr?.jumlah)?.toDouble(),
      ),
      RowLaporanRealisasiPendapatan(
        uraian: "Beban Adm. & Umum",
        jan: (data.pengeluaran?.bebanAdmUmum?.data?[0].nominal)?.toDouble(),
        feb: (data.pengeluaran?.bebanAdmUmum?.data?[1].nominal)?.toDouble(),
        mar: (data.pengeluaran?.bebanAdmUmum?.data?[2].nominal)?.toDouble(),
        apr: (data.pengeluaran?.bebanAdmUmum?.data?[3].nominal)?.toDouble(),
        mei: (data.pengeluaran?.bebanAdmUmum?.data?[4].nominal)?.toDouble(),
        jun: (data.pengeluaran?.bebanAdmUmum?.data?[5].nominal)?.toDouble(),
        jul: (data.pengeluaran?.bebanAdmUmum?.data?[6].nominal)?.toDouble(),
        agu: (data.pengeluaran?.bebanAdmUmum?.data?[7].nominal)?.toDouble(),
        sep: (data.pengeluaran?.bebanAdmUmum?.data?[8].nominal)?.toDouble(),
        okt: (data.pengeluaran?.bebanAdmUmum?.data?[9].nominal)?.toDouble(),
        nov: (data.pengeluaran?.bebanAdmUmum?.data?[10].nominal)?.toDouble(),
        des: (data.pengeluaran?.bebanAdmUmum?.data?[11].nominal)?.toDouble(),
        jumlah: (data.pengeluaran?.bebanAdmUmum?.jumlah)?.toDouble(),
      ),
      RowLaporanRealisasiPendapatan(
        uraian: "Beban Perlengkapan",
        jan:
            (data.pengeluaran?.bebanPerlengkapan?.data?[0].nominal)?.toDouble(),
        feb:
            (data.pengeluaran?.bebanPerlengkapan?.data?[1].nominal)?.toDouble(),
        mar:
            (data.pengeluaran?.bebanPerlengkapan?.data?[2].nominal)?.toDouble(),
        apr:
            (data.pengeluaran?.bebanPerlengkapan?.data?[3].nominal)?.toDouble(),
        mei:
            (data.pengeluaran?.bebanPerlengkapan?.data?[4].nominal)?.toDouble(),
        jun:
            (data.pengeluaran?.bebanPerlengkapan?.data?[5].nominal)?.toDouble(),
        jul:
            (data.pengeluaran?.bebanPerlengkapan?.data?[6].nominal)?.toDouble(),
        agu:
            (data.pengeluaran?.bebanPerlengkapan?.data?[7].nominal)?.toDouble(),
        sep:
            (data.pengeluaran?.bebanPerlengkapan?.data?[8].nominal)?.toDouble(),
        okt:
            (data.pengeluaran?.bebanPerlengkapan?.data?[9].nominal)?.toDouble(),
        nov: (data.pengeluaran?.bebanPerlengkapan?.data?[10].nominal)
            ?.toDouble(),
        des: (data.pengeluaran?.bebanPerlengkapan?.data?[11].nominal)
            ?.toDouble(),
        jumlah: (data.pengeluaran?.bebanPerlengkapan?.jumlah)?.toDouble(),
      ),
      RowLaporanRealisasiPendapatan(
        uraian: "Beban Peny. Inventaris",
        jan: (data.pengeluaran?.bebanPenyusutanInventaris?.data?[0].nominal)
            ?.toDouble(),
        feb: (data.pengeluaran?.bebanPenyusutanInventaris?.data?[1].nominal)
            ?.toDouble(),
        mar: (data.pengeluaran?.bebanPenyusutanInventaris?.data?[2].nominal)
            ?.toDouble(),
        apr: (data.pengeluaran?.bebanPenyusutanInventaris?.data?[3].nominal)
            ?.toDouble(),
        mei: (data.pengeluaran?.bebanPenyusutanInventaris?.data?[4].nominal)
            ?.toDouble(),
        jun: (data.pengeluaran?.bebanPenyusutanInventaris?.data?[5].nominal)
            ?.toDouble(),
        jul: (data.pengeluaran?.bebanPenyusutanInventaris?.data?[6].nominal)
            ?.toDouble(),
        agu: (data.pengeluaran?.bebanPenyusutanInventaris?.data?[7].nominal)
            ?.toDouble(),
        sep: (data.pengeluaran?.bebanPenyusutanInventaris?.data?[8].nominal)
            ?.toDouble(),
        okt: (data.pengeluaran?.bebanPenyusutanInventaris?.data?[9].nominal)
            ?.toDouble(),
        nov: (data.pengeluaran?.bebanPenyusutanInventaris?.data?[10].nominal)
            ?.toDouble(),
        des: (data.pengeluaran?.bebanPenyusutanInventaris?.data?[11].nominal)
            ?.toDouble(),
        jumlah:
            (data.pengeluaran?.bebanPenyusutanInventaris?.jumlah)?.toDouble(),
      ),
      RowLaporanRealisasiPendapatan(
        uraian: "Beban Peny. Gedung",
        jan: (data.pengeluaran?.bebanPenyusutanGedung?.data?[0].nominal)
            ?.toDouble(),
        feb: (data.pengeluaran?.bebanPenyusutanGedung?.data?[1].nominal)
            ?.toDouble(),
        mar: (data.pengeluaran?.bebanPenyusutanGedung?.data?[2].nominal)
            ?.toDouble(),
        apr: (data.pengeluaran?.bebanPenyusutanGedung?.data?[3].nominal)
            ?.toDouble(),
        mei: (data.pengeluaran?.bebanPenyusutanGedung?.data?[4].nominal)
            ?.toDouble(),
        jun: (data.pengeluaran?.bebanPenyusutanGedung?.data?[5].nominal)
            ?.toDouble(),
        jul: (data.pengeluaran?.bebanPenyusutanGedung?.data?[6].nominal)
            ?.toDouble(),
        agu: (data.pengeluaran?.bebanPenyusutanGedung?.data?[7].nominal)
            ?.toDouble(),
        sep: (data.pengeluaran?.bebanPenyusutanGedung?.data?[8].nominal)
            ?.toDouble(),
        okt: (data.pengeluaran?.bebanPenyusutanGedung?.data?[9].nominal)
            ?.toDouble(),
        nov: (data.pengeluaran?.bebanPenyusutanGedung?.data?[10].nominal)
            ?.toDouble(),
        des: (data.pengeluaran?.bebanPenyusutanGedung?.data?[11].nominal)
            ?.toDouble(),
        jumlah: (data.pengeluaran?.bebanPenyusutanGedung?.jumlah)?.toDouble(),
      ),
      RowLaporanRealisasiPendapatan(
        uraian: "Pemeliharaan Inventaris",
        jan: (data.pengeluaran?.pemeliharaanInventaris?.data?[0].nominal)
            ?.toDouble(),
        feb: (data.pengeluaran?.pemeliharaanInventaris?.data?[1].nominal)
            ?.toDouble(),
        mar: (data.pengeluaran?.pemeliharaanInventaris?.data?[2].nominal)
            ?.toDouble(),
        apr: (data.pengeluaran?.pemeliharaanInventaris?.data?[3].nominal)
            ?.toDouble(),
        mei: (data.pengeluaran?.pemeliharaanInventaris?.data?[4].nominal)
            ?.toDouble(),
        jun: (data.pengeluaran?.pemeliharaanInventaris?.data?[5].nominal)
            ?.toDouble(),
        jul: (data.pengeluaran?.pemeliharaanInventaris?.data?[6].nominal)
            ?.toDouble(),
        agu: (data.pengeluaran?.pemeliharaanInventaris?.data?[7].nominal)
            ?.toDouble(),
        sep: (data.pengeluaran?.pemeliharaanInventaris?.data?[8].nominal)
            ?.toDouble(),
        okt: (data.pengeluaran?.pemeliharaanInventaris?.data?[9].nominal)
            ?.toDouble(),
        nov: (data.pengeluaran?.pemeliharaanInventaris?.data?[10].nominal)
            ?.toDouble(),
        des: (data.pengeluaran?.pemeliharaanInventaris?.data?[11].nominal)
            ?.toDouble(),
        jumlah: (data.pengeluaran?.pemeliharaanInventaris?.jumlah)?.toDouble(),
      ),
      RowLaporanRealisasiPendapatan(
        uraian: "Pemeliharaan Gedung",
        jan: (data.pengeluaran?.pemeliharaanGedung?.data?[0].nominal)
            ?.toDouble(),
        feb: (data.pengeluaran?.pemeliharaanGedung?.data?[1].nominal)
            ?.toDouble(),
        mar: (data.pengeluaran?.pemeliharaanGedung?.data?[2].nominal)
            ?.toDouble(),
        apr: (data.pengeluaran?.pemeliharaanGedung?.data?[3].nominal)
            ?.toDouble(),
        mei: (data.pengeluaran?.pemeliharaanGedung?.data?[4].nominal)
            ?.toDouble(),
        jun: (data.pengeluaran?.pemeliharaanGedung?.data?[5].nominal)
            ?.toDouble(),
        jul: (data.pengeluaran?.pemeliharaanGedung?.data?[6].nominal)
            ?.toDouble(),
        agu: (data.pengeluaran?.pemeliharaanGedung?.data?[7].nominal)
            ?.toDouble(),
        sep: (data.pengeluaran?.pemeliharaanGedung?.data?[8].nominal)
            ?.toDouble(),
        okt: (data.pengeluaran?.pemeliharaanGedung?.data?[9].nominal)
            ?.toDouble(),
        nov: (data.pengeluaran?.pemeliharaanGedung?.data?[10].nominal)
            ?.toDouble(),
        des: (data.pengeluaran?.pemeliharaanGedung?.data?[11].nominal)
            ?.toDouble(),
        jumlah: (data.pengeluaran?.pemeliharaanGedung?.jumlah)?.toDouble(),
      ),
      RowLaporanRealisasiPendapatan(
        uraian: "JUMLAH",
        jan: (data.pengeluaran?.totalPengeluaraanPerBulan?.data?[0]
                .totalPengeluaran)
            ?.toDouble(),
        feb: (data.pengeluaran?.totalPengeluaraanPerBulan?.data?[1]
                .totalPengeluaran)
            ?.toDouble(),
        mar: (data.pengeluaran?.totalPengeluaraanPerBulan?.data?[2]
                .totalPengeluaran)
            ?.toDouble(),
        apr: (data.pengeluaran?.totalPengeluaraanPerBulan?.data?[3]
                .totalPengeluaran)
            ?.toDouble(),
        mei: (data.pengeluaran?.totalPengeluaraanPerBulan?.data?[4]
                .totalPengeluaran)
            ?.toDouble(),
        jun: (data.pengeluaran?.totalPengeluaraanPerBulan?.data?[5]
                .totalPengeluaran)
            ?.toDouble(),
        jul: (data.pengeluaran?.totalPengeluaraanPerBulan?.data?[6]
                .totalPengeluaran)
            ?.toDouble(),
        agu: (data.pengeluaran?.totalPengeluaraanPerBulan?.data?[7]
                .totalPengeluaran)
            ?.toDouble(),
        sep: (data.pengeluaran?.totalPengeluaraanPerBulan?.data?[8]
                .totalPengeluaran)
            ?.toDouble(),
        okt: (data.pengeluaran?.totalPengeluaraanPerBulan?.data?[9]
                .totalPengeluaran)
            ?.toDouble(),
        nov: (data.pengeluaran?.totalPengeluaraanPerBulan?.data?[10]
                .totalPengeluaran)
            ?.toDouble(),
        des: (data.pengeluaran?.totalPengeluaraanPerBulan?.data?[11]
                .totalPengeluaran)
            ?.toDouble(),
        jumlah:
            (data.pengeluaran?.totalPengeluaraanPerBulan?.jumlah)?.toDouble(),
      ),
      RowLaporanRealisasiPendapatan(),
      RowLaporanRealisasiPendapatan(
        uraian: "SISA HASIL USAHA SEBELUM PAJAK",
        jan: null,
        feb: null,
        mar: null,
        apr: null,
        mei: null,
        jun: null,
        jul: null,
        agu: null,
        sep: null,
        okt: null,
        nov: null,
        des: null,
        jumlah: null,
      ),
      RowLaporanRealisasiPendapatan(
        uraian: "JUMLAH",
        jan: (data.sisaHasilUsaha?.data?[0].sisaHasilUsaha)?.toDouble(),
        feb: (data.sisaHasilUsaha?.data?[1].sisaHasilUsaha)?.toDouble(),
        mar: (data.sisaHasilUsaha?.data?[2].sisaHasilUsaha)?.toDouble(),
        apr: (data.sisaHasilUsaha?.data?[3].sisaHasilUsaha)?.toDouble(),
        mei: (data.sisaHasilUsaha?.data?[4].sisaHasilUsaha)?.toDouble(),
        jun: (data.sisaHasilUsaha?.data?[5].sisaHasilUsaha)?.toDouble(),
        jul: (data.sisaHasilUsaha?.data?[6].sisaHasilUsaha)?.toDouble(),
        agu: (data.sisaHasilUsaha?.data?[7].sisaHasilUsaha)?.toDouble(),
        sep: (data.sisaHasilUsaha?.data?[8].sisaHasilUsaha)?.toDouble(),
        okt: (data.sisaHasilUsaha?.data?[9].sisaHasilUsaha)?.toDouble(),
        nov: (data.sisaHasilUsaha?.data?[10].sisaHasilUsaha)?.toDouble(),
        des: (data.sisaHasilUsaha?.data?[11].sisaHasilUsaha)?.toDouble(),
        jumlah: (data.sisaHasilUsaha?.jumlah)?.toDouble(),
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
                      "LAPORAN REALISASI ANGGARAN PENDAPATAN DAN BIAYA",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: boldFont,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 16),
                  pw.Center(
                    child: pw.Text(
                      'Tahun ${controller.yearNow}',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: boldFont,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 16),
                ],
              ),
          build: (pw.Context context) => [
                pw.TableHelper.fromTextArray(
                  headerAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerLeft,
                    2: pw.Alignment.centerLeft,
                    3: pw.Alignment.centerLeft,
                    4: pw.Alignment.centerLeft,
                    5: pw.Alignment.centerLeft,
                    6: pw.Alignment.centerLeft,
                    7: pw.Alignment.centerLeft,
                    8: pw.Alignment.centerLeft,
                    9: pw.Alignment.centerLeft,
                    10: pw.Alignment.centerLeft,
                    11: pw.Alignment.centerLeft,
                    12: pw.Alignment.centerLeft,
                    13: pw.Alignment.centerLeft,
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
                    13: pw.Alignment.centerRight,
                  },
                  headers: [
                    'Uraian',
                    'JAN',
                    'FEB',
                    'MAR',
                    'APR',
                    'MEI',
                    'JUN',
                    'JUL',
                    'AGU',
                    'SEP',
                    'OKT',
                    'NOV',
                    'DES',
                    'JUMLAH',
                  ],
                  data: rows
                      .map((row) => [
                            row.uraian ?? '',
                            formatMoney(row.jan?.toString() ?? ''),
                            formatMoney(row.feb?.toString() ?? ''),
                            formatMoney(row.mar?.toString() ?? ''),
                            formatMoney(row.apr?.toString() ?? ''),
                            formatMoney(row.mei?.toString() ?? ''),
                            formatMoney(row.jun?.toString() ?? ''),
                            formatMoney(row.jul?.toString() ?? ''),
                            formatMoney(row.agu?.toString() ?? ''),
                            formatMoney(row.sep?.toString() ?? ''),
                            formatMoney(row.okt?.toString() ?? ''),
                            formatMoney(row.nov?.toString() ?? ''),
                            formatMoney(row.des?.toString() ?? ''),
                            formatMoney(row.jumlah?.toString() ?? ''),
                          ])
                      .toList(),
                  border: pw.TableBorder.all(),
                  headerStyle: pw.TextStyle(
                    font: boldFont,
                    color: PdfColors.white,
                    fontSize: 8,
                  ),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColor.fromInt(0xFF017260),
                  ),
                  cellStyle: pw.TextStyle(
                    font: regularFont,
                    fontSize: 7,
                  ),
                  cellHeight: 30,
                  columnWidths: {
                    0: const pw.FlexColumnWidth(5),
                    1: const pw.FlexColumnWidth(3),
                    2: const pw.FlexColumnWidth(3),
                    3: const pw.FlexColumnWidth(3),
                    4: const pw.FlexColumnWidth(3),
                    5: const pw.FlexColumnWidth(3),
                    6: const pw.FlexColumnWidth(3),
                    7: const pw.FlexColumnWidth(3),
                    8: const pw.FlexColumnWidth(3),
                    9: const pw.FlexColumnWidth(3),
                    10: const pw.FlexColumnWidth(3),
                    11: const pw.FlexColumnWidth(3),
                    12: const pw.FlexColumnWidth(3),
                    13: const pw.FlexColumnWidth(4),
                  },
                ),
              ]),
    );
    Uint8List pdfData = await pdf.save();

    String fileName = 'Laporan_Realisasi_Pendapatan_${controller.yearNow}.pdf';

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
