import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class BayarHutangDagangController extends State<BayarHutangDagangView> {
  static late BayarHutangDagangController instance;
  late BayarHutangDagangView view;

  String page = "1";
  String size = "10";
  bool isAsc = true;
  TextEditingController supplierNameController = TextEditingController();

  bool step1 = true;
  bool step2 = false;
  Future<dynamic>? dataFuture;
  Future<dynamic>? dataFutureHistory;

  String? field;

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

  DataHutangDagang dataHutangDagang = DataHutangDagang();
  DataHistoryHutangDagang dataHistoryHutangDagang = DataHistoryHutangDagang();
  HutangDagangResult result = HutangDagangResult();
  HistoryHutangDagangResult resultHistory = HistoryHutangDagangResult();
  List<String> listHutangDagangView = [
    "id_pembelian",
    "tg_hutang",
    "nm_supplier",
    "nominal",
    "keterangan",
  ];
  List<String> listHistoryHutangDagangView = [
    "id_pembelian",
    "tg_bayar_hutang",
    "nm_supplier",
    "nominal",
    "keterangan",
  ];

  cariDataHutangDagang({
    bool? isAsc,
    String? field,
  }) async {
    try {
      result = HutangDagangResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (trimString(supplierNameController.text).toString().isNotEmpty) {
        dataCari.addAll({"id_supplier": trimString(supplierNameController.text)});
      }
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

      result = await ApiService.listHutangDagang(
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
      resultHistory = HistoryHutangDagangResult();
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

      resultHistory = await ApiService.listHistoryHutangDagang(
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
