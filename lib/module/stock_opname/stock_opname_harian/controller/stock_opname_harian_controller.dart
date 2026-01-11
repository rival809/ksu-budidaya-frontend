import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class StockOpnameHarianController extends State<StockOpnameHarianView> {
  static late StockOpnameHarianController instance;
  late StockOpnameHarianView view;

  // Static variable to receive session data from previous screen
  static DataDetailSession? passedSessionData;

  // Stocktake type for this session
  String stocktakeType = "HARIAN";

  String? idSession;
  String page = "1";
  String size = "100";
  bool isAsc = false;
  String? field;

  Future<dynamic>? itemsFuture;
  DataDetailSession? sessionData;

  ListStocktakeItemsModel itemsResult = ListStocktakeItemsModel();
  DataListStocktakeItems itemsData = DataListStocktakeItems();

  // Infinite scroll variables
  final ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;
  bool hasMoreData = true;
  int currentPage = 1;

  // Search variables
  final TextEditingController searchController = TextEditingController();
  List<DetailListStocktakeItemsilDataListStocktakeItems> filteredData = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    instance = this;

    // Get stocktake type from widget
    stocktakeType = widget.stocktakeType ?? "HARIAN";

    scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      if (!isLoadingMore && hasMoreData && !kIsWeb) {
        loadMoreItems();
      }
    }
  }

  void onReady() async {
    // Reset pagination
    currentPage = 1;
    hasMoreData = true;
    page = "1";

    // For mobile/non-web, fetch latest session automatically
    if (!kIsWeb) {
      try {
        showCircleDialogLoading();

        // Fetch latest session with stocktake type filter
        final sessionListResult = await ApiService.listSession(
          data: {
            "page": "1",
            "limit": "1",
            "stocktake_type": stocktakeType,
          },
        );

        Get.back(); // Close loading

        if (sessionListResult.data?.data?.isNotEmpty ?? false) {
          final latestSession = sessionListResult.data!.data!.first;

          // Get full session detail
          final sessionDetailResult = await ApiService.detailSession(
            idSession: latestSession.idStocktakeSession ?? '',
            // idSession: 'ST-20260108-221256',
          );

          sessionData = sessionDetailResult.data;

          if (sessionData != null) {
            idSession = sessionData!.idStocktakeSession;
            itemsFuture = fetchStocktakeItems();
            update();
          } else {
            showInfoDialog("Tidak ada session aktif", context);
          }
        } else {
          showInfoDialog("Tidak ada session yang tersedia", context);
        }
      } catch (e) {
        Get.back();
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    } else {
      // For web, use passed session data
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

            // Reset pagination before refresh
            currentPage = 1;
            hasMoreData = true;
            page = "1";

            // Refresh data
            await fetchStocktakeItems(
              isAsc: isAsc,
              field: field,
            );

            // Update filtered data after fetch
            filteredData = itemsData.data ?? [];

            // Scroll to top
            if (scrollController.hasClients) {
              scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }

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

  void onSearchChanged(String keyword) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchItems(keyword);
    });
  }

  void searchItems(String keyword) {
    if (keyword.isEmpty) {
      filteredData = itemsData.data ?? [];
    } else {
      final lowercaseKeyword = keyword.toLowerCase();
      filteredData = (itemsData.data ?? []).where((item) {
        final productName = (item.nmProduct ?? '').toLowerCase();
        final productId = (item.idProduct ?? '').toLowerCase();
        final division = (item.nmDivisi ?? '').toLowerCase();
        return productName.contains(lowercaseKeyword) ||
            productId.contains(lowercaseKeyword) ||
            division.contains(lowercaseKeyword);
      }).toList();
    }
    update();
  }

  void refreshData() async {
    try {
      showCircleDialogLoading();

      // Reset pagination
      currentPage = 1;
      hasMoreData = true;
      page = "1";
      searchController.clear();
      filteredData = [];

      if (!kIsWeb) {
        // For mobile, fetch latest session with stocktake type filter
        final sessionListResult = await ApiService.listSession(
          data: {
            "page": "1",
            "limit": "1",
            "stocktake_type": stocktakeType,
          },
        );

        if (sessionListResult.data?.data?.isNotEmpty ?? false) {
          final latestSession = sessionListResult.data!.data!.first;

          // Get full session detail
          final sessionDetailResult = await ApiService.detailSession(
            idSession: latestSession.idStocktakeSession ?? '',
            // idSession: 'ST-20260108-221256',
          );

          sessionData = sessionDetailResult.data;

          if (sessionData != null) {
            idSession = sessionData!.idStocktakeSession;
          }
        }
      }

      // Refresh items data
      itemsFuture = fetchStocktakeItems(
        isAsc: isAsc,
        field: field,
      );

      Get.back(); // Close loading
      update();
    } catch (e) {
      Get.back();
      showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
    }
  }

  void loadMoreItems() async {
    if (isLoadingMore || !hasMoreData) return;

    isLoadingMore = true;
    update();

    try {
      currentPage++;
      page = currentPage.toString();

      DataMap params = {
        "page": page,
        "limit": size,
      };

      if (field != null) {
        params.addAll({
          "sort_order": [isAsc == true ? "asc" : "desc"],
          "sort_by": [field!]
        });
      }

      final result = await ApiService.listStocktakeV2(
        idSession: idSession!,
        data: params,
      );

      if (result.data?.data != null && result.data!.data!.isNotEmpty) {
        // Append new data to existing list
        itemsData.data ??= [];
        itemsData.data!.addAll(result.data!.data!);
        itemsData.pagination = result.data!.pagination;

        // Check if there's more data
        final pagination = result.data!.pagination;
        if (pagination != null) {
          hasMoreData = (pagination.page ?? 0) < (pagination.totalPages ?? 0);
        }
      } else {
        hasMoreData = false;
      }

      isLoadingMore = false;
      update();
    } catch (e) {
      isLoadingMore = false;
      currentPage--;
      page = currentPage.toString();
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

      if (idSession == null) {
        return ListStocktakeItemsModel();
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

      // Check pagination for infinite scroll
      final pagination = itemsData.pagination;
      if (pagination != null) {
        hasMoreData = (pagination.page ?? 0) < (pagination.totalPages ?? 0);
      }

      // Update session data
      final detailSessionResult = results[1] as DetailSessionModel;
      sessionData = detailSessionResult.data;

      // Update filtered data if no search active
      if (searchController.text.isEmpty) {
        filteredData = itemsData.data ?? [];
      }

      if (!kIsWeb) {
        update();
      }

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

  submitSo({required String reason}) async {
    showCircleDialogLoading();
    try {
      await ApiService.submitSo(idSession: trimString(idSession), reason: reason)
          .timeout(const Duration(seconds: 30));

      Get.back();
      await showDialogBase(content: const DialogBerhasil()).then((value) {
        Get.back();
      });

      refreshData();
      return true;
    } catch (e) {
      Get.back();
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog("Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  submitSoManager({required String reason}) async {
    showCircleDialogLoading();
    try {
      await ApiService.submitSo(idSession: trimString(idSession), reason: reason);

      await ApiService.reviewSo(
          idSession: trimString(idSession), reason: reason, action: "APPROVE");

      await ApiService.finalizeSo(idSession: trimString(idSession), reason: reason);

      Get.back();

      showDialogBase(content: const DialogBerhasil()).then((value) {
        Get.back();
      });
    } catch (e) {
      Get.back();
      showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
    }
  }

  void navigateToReviewCekUlang() async {
    // Pass data to ReviewCekUlangView
    CekUlangController.passedIdSession = idSession;
    CekUlangController.passedItems = itemsData.data ?? [];

    // Navigate
    await Get.to(const CekUlangView());
    fetchStocktakeItems();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
