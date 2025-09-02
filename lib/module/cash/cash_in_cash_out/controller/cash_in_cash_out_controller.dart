import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class CashInCashOutController extends State<CashInCashOutView> {
  static late CashInCashOutController instance;
  late CashInCashOutView view;

  String page = "1";
  String size = "500";
  bool isAsc = true;
  TextEditingController supplierNameController = TextEditingController();

  bool step1 = true;
  bool step2 = false;
  bool step3 = false;

  onSwitchStep(String valueStep) {
    switch (valueStep) {
      case "1":
        step1 = true;
        step2 = false;
        step3 = false;
        field = null;
        dataFuture = cariDataCashInOut();

        break;
      case "2":
        step1 = false;
        step2 = true;
        step3 = false;
        field = null;
        dataFuture = cariDataCashInOut();
        break;
      case "3":
        step1 = false;
        step2 = false;
        step3 = true;
        field = null;
        dataFuture = cariDataCashInOut();

        break;
      default:
        step1 = true;
        step2 = false;
        step3 = false;
        field = null;
    }
    update();
  }

  Future<dynamic>? dataFuture;

  DataCashInOut dataCashInOut = DataCashInOut();
  CashInOutResult result = CashInOutResult();
  List<String> listRoleView = [
    "tg_transaksi",
    "nm_jenis",
    "nm_detail",
    "cash_in",
    "cash_out",
    "keterangan",
  ];

  String? field;

  cariDataCashInOut({
    bool? isAsc,
    String? field,
  }) async {
    try {
      result = CashInOutResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (step2 == true) {
        dataCari.addAll(
          {"id_cash": "1"},
        );
      } else if (step3 == true) {
        dataCari.addAll(
          {"id_cash": "2"},
        );
      }

      if (trimString(supplierNameController.text).toString().isNotEmpty) {
        dataCari.addAll({"keterangan": trimString(supplierNameController.text)});
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
      result = await ApiService.listCashInOut(
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
        GlobalReference().cashReference();
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
        GlobalReference().cashReference();
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
        GlobalReference().cashReference();
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
    GlobalReference().cashReference();
    dataFuture = cariDataCashInOut();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
