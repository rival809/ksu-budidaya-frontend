import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/model/hutang_anggota/history_hutang_anggota_model.dart';
import 'package:ksu_budidaya/module/transaksi/hist_bayar_hutang_anggota/view/hist_bayar_hutang_angoota_view.dart';

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

  onSwitchStep(String valueStep) {
    switch (valueStep) {
      case "1":
        step1 = true;
        step2 = false;
        update();
        dataFuture = cariDataHutangDagang();

        break;
      case "2":
        step1 = false;
        step2 = true;
        update();
        dataFutureHistory = cariDataHistoryHutangDagang();
        break;

      default:
        step1 = true;
        step2 = false;
        update();
        dataFuture = cariDataHutangDagang();
    }
    update();
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
        dataCari.addAll({
          "sort_by": [field]
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

      if (isAsc != null) {
        dataCari.addAll({
          "sort_order": [isAsc == true ? "asc" : "desc"]
        });
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
    dataFuture = cariDataHutangDagang();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
