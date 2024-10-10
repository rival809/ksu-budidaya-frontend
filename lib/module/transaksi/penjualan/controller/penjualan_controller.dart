import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ksu_budidaya/core.dart';

class PenjualanController extends State<PenjualanView> {
  static late PenjualanController instance;
  late PenjualanView view;

  String page = "1";
  String size = "10";
  bool isAsc = true;
  TextEditingController penjualanNameController = TextEditingController();

  Future<dynamic>? dataFuture;

  bool isList = true;
  bool isDetail = false;

  FocusNode focusNodeInputPenjualan = FocusNode();

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
        dataCari
            .addAll({"keterangan": trimString(penjualanNameController.text)});
      }

      if (isAsc != null) {
        dataCari.addAll({
          "sort_order": [isAsc == true ? "asc" : "desc"]
        });
        dataCari.addAll({
          "sort_by": [field]
        });
      }

      result = await ApiService.listPenjualan(
        data: dataCari,
      ).timeout(const Duration(seconds: 30));

      return result;
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
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
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  // postDetailPurchase(String id_pembelian) async {
  //   showCircleDialogLoading();
  //   try {
  //     DetailPembelianResult result = await ApiService.detailPembelian(
  //       data: {"id_pembelian": id_pembelian},
  //     ).timeout(const Duration(seconds: 30));

  //     Navigator.pop(context);

  //     if (result.success == true) {
  //       isList = false;
  //       isDetail = true;
  //       dataPenjualan = dataPenjualan.copyWith(
  //         details: result.data,
  //       );

  //       if (result.data?.isNotEmpty ?? false) {
  //         isPpn = result.data!.any((element) => element.ppn != "0");
  //       }

  //       update();
  //     }
  //   } catch (e) {
  //     Navigator.pop(context);

  //     if (e.toString().contains("TimeoutException")) {
  //       showInfoDialog(
  //           "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
  //     } else {
  //       showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
  //     }
  //   }
  // }

  postCreatePenjualan() async {
    Get.back();

    showCircleDialogLoading();
    try {
      dataPenjualan.username =
          trimString(UserDatabase.userDatabase.data?.userData?.username);
      dataPenjualan.jenisPembayaran = trimString(metodeBayar);
      dataPenjualan.tgPenjualan =
          formatDateTimePayload(DateTime.now().toString());
      update();
      var payload = dataPenjualan.toJson();

      // for (var i = 0; i < payload['details'].length; i++) {
      //   if (payload['details'][i]["keterangan"] == null) {
      //     payload['details'][i].removeWhere(
      //       (key, value) => key == "keterangan",
      //     );
      //   }
      //   if (payload['details'][i]["id_anggota"] == null) {
      //     payload['details'][i].removeWhere(
      //       (key, value) => key == "id_anggota",
      //     );
      //   }
      //   if (payload['details'][i]["nm_anggota"] == null) {
      //     payload['details'][i].removeWhere(
      //       (key, value) => key == "nm_anggota",
      //     );
      //   }
      // }
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

        router.push("/transaksi/penjualan");
        update();
      }
    } catch (e) {
      Navigator.pop(context);

      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  TextEditingController cariProdukController = TextEditingController();
  CreatePenjualanModel dataPenjualan = CreatePenjualanModel();

  String? totalBayar = "0";

  List<TextEditingController> textControllerDialog = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  hitBayar() {
    var totalKembali = int.parse(removeComma(totalBayar ?? "0")) -
        int.parse(removeComma(dataPenjualan.totalNilaiJual ?? "0"));
    if (totalKembali < 0) {
      totalBayar = "0";
      textControllerDialog[3].text = totalBayar ?? "0";
    } else {
      totalBayar = formatMoney(removeComma(totalKembali.toString()));
      textControllerDialog[3].text = totalBayar ?? "0";
    }
  }

  sumTotal() {
    double totalNilaiJual = 0;
    double totalNilaiBeli = 0;
    double jumlah = 0;
    for (int i = 0; i < (dataPenjualan.details?.length ?? 0); i++) {
      totalNilaiJual += ((double.parse(dataPenjualan.details?[i].harga ?? "0") -
              double.parse(dataPenjualan.details?[i].diskon ?? "0")) *
          double.parse(dataPenjualan.details?[i].jumlah ?? "0"));
      totalNilaiBeli +=
          (double.parse(dataPenjualan.details?[i].hargaBeli ?? "0") *
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
        dataPenjualan.details?.add(
          DetailsCreatePenjualan(
            idProduct: trimString(result.data?.idProduct),
            harga: trimString(result.data?.hargaJual),
            jumlah: "1",
            nmProduk: trimString(result.data?.nmProduct),
            hargaBeli: trimString(result.data?.hargaBeli),
            nmDivisi:
                getNamaDivisi(idDivisi: trimString(result.data?.idDivisi)),
            diskon: "0",
            total: (double.parse(result.data?.hargaJual ?? "0") *
                    double.parse("1"))
                .toString(),
          ),
        );

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
      return heighFooter = 123;
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
