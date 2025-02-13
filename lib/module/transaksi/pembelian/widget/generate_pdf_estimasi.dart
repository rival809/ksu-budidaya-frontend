import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pdf/widgets.dart' as pw;

generatePdfEstimasi({
  required PembelianController controller,
}) async {
  showCircleDialogLoading();
  try {
    final ttfRegular = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");
    final regularFont = pw.Font.ttf(ttfRegular);
    final ttfBold = await rootBundle.load("assets/fonts/Roboto-Bold.ttf");
    final boldFont = pw.Font.ttf(ttfBold);
    List<PdfLaporanRekapKasirModel> listDataPenerimaan = [];

    for (var i = 0; i < (controller.dataPembelian.details?.length ?? 0); i++) {
      DataDetailPembelian dataRekap = controller.dataPembelian.details?[i] ?? DataDetailPembelian();
      int noUrut = i + 1;

      listDataPenerimaan.add(
        PdfLaporanRekapKasirModel(
          noUrut.toString(),
          trimString(dataRekap.idProduct),
          trimString(dataRekap.nmProduk),
          trimString(dataRekap.nmDivisi),
          formatMoney(double.parse(dataRekap.hargaBeli ?? "0").toInt()),
          formatMoney(double.parse(dataRekap.hargaJual ?? "0").toInt()),
          formatMoney(dataRekap.jumlah ?? 0),
          formatMoney(double.parse(dataRekap.diskon ?? "0").toInt()),
          formatMoney(double.parse(dataRekap.totalNilaiBeli ?? "0").toInt()),
          formatMoney(double.parse(dataRekap.totalNilaiJual ?? "0").toInt()),
          formatMoney(
            double.parse(dataRekap.totalNilaiJual ?? "0").toInt() -
                double.parse(dataRekap.totalNilaiBeli ?? "0").toInt(),
          ),
        ),
      );
    }

    int totalHargaBeli = 0;
    int totalHargaJual = 0;
    int totalJumlah = 0;
    int totalDiskon = 0;
    int totalNilaiBeli = 0;
    int totalNilaiJual = 0;
    int totalKeuntungan = 0;

    for (var i = 0; i < (controller.dataPembelian.details?.length ?? 0); i++) {
      DataDetailPembelian dataRekap = controller.dataPembelian.details?[i] ?? DataDetailPembelian();
      totalHargaBeli += double.parse(dataRekap.hargaBeli ?? "0").toInt();
      totalHargaJual += double.parse(dataRekap.hargaJual ?? "0").toInt();
      totalJumlah += dataRekap.jumlah ?? 0;
      totalDiskon += double.parse(dataRekap.diskon ?? "0").toInt();
      totalNilaiBeli += double.parse(dataRekap.totalNilaiBeli ?? "0").toInt();
      totalNilaiJual += double.parse(dataRekap.totalNilaiJual ?? "0").toInt();
      totalKeuntungan += double.parse(dataRekap.totalNilaiJual ?? "0").toInt() -
          double.parse(dataRekap.totalNilaiBeli ?? "0").toInt();
    }
    listDataPenerimaan.add(
      PdfLaporanRekapKasirModel(
        "",
        "TOTAL",
        "",
        "",
        formatMoney(totalHargaBeli),
        formatMoney(totalHargaJual),
        formatMoney(totalJumlah),
        formatMoney(totalDiskon),
        formatMoney(totalNilaiBeli),
        formatMoney(totalNilaiJual),
        formatMoney(totalKeuntungan),
      ),
    );
    pw.Widget contentTable(pw.Context context) {
      //INITITALIZE TITLE
      List<String> itemTitle = [
        "NO",
        "ID PRODUK",
        "NAMA PRODUK",
        "DIVISI",
        "HARGA BELI",
        "HARGA JUAL",
        "JUMLAH",
        "DISKON",
        "TOTAL NILAI BELI",
        "TOTAL NILAI JUAL",
        "KEUNTUNGAN",
      ];
//END INITIALIZE TITLE

      return pw.TableHelper.fromTextArray(
        border: pw.TableBorder.all(
          color: PdfColor.fromHex("#E3E7ED"),
          width: 1,
        ),
        headerAlignment: pw.Alignment.center,
        cellAlignment: pw.Alignment.center,
        defaultColumnWidth: const pw.IntrinsicColumnWidth(flex: 1),
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
        columnWidths: {
          0: const pw.FixedColumnWidth(26),
          6: const pw.FixedColumnWidth(40),
          7: const pw.FixedColumnWidth(40),
        },
        cellAlignments: {
          0: pw.Alignment.center,
          1: pw.Alignment.centerLeft,
          2: pw.Alignment.centerLeft,
          3: pw.Alignment.centerLeft,
          4: pw.Alignment.centerRight,
          5: pw.Alignment.centerRight,
          6: pw.Alignment.centerRight,
          7: pw.Alignment.centerRight,
          8: pw.Alignment.centerRight,
          9: pw.Alignment.centerRight,
          10: pw.Alignment.centerRight,
        },
        headerStyle: pw.TextStyle(
          color: PdfColor.fromHex("#212121"),
          fontSize: 5,
          font: boldFont,
          fontWeight: pw.FontWeight.bold,
        ),
        headerCellDecoration: pw.BoxDecoration(
          color: PdfColor.fromHex("#F4F5F8"),
        ),
        cellStyle: pw.TextStyle(
          font: regularFont,
          color: PdfColor.fromHex("#212121"),
          fontSize: 5,
        ),
        headers: List<String>.generate(
          itemTitle.length,
          (col) => itemTitle[col],
        ),
        data: List<List<String>>.generate(listDataPenerimaan.length, (row) {
          return List<String>.generate(itemTitle.length, (col) {
            return listDataPenerimaan[row].getIndex(col);
          });
        }),
      );
    }

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageTheme: const pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          orientation: pw.PageOrientation.portrait,
          margin: pw.EdgeInsets.all(16),
        ),
        header: (context) => pw.Center(
          child: pw.Text(
            "LAPORAN PEMBELIAN\n${controller.dataPembelian.nmSupplier}\nTANGGAL: ${controller.dataPembelian.tgPembelian}",
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 7,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        build: (context) => [
          pw.SizedBox(
            height: 16.0,
          ),
          contentTable(context),
        ],
      ),
    );
    Uint8List pdfData = await pdf.save();

    String fileName = 'Pembelian_${controller.dataPembelian.tgPembelian}.pdf';

    await Printing.layoutPdf(
      format: PdfPageFormat.a4,
      name: fileName,
      onLayout: (PdfPageFormat format) async {
        return pdfData;
      },
    );
  } catch (e) {
    Get.back();
    showInfoDialog(e.toString(), globalContext);
  }

  Get.back();
}

class PdfLaporanRekapKasirModel {
  const PdfLaporanRekapKasirModel(
    this.no,
    this.idProduk,
    this.divisi,
    this.namaProduk,
    this.hargaBeli,
    this.hargaJual,
    this.jumlah,
    this.diskon,
    this.totalNilaiBeli,
    this.totalNilaiJual,
    this.totalKeuntungan,
  );

  final String no;
  final String idProduk;
  final String divisi;
  final String namaProduk;
  final String hargaBeli;
  final String hargaJual;
  final String jumlah;
  final String diskon;
  final String totalNilaiBeli;
  final String totalNilaiJual;
  final String totalKeuntungan;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return no;
      case 1:
        return idProduk;
      case 2:
        return divisi;
      case 3:
        return namaProduk;
      case 4:
        return hargaBeli;
      case 5:
        return hargaJual;
      case 6:
        return jumlah;
      case 7:
        return diskon;
      case 8:
        return totalNilaiBeli;
      case 9:
        return totalNilaiJual;
      case 10:
        return totalKeuntungan;
    }
    return '';
  }
}
