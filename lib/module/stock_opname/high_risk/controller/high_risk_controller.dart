import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class HighRiskController extends State<HighRiskView> {
  static late HighRiskController instance;
  late HighRiskView view;

  String page = "1";
  String size = "500";
  bool isAsc = true;
  TextEditingController searchController = TextEditingController();

  Future<dynamic>? dataFuture;

  DataListHighRisk dataHighRisk = DataListHighRisk();
  ListHighRiskModel result = ListHighRiskModel();

  String? field;

  List<String> columnFields = [
    "id_high_risk",
    "id_product",
    "nm_product",
    "category",
    "reason",
  ];

  Future<ListHighRiskModel> fetchHighRiskProducts({bool? isAsc, String? field}) async {
    try {
      result = ListHighRiskModel();

      result = await ApiService.getListHighRisk().timeout(const Duration(seconds: 30));

      return result;
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog("Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
      rethrow;
    }
  }

  Future<void> createHighRisk({
    required String id,
    required String category,
    required String reason,
  }) async {
    Get.back();

    showCircleDialogLoading();
    try {
      AddHighRiskModel result = await ApiService.addHighRisk(
        id: id,
        category: category,
        reason: reason,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        dataFuture = fetchHighRiskProducts();
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

  Future<void> updateHighRisk({
    required String id,
    required String category,
    required String reason,
  }) async {
    Get.back();

    showCircleDialogLoading();
    try {
      AddHighRiskModel result = await ApiService.editHighRisk(
        id: id,
        category: category,
        reason: reason,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        dataFuture = fetchHighRiskProducts();
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

  Future<void> deleteHighRisk(String id) async {
    Get.back();

    showCircleDialogLoading();
    try {
      DeleteHighRiskModel result = await ApiService.deleteHighRisk(
        id: id,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        dataFuture = fetchHighRiskProducts();
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
    super.initState();
    instance = this;
    dataFuture = fetchHighRiskProducts();
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
  }

  void onReady() {}

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
