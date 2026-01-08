import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class StockOpnameHarianController extends State<StockOpnameHarianView> {
  static late StockOpnameHarianController instance;
  late StockOpnameHarianView view;

  // Static variable to receive session data from previous screen
  static DataDetailSession? passedSessionData;

  String? idSession;
  String page = "1";
  String size = "100";
  bool isAsc = false;
  String? field;

  Future<dynamic>? itemsFuture;
  DataDetailSession? sessionData;

  ListStocktakeItemsModel itemsResult = ListStocktakeItemsModel();
  DataListStocktakeItems itemsData = DataListStocktakeItems();

  @override
  void initState() {
    super.initState();
    instance = this;
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
  }

  void onReady() {
    // Get session data from static variable
    sessionData = passedSessionData;

    if (sessionData != null) {
      idSession = sessionData!.idStocktakeSession;
      itemsFuture = fetchStocktakeItems();
      // Clear static variable after use
      passedSessionData = null;
      // Trigger rebuild to show the data
      update();
    }
  }

  Future<ListStocktakeItemsModel> fetchStocktakeItems({
    bool? isAsc,
    String? field,
  }) async {
    try {
      DataMap params = {
        "page": page,
        "limit": size,
      };

      if (isAsc != null && field != null) {
        params.addAll({
          "sort_order": [isAsc == true ? "asc" : "desc"],
          "sort_by": [field]
        });
      }

      itemsResult = await ApiService.listStocktakeV2(
        idSession: idSession!,
        data: params,
      ).timeout(const Duration(seconds: 30));

      itemsData = itemsResult.data ?? DataListStocktakeItems();
      return itemsResult;
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog("Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
      rethrow;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
