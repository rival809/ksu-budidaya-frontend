import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class ListSessionController extends State<ListSessionView> {
  static late ListSessionController instance;
  late ListSessionView view;

  String page = "1";
  String size = "100";
  bool isAsc = false;
  String? field;
  String statusFilter = "SEMUA";

  // Stocktake type from route
  String stocktakeType = "HARIAN";

  List<String> statusOptions = [
    "SEMUA",
    "DRAFT",
    "SUBMITTED",
    "REVISION",
    "COMPLETED",
    "CANCELLED",
  ];

  Future<dynamic>? dataFuture;
  ListSessionModel result = ListSessionModel();
  DataListSession listSessionData = DataListSession();

  List<String> columnFields = [
    "id_stocktake_session",
    "stocktake_type",
    "status",
    "nama_kasir",
    "tg_stocktake",
    "nama_reviewer",
    "total_items",
    "total_counted",
    "total_variance",
    "id_tutup_kasir",
    "shift",
  ];

  Future<ListSessionModel> fetchListSession({
    bool? isAsc,
    String? field,
  }) async {
    try {
      result = ListSessionModel();
      DataMap dataCari = {
        "page": page,
        "limit": size,
        "stocktake_type": stocktakeType,
      };

      // Add status filter if not "SEMUA"
      if (statusFilter != "SEMUA") {
        dataCari["status"] = statusFilter;
      }

      // if (isAsc != null && field != null) {
      //   dataCari.addAll({
      //     "sort_order": [isAsc == true ? "asc" : "desc"],
      //     "sort_by": [field]
      //   });
      // } else {
      //   dataCari.addAll({
      //     "sort_order": ["desc"],
      //     "sort_by": ["created_at"]
      //   });
      // }

      result = await ApiService.listSession(
        data: dataCari,
      ).timeout(const Duration(seconds: 30));

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

  void navigateToStockOpname(DataDetailSession sessionData) async {
    // Set session data to static variable before navigation
    StockOpnameHarianController.passedSessionData = sessionData;

    // Navigate to stock opname page with stocktake type parameter
    await Get.to(StockOpnameHarianView(
      stocktakeType: sessionData.stocktakeType,
    ));

    dataFuture = fetchListSession();
    update();
  }

  Future<void> createNewSession() async {
    showCircleDialogLoading();
    try {
      DetailSessionModel result = await ApiService.createSession(
        stocktakeType: stocktakeType,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context); // Close loading dialog

      if (result.success == true) {
        showInfoDialog("Sesi berhasil dibuat!", context);
        // Refresh list
        dataFuture = fetchListSession();
        update();
      } else {
        showInfoDialog(result.message ?? "Gagal membuat sesi", context);
      }
    } catch (e) {
      Navigator.pop(context); // Close loading dialog
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

    // Determine stocktake type from current route
    final GoRouter router = GoRouter.of(context);
    final String currentRoute = router.routerDelegate.currentConfiguration.uri.toString();
    stocktakeType = currentRoute.contains('/bulanan') ? 'BULANAN' : 'HARIAN';

    dataFuture = fetchListSession();
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
  }

  void onReady() {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
