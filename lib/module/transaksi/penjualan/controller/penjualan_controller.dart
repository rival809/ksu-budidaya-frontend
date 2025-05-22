import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/module/transaksi/penjualan/widget/detail_view.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/widgets.dart';

class PenjualanController extends State<PenjualanView> {
  static late PenjualanController instance;
  late PenjualanView view;

  final GlobalKey notaKey = GlobalKey();

  String page = "1";
  String size = "10";
  bool isAsc = false;
  TextEditingController penjualanNameController = TextEditingController();

  String? field;

  Future<dynamic>? dataFuture;

  bool isList = true;
  bool isDetail = false;
  bool viewOnly = false;

  FocusNode focusNodeInputPenjualan = FocusNode();

  List<DataDetailProduct> getDetailSuggestions(String query, List<DataDetailProduct>? states) {
    List<DataDetailProduct> matches = [];

    if (states != null) {
      matches.addAll(states);
      matches.retainWhere((s) =>
          (trimString(s.idProduct).toLowerCase().contains(query.toLowerCase()) ||
              trimString(s.nmProduct).toLowerCase().contains(query.toLowerCase())) &&
          s.statusProduct == true);
    }

    return matches;
  }

  DataPenjualan dataListPenjualan = DataPenjualan();
  PenjualanResult result = PenjualanResult();
  List<String> listPenjualanView = [
    "id_penjualan",
    "tg_penjualan",
    "jumlah",
    "total_nilai_beli",
    "total_nilai_jual",
    "nm_anggota",
    "jenis_pembayaran",
    "keterangan",
    "username",
  ];

