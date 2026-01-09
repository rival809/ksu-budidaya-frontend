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

  void showDialogSO({
    required String namaProduk,
    required String idItem,
    String? initialStokFisik,
    String? initialNotes,
  }) {
    showDialogBase(
      content: DialogSo(
        namaProduk: namaProduk,
        initialStokFisik: initialStokFisik,
        initialNotes: initialNotes,
        onSimpan: (stokFisik, notes) async {
          try {
            await Future.delayed(const Duration(milliseconds: 300));
            showCircleDialogLoading();

            DataMap data = {
              "stok_fisik": stokFisik,
            };

            if (notes.isNotEmpty) {
              data['notes'] = notes;
            }

            await ApiService.updateSingleItem(
              data: data,
              idItem: idItem,
            );

            Get.back(); // Close loading dialog
            // Refresh data
            itemsFuture = fetchStocktakeItems(
              isAsc: isAsc,
              field: field,
            );
            update();

            await showInfoDialog("Data Stock Opname berhasil disimpan", context);
          } catch (e) {
            Get.back();
            showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
          }
        },
      ),
    );
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

      // Hit both APIs concurrently
      final results = await Future.wait([
        ApiService.listStocktakeV2(
          idSession: idSession!,
          data: params,
        ),
        ApiService.detailSession(
          idSession: idSession!,
        ),
      ]).timeout(const Duration(seconds: 30));

      // Update items data
      itemsResult = results[0] as ListStocktakeItemsModel;
      itemsData = itemsResult.data ?? DataListStocktakeItems();

      // Update session data
      final detailSessionResult = results[1] as DetailSessionModel;
      sessionData = detailSessionResult.data;

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

  cancleSo({required String reason}) async {
    showCircleDialogLoading();
    try {
      await ApiService.cancelSo(idSession: trimString(idSession), reason: reason)
          .timeout(const Duration(seconds: 30));

      Get.back(); // Close loading dialog
      await showInfoDialog("Stock Opname berhasil dibatalkan", context);
      Get.back(); // Navigate back to previous screen
    } catch (e) {
      Get.back();
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog("Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
