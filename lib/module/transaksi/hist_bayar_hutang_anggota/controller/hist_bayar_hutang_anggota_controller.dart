import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/model/hutang_anggota/history_hutang_anggota_model.dart';
import 'package:ksu_budidaya/module/transaksi/hist_bayar_hutang_anggota/view/hist_bayar_hutang_angoota_view.dart';
import 'package:ksu_budidaya/module/transaksi/hist_bayar_hutang_anggota/widget/detail_penjualan.dart';

class HistBayarHutangAnggotaController extends State<HistBayarHutangAnggotaView> {
  static late HistBayarHutangAnggotaController instance;
  late HistBayarHutangAnggotaView view;

  String page = "1";
  String size = "10";
  bool isAsc = true;
  TextEditingController supplierNameController = TextEditingController();

  bool step1 = true;
  bool step2 = false;
  Future<dynamic>? dataFuture;
  Future<dynamic>? dataFutureHistory;
  CreatePenjualanModel dataPenjualan = CreatePenjualanModel();

  onSwitchStep(String valueStep) {
    switch (valueStep) {
      case "1":
        step1 = true;
        step2 = false;
        field = null;
        update();
        dataFuture = cariDataHutangDagang();

        break;
      case "2":
        step1 = false;
        step2 = true;
        field = null;
        update();
        dataFutureHistory = cariDataHistoryHutangDagang();
        break;

      default:
        step1 = true;
        step2 = false;
        field = null;
        update();
        dataFuture = cariDataHutangDagang();
    }
    update();
  }

  List<TextEditingController> textControllerDialog = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

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

  postDetailPenjualan(String idPenjualan) async {
    showCircleDialogLoading();
    try {
      DetailPenjualanResult result = await ApiService.detailPenjualan(
        data: {"id_penjualan": idPenjualan},
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        dataPenjualan = dataPenjualan.copyWith(
          details: result.details,
        );

        Get.to(DetailPenjualan(
          controller: instance,
        ));

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

  DataHutangAnggota dataHutangDagang = DataHutangAnggota();
  DataHistoryHutangAnggota dataHistoryHutangDagang = DataHistoryHutangAnggota();
  HutangAnggotaResult result = HutangAnggotaResult();
  HistoryHutangAnggotaResult resultHistory = HistoryHutangAnggotaResult();
  List<String> listHutangDagangView = [
    "id_penjualan",
    "id_hutang_anggota",
    "tg_hutang",
    "nm_anggota",
    "nominal",
  ];
  List<String> listHistoryHutangDagangView = [
    "id_history_hutang_anggota",
    "tg_bayar_hutang",
    "nm_anggota",
    "nominal",
    "keterangan",
  ];
  String? field;

  cariDataHutangDagang({
    bool? isAsc,
    String? field,
  }) async {
    try {
      result = HutangAnggotaResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (trimString(supplierNameController.text).toString().isNotEmpty) {
        dataCari.addAll({"id_anggota": trimString(supplierNameController.text)});
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

      result = await ApiService.listHutangAnggota(
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

  cariDataHistoryHutangDagang({
    bool? isAsc,
    String? field,
  }) async {
    try {
      resultHistory = HistoryHutangAnggotaResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (isAsc == null && field == null) {
        dataCari.addAll({
          "sort_order": ["desc"]
        });
        dataCari.addAll({
          "sort_by": ["created_at"]
        });
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

      resultHistory = await ApiService.listHistoryHutangAnggota(
        data: dataCari,
      ).timeout(const Duration(seconds: 30));

      return resultHistory;
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog("Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  postCreateCashInOut(DataMap dataCreate) async {
    Get.back();

    showCircleDialogLoading();
    try {
      CashInOutResult result = await ApiService.createCashInOut(
        data: dataCreate,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );
        onSwitchStep(
          step1 == true
              ? "1"
              : step2 == true
                  ? "2"
                  : "3",
        );
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

  postRemoveCashInOut(String idCashInOut) async {
    Get.back();
    showCircleDialogLoading();
    try {
      CashInOutResult result = await ApiService.removeCashInOut(
        data: {"id_cash_in_out": idCashInOut},
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );
        onSwitchStep(
          step1 == true
              ? "1"
              : step2 == true
                  ? "2"
                  : "3",
        );
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

  postUpdateCashInOut(DataMap dataEdit) async {
    Get.back();

    showCircleDialogLoading();
    try {
      CashInOutResult result = await ApiService.updateCashInOut(
        data: dataEdit,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        onSwitchStep(
          step1 == true
              ? "1"
              : step2 == true
                  ? "2"
                  : "3",
        );
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

  @override
  void initState() {
    instance = this;
    super.initState();
    textControllerDialog[2].text = "0";
    textControllerDialog[3].text = "0";
    dataFuture = cariDataHutangDagang();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