  cariDataPenjualan({
    bool? isAsc,
    String? field,
  }) async {
    try {
      result = PenjualanResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (trimString(penjualanNameController.text).toString().isNotEmpty) {
        dataCari.addAll({"keterangan": trimString(penjualanNameController.text)});
      }

      if (isAsc != null) {
        dataCari.addAll({
          "sort_order": [isAsc == true ? "asc" : "desc"]
        });
      }
      if (field != null) {
        dataCari.addAll({
          "sort_by": [field]
        });
      }

      if (field == null) {
        dataCari.removeWhere((key, value) => key == "sort_order");
        dataCari.removeWhere((key, value) => key == "sort_by");
        dataCari.addAll({
          "sort_order": ["desc"]
        });
        dataCari.addAll({
          "sort_by": ["created_at"]
        });
      }

      result = await ApiService.listPenjualan(
        data: dataCari,
      ).timeout(const Duration(seconds: 30));

      return result;
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog("Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  postRemoveSale(String id_penjualan) async {
    Get.back();
    showCircleDialogLoading();
    try {
      PenjualanResult result = await ApiService.removePenjualan(
        data: {"id_penjualan": id_penjualan},
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        dataFuture = cariDataPenjualan();
        update();
      }
    } catch (e) {
      Navigator.pop(context);

      if (e.toString().contains("TimeoutException")) {
        showInfoDialog("Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  postDetailPenjualan(String idPenjualan) async {
    showCircleDialogLoading();
    try {
      DetailPenjualanResult result = await ApiService.detailPenjualan(
        data: {"id_penjualan": idPenjualan},
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        // isList = false;
        // isDetail = true;
        // viewOnly = true;
        dataPenjualan = dataPenjualan.copyWith(
          details: result.details,
        );

        update();

        Get.to(DetailView(controller: instance));
      }
    } catch (e) {
      Navigator.pop(context);

      if (e.toString().contains("TimeoutException")) {
        showInfoDialog("Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  postCreatePenjualan() async {
    Get.back();

    showCircleDialogLoading();
    try {
      dataPenjualan.username = trimString(UserDatabase.userDatabase.data?.userData?.username);
      dataPenjualan.jenisPembayaran = trimString(metodeBayar);
      dataPenjualan.tgPenjualan = formatDateTimePayload(DateTime.now().toString());
      update();
      var payload = dataPenjualan.toJson();

      for (var i = 0; i < (dataPenjualan.details?.length ?? 0); i++) {
        payload['details'][i].removeWhere(
          (key, value) => key == "id_penjualan",
        );

        payload['details'][i].removeWhere(
          (key, value) => key == "id_detail_penjualan",
        );
      }

      if (payload['keterangan'] == null) {
        payload.removeWhere(
          (key, value) => key == "keterangan",
        );
      }
      if (payload['id_anggota'] == null) {
        payload.removeWhere(
          (key, value) => key == "id_anggota",
        );
      }
      if (payload['nm_anggota'] == null) {
        payload.removeWhere(
          (key, value) => key == "nm_anggota",
        );
      }

      PenjualanResult result = await ApiService.createPenjualan(
        data: payload,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        await showDialogBase(
          content: const DialogBerhasil(),
        );

        await doGeneratePdfAndPrint();

        Get.to(const PenjualanView());
        update();
      }
    } catch (e) {
      Navigator.pop(context);

      if (e.toString().contains("TimeoutException")) {
        showInfoDialog("Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  TextEditingController cariProdukController = TextEditingController();
  CreatePenjualanModel dataPenjualan = CreatePenjualanModel();

  String? totalBayar = "0";
  int totalKembali = 0;

  List<TextEditingController> textControllerDialog = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  hitBayar() {
    totalKembali = double.parse(removeComma(
                trimString(textControllerDialog[2].text.toString()).toString().isEmpty
                    ? "0"
                    : trimString(textControllerDialog[2].text.toString()) ?? "0"))
            .round() -
        double.parse(removeComma(dataPenjualan.totalNilaiJual ?? "0")).round();
    totalBayar = formatMoney(removeComma(totalKembali.toString()));
    textControllerDialog[3].text = totalBayar ?? "0";
  }

  sumTotal() {
    double totalNilaiJual = 0;
    double totalNilaiBeli = 0;
    double jumlah = 0;
    for (int i = 0; i < (dataPenjualan.details?.length ?? 0); i++) {
      totalNilaiJual += ((double.parse(dataPenjualan.details?[i].harga ?? "0") -
              double.parse(dataPenjualan.details?[i].diskon ?? "0")) *
          double.parse(dataPenjualan.details?[i].jumlah ?? "0"));
      totalNilaiBeli += (double.parse(dataPenjualan.details?[i].hargaBeli ?? "0") *
          double.parse(dataPenjualan.details?[i].jumlah ?? "0"));
      jumlah += double.parse(dataPenjualan.details?[i].jumlah ?? "0");
    }

    dataPenjualan.totalNilaiJual = totalNilaiJual.toString();
    dataPenjualan.totalNilaiBeli = totalNilaiBeli.toString();
    dataPenjualan.jumlah = jumlah.toString();
  }

  sumTotalIndex() {
    double total = 0;
    for (int i = 0; i < (dataPenjualan.details?.length ?? 0); i++) {
      var diskon = double.parse(
        removeComma(dataPenjualan.details?[i].diskon ?? "0"),
      );

      var hargaJual = double.parse(
        removeComma(dataPenjualan.details?[i].harga ?? "0"),
      );

      var jumlah = double.parse(
        removeComma(dataPenjualan.details?[i].jumlah ?? "0"),
      );

      var totalHarga = ((hargaJual - diskon) * jumlah).toString();
      dataPenjualan.details?[i].total = totalHarga;
    }
  }

  Timer? _debounce;
  void onProdctSearch(String value) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(
      const Duration(seconds: 1),
      () {
        if (trimString(value).toString().isNotEmpty) {
          postDetailProduct(value);
        }
      },
    );
  }

  DetailProductResult dataResult = DetailProductResult();

  postDetailProduct(String idProduct) async {
    showCircleDialogLoading();
    try {
      dataResult = DetailProductResult();

      DetailProductResult result = await ApiService.detailProduct(
        data: {"id_product": idProduct},
      ).timeout(const Duration(seconds: 30));
      Navigator.pop(context);

      if (result.success == true) {
        if (result.data?.jumlah == 0) {
          showInfoDialog("Stok Produk ${trimString(result.data?.nmProduct)} Kosong", context);
        } else {
          if (dataPenjualan.details != null &&
              dataPenjualan.details!
                  .any((element) => element.idProduct == result.data?.idProduct)) {
            var existingDetail = dataPenjualan.details!
                .firstWhere((element) => element.idProduct == result.data?.idProduct);
            int currentJumlah = int.parse(existingDetail.jumlah ?? "0");
            int maxJumlah = result.data?.jumlah ?? 0;

            if (currentJumlah < maxJumlah) {
              existingDetail.jumlah = (currentJumlah + 1).toString();
            } else {
              showInfoDialog(
                  "Jumlah produk ${trimString(result.data?.nmProduct)} sudah mencapai batas maksimum. (Stock: ${trimString(result.data?.jumlah.toString())})",
                  context);
            }
          } else {
            if ((result.data?.jumlah ?? 0) > 0) {
              dataPenjualan.details?.add(
                DetailsCreatePenjualan(
                  idProduct: trimString(result.data?.idProduct),
                  harga: trimString(result.data?.hargaJual),
                  jumlah: "1",
                  nmProduk: trimString(result.data?.nmProduct),
                  hargaBeli: trimString(result.data?.hargaBeli),
                  nmDivisi: getNamaDivisi(idDivisi: trimString(result.data?.idDivisi)),
                  diskon: "0",
                  total:
                      (double.parse(result.data?.hargaJual ?? "0") * double.parse("1")).toString(),
                  stockAwal: result.data?.jumlah,
                ),
              );
            } else {
              showInfoDialog("Stok produk tidak mencukupi.", context);
            }
          }
        }

        cariProdukController.clear();

        update();
      }
    } catch (e) {
      Navigator.pop(context);
    }
  }

  List<TextEditingController> textControllerDetail = [
    TextEditingController(),
    TextEditingController(),
  ];

  bool isLoading = false;
  bool isPpn = false;
  bool isDiskon = false;
  double totalHargaBeli = 0;
  double totalHargaJual = 0;
  double totalPpn = 0;
  double totalDiskon = 0;
  double jumlah = 0;

  double rowHeight = 47;
  double heighFooter = 49;

  double getRowHeigh() {
    if (isPpn) {
      return heighFooter = 143;
    } else {
      return heighFooter = 86;
    }
  }

  sumTotalDiskon() {
    totalDiskon = 0;
    for (var i = 0; i < (dataPenjualan.details?.length ?? 0); i++) {
      totalDiskon += double.parse(dataPenjualan.details?[i].diskon ?? "0");
    }
  }

  sumTotalNilaiBeli() {
    totalHargaBeli = 0;
    for (var i = 0; i < (dataPenjualan.details?.length ?? 0); i++) {
      totalHargaBeli += double.parse(dataPenjualan.details?[i].total ?? "0");
    }
    totalHargaBeli = totalHargaBeli + totalPpn;
    dataPenjualan.totalNilaiBeli = totalHargaBeli.toString();
  }

  sumTotalNilaiJual() {
    totalHargaJual = 0;
    for (var i = 0; i < (dataPenjualan.details?.length ?? 0); i++) {
      totalHargaJual += double.parse(dataPenjualan.details?[i].total ?? "0");
    }
    dataPenjualan.totalNilaiJual = totalHargaJual.toString();
  }

  sumJumlah() {
    jumlah = 0;
    for (var i = 0; i < (dataPenjualan.details?.length ?? 0); i++) {
      jumlah += int.tryParse(dataPenjualan.details?[i].jumlah ?? "0") ?? 0;
    }
    dataPenjualan.jumlah = jumlah.toString();
  }

  bool statusTunai = true;
  bool statusQris = false;
  bool statusKredit = false;
  String metodeBayar = "tunai";

  onInitDialog() {
    statusTunai = true;
    statusQris = false;
    statusKredit = false;
    metodeBayar = "tunai";
    dataPenjualan.jenisPembayaran = "tunai";
  }

  onSwitchStep(String valueStep) {
    switch (valueStep) {
      case "1":
        statusTunai = true;
        statusQris = false;
        statusKredit = false;
        metodeBayar = "tunai";
        dataPenjualan.jenisPembayaran = "tunai";

        break;
      case "2":
        statusTunai = false;
        statusQris = true;
        statusKredit = false;
        metodeBayar = "qris";
        dataPenjualan.jenisPembayaran = "qris";

        break;
      case "3":
        statusTunai = false;
        statusQris = false;
        statusKredit = true;
        metodeBayar = "kredit";
        dataPenjualan.jenisPembayaran = "kredit";
        totalBayar = "0";
        textControllerDialog[2].text = "0";

        break;
      default:
        statusTunai = true;
        statusQris = false;
        statusKredit = false;
        metodeBayar = "tunai";
        dataPenjualan.jenisPembayaran = "tunai";
    }
    update();
  }

  doGeneratePdfAndPrint() async {
    showCircleDialogLoading();
    try {
      final pdf = pw.Document();

      final ttfRegular = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");

      final regularFont = pw.Font.ttf(ttfRegular);

      pdf.addPage(
        pw.Page(
          pageTheme: const pw.PageTheme(
            pageFormat: PdfPageFormat(71 * PdfPageFormat.mm, double.infinity),
            orientation: pw.PageOrientation.natural,
            margin: pw.EdgeInsets.all(8),
          ),
          build: (pw.Context context) {
            return pw.Container(
              decoration: const pw.BoxDecoration(
                color: PdfColors.white,
              ),
              child: pw.Column(
                children: [
                  pw.Text(
                    'Koperasi Serba Usaha\n"BUDIDAYA"\nJL. Rajamantri ll no 9 Bandung',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      font: regularFont,
                      fontSize: 8,
                    ),
                  ),
                  pw.SizedBox(
                    height: 8.0,
                  ),
                  pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Text(
                          "ID",
                          style: pw.TextStyle(
                            font: regularFont,
                            fontSize: 7,
                          ),
                        ),
                      ),
                      pw.Text(
                        ":",
                        style: const pw.TextStyle(
                          fontSize: 7,
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          trimString(
                            dataPenjualan.details?.first.idPenjualan,
                          ),
                          style: pw.TextStyle(
                            font: regularFont,
                            fontSize: 7,
                          ),
                          textAlign: pw.TextAlign.end,
                        ),
                      )
                    ],
                  ),
                  if (dataPenjualan.idAnggota?.isNotEmpty ?? false)
                    pw.SizedBox(
                      height: 2.0,
                    ),
                  if (dataPenjualan.idAnggota?.isNotEmpty ?? false)
                    pw.Row(
                      children: [
                        pw.Expanded(
                          child: pw.Text(
                            "Nama Anggota",
                            style: pw.TextStyle(
                              font: regularFont,
                              fontSize: 7,
                            ),
                          ),
                        ),
                        pw.Text(
                          ":",
                          style: const pw.TextStyle(
                            fontSize: 7,
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            trimString(
                              getNamaAnggota(idAnggota: dataPenjualan.idAnggota),
                            ),
                            style: pw.TextStyle(
                              font: regularFont,
                              fontSize: 7,
                            ),
                            textAlign: pw.TextAlign.end,
                          ),
                        )
                      ],
                    ),
                  pw.SizedBox(
                    height: 2.0,
                  ),
                  if (dataPenjualan.jenisPembayaran?.isNotEmpty ?? false)
                    pw.Row(
                      children: [
                        pw.Expanded(
                          child: pw.Text(
                            "Metode Bayar",
                            style: pw.TextStyle(
                              font: regularFont,
                              fontSize: 7,
                            ),
                          ),
                        ),
                        pw.Text(
                          ":",
                          style: pw.TextStyle(
                            font: regularFont,
                            fontSize: 7,
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            trimString(dataPenjualan.jenisPembayaran).toUpperCase(),
                            style: pw.TextStyle(
                              font: regularFont,
                              fontSize: 7,
                            ),
                            textAlign: pw.TextAlign.end,
                          ),
                        )
                      ],
                    ),
                  if ((dataPenjualan.idAnggota?.isNotEmpty ?? false) ||
                      (dataPenjualan.jenisPembayaran?.isNotEmpty ?? false))
                    // pw.LineDash(),
                    pw.SizedBox(
                      height: 2.0,
                    ),
                  pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Text(
                          trimString(UserDatabase.userDatabase.data?.userData?.name),
                          style: pw.TextStyle(
                            font: regularFont,
                            fontSize: 7,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          formatDateTime(DateTime.now().toString()),
                          textAlign: pw.TextAlign.end,
                          style: pw.TextStyle(
                            font: regularFont,
                            fontSize: 7,
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(
                    height: 8.0,
                  ),
                  pw.ListView.builder(
                    itemCount: dataPenjualan.details?.length ?? 0,
                    itemBuilder: (context, index) {
                      String persenDiskon = "0";

                      var diskon = double.parse(
                        removeComma(dataPenjualan.details?[index].diskon ?? "0"),
                      );

                      var hargaJual = double.parse(
                        removeComma(dataPenjualan.details?[index].harga ?? "0"),
                      );

                      persenDiskon = formatMoney(
                          (((hargaJual - (hargaJual - diskon)) / hargaJual) * 100).toString());

                      return pw.Padding(
                        padding: const pw.EdgeInsets.only(bottom: 1.0),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              trimString(
                                dataPenjualan.details?[index].nmProduk,
                              ),
                              style: pw.TextStyle(
                                font: regularFont,
                                fontSize: 7,
                              ),
                            ),
                            pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Expanded(
                                  flex: 5,
                                  child: pw.Row(
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Expanded(
                                        child: pw.Text(
                                          trimString(
                                            dataPenjualan.details?[index].idProduct,
                                          ),
                                          style: pw.TextStyle(
                                            font: regularFont,
                                            fontSize: 7,
                                          ),
                                        ),
                                      ),
                                      pw.Text(
                                        "x ${trimString(
                                          dataPenjualan.details?[index].jumlah,
                                        )} ",
                                        style: pw.TextStyle(
                                          font: regularFont,
                                          fontSize: 7,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                pw.Expanded(
                                  flex: 6,
                                  child: pw.Row(
                                    children: [
                                      pw.Expanded(
                                        child: pw.Text(
                                          formatMoney(trimString(
                                            dataPenjualan.details?[index].harga,
                                          )),
                                          style: pw.TextStyle(
                                            font: regularFont,
                                            fontSize: 7,
                                          ),
                                          textAlign: pw.TextAlign.end,
                                        ),
                                      ),
                                      pw.Expanded(
                                        child: pw.Text(
                                          formatMoney(trimString(
                                            ((double.parse(dataPenjualan.details?[index].harga ??
                                                        "0") *
                                                    double.parse(
                                                        dataPenjualan.details?[index].jumlah ??
                                                            "0")))
                                                .toString(),
                                          )),
                                          style: pw.TextStyle(
                                            font: regularFont,
                                            fontSize: 7,
                                          ),
                                          textAlign: pw.TextAlign.end,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if (dataPenjualan.details?[index].diskon != "0")
                              pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Expanded(
                                    child: pw.Text(
                                      "Diskon",
                                      style: pw.TextStyle(
                                        font: regularFont,
                                        fontSize: 7,
                                      ),
                                    ),
                                  ),
                                  pw.Expanded(
                                    child: pw.Row(
                                      children: [
                                        pw.Expanded(
                                          child: pw.Row(
                                            children: [
                                              pw.Expanded(
                                                child: pw.Text(
                                                  "",
                                                  style: pw.TextStyle(
                                                    fontSize: 7,
                                                    font: regularFont,
                                                  ),
                                                ),
                                              ),
                                              pw.SizedBox(
                                                width: 16.0,
                                              ),
                                              pw.Expanded(
                                                child: pw.Text(
                                                  trimString(persenDiskon) + "%",
                                                  textAlign: pw.TextAlign.start,
                                                  style: pw.TextStyle(
                                                    font: regularFont,
                                                    fontSize: 7,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        pw.Expanded(
                                          child: pw.Text(
                                            formatMoney(
                                              trimString(
                                                (double.parse(
                                                            dataPenjualan.details?[index].diskon ??
                                                                "0") *
                                                        double.parse(removeComma(
                                                            dataPenjualan.details?[index].jumlah ??
                                                                "0")))
                                                    .toString(),
                                              ),
                                            ),
                                            style: pw.TextStyle(
                                              font: regularFont,
                                              fontSize: 7,
                                            ),
                                            textAlign: pw.TextAlign.end,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  pw.SizedBox(
                    height: 8.0,
                  ),
                  pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Text(
                          "Total",
                          style: pw.TextStyle(
                            font: regularFont,
                            fontSize: 7,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Text(
                        ":",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          font: regularFont,
                          fontSize: 7,
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          formatMoney(trimString(dataPenjualan.totalNilaiJual)),
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            font: regularFont,
                            fontSize: 7,
                          ),
                          textAlign: pw.TextAlign.end,
                        ),
                      )
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Text(
                          "Bayar",
                          style: pw.TextStyle(
                            font: regularFont,
                            fontSize: 7,
                          ),
                        ),
                      ),
                      pw.Text(
                        ":",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          font: regularFont,
                          fontSize: 7,
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          formatMoney(trimString(removeComma(textControllerDialog[2].text))),
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            font: regularFont,
                            fontSize: 7,
                          ),
                          textAlign: pw.TextAlign.end,
                        ),
                      )
                    ],
                  ),
                  pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Text(
                          "Kembali",
                          style: pw.TextStyle(
                            font: regularFont,
                            fontSize: 7,
                          ),
                        ),
                      ),
                      pw.Text(
                        ":",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          font: regularFont,
                          fontSize: 7,
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          formatMoney(trimString(removeComma(textControllerDialog[3].text))),
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            font: regularFont,
                            fontSize: 7,
                          ),
                          textAlign: pw.TextAlign.end,
                        ),
                      )
                    ],
                  ),
                  pw.SizedBox(
                    height: 8.0,
                  ),
                  pw.Text(
                    'TERIMA KASIH\nATAS KUNJUNGAN ANDA',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      font: regularFont,
                      fontSize: 8,
                    ),
                  ),
                  pw.SizedBox(
                    height: 42.0,
                  ),
                ],
              ),
            );
          },
        ),
      );

      Uint8List pdfData = await pdf.save();
      await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfData);
    } catch (e) {
      Navigator.pop(context);
      showInfoDialog(e.toString(), context);
    }

    Navigator.pop(context);
  }

  @override
  void initState() {
    instance = this;
    GlobalReference().supplierReference();
    GlobalReference().anggotaReference();
    dataFuture = cariDataPenjualan();
    textControllerDialog[2].text = "0";
    totalBayar = "0";
    textControllerDialog[3].text = "0";

    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
