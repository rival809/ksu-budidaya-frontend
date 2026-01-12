import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CekUlangController extends State<CekUlangView> {
  static late CekUlangController instance;
  late CekUlangView view;

  // Static variable to receive data from previous screen
  static String? passedIdSession;
  static List<DetailListStocktakeItemsilDataListStocktakeItems>? passedItems;

  String? idSession;
  List<DetailListStocktakeItemsilDataListStocktakeItems> items = [];
  List<DetailListStocktakeItemsilDataListStocktakeItems> selectedItems = [];

  PlutoGridStateManager? stateManager;
  final TextEditingController alasanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    instance = this;
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
  }

  void onReady() {
    // Get data from static variable
    idSession = passedIdSession;
    items = passedItems ?? [];

    // Clear static variables after use
    passedIdSession = null;
    passedItems = null;

    update();
  }

  void onRowChecked(PlutoGridOnRowCheckedEvent event) {
    if (event.isChecked ?? false) {
      // Add to selected items
      if (event.row != null) {
        final itemId = event.row!.cells['id_stocktake_item']?.value;
        final item = items.firstWhere(
          (item) => item.idStocktakeItem?.toDouble() == itemId?.toDouble(),
          orElse: () => DetailListStocktakeItemsilDataListStocktakeItems(),
        );
        if (item.idStocktakeItem != null &&
            !selectedItems.any((i) => i.idStocktakeItem == item.idStocktakeItem)) {
          selectedItems.add(item);
        }
      }
    } else {
      // Remove from selected items
      if (event.row != null) {
        final itemId = event.row!.cells['id_stocktake_item']?.value;
        selectedItems.removeWhere((item) => item.idStocktakeItem?.toDouble() == itemId?.toDouble());
      }
    }
    update();
  }

  void toggleSelectAll(bool? value) {
    if (stateManager != null) {
      if (value == true) {
        for (var row in stateManager!.rows) {
          row.setChecked(true);
        }
        selectedItems = List.from(items);
      } else {
        for (var row in stateManager!.rows) {
          row.setChecked(false);
        }
        selectedItems.clear();
      }
      update();
    }
  }

  void onNotesChanged(dynamic itemId, String newValue) {
    print("=== onNotesChanged called ===");
    print("itemId: $itemId");
    print("newValue: '$newValue'");

    final itemIndex = items.indexWhere(
      (item) => item.idStocktakeItem?.toDouble() == itemId?.toDouble(),
    );

    print("itemIndex found: $itemIndex");

    if (itemIndex >= 0) {
      items[itemIndex].notes = newValue;
      print(
          "Notes updated for item ${items[itemIndex].idStocktakeItem}: '${items[itemIndex].notes}'");

      // Use postFrameCallback to avoid setState during build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          update();
        }
      });
    } else {
      print("Item not found!");
    }
  }

  Future<void> submitReview({required String alasan}) async {
    if (selectedItems.isEmpty) {
      showInfoDialog("Pilih minimal satu item untuk direview.", context);
      return;
    }

    try {
      // Force commit any cell that's currently being edited
      if (stateManager != null) {
        // If there's a cell being edited, commit it first
        if (stateManager!.isEditing) {
          stateManager!.setEditing(false);
        }

        // Move focus away to ensure all changes are committed
        final currentCell = stateManager!.currentCell;
        if (currentCell != null) {
          stateManager!.setCurrentCell(null, 0);
        }

        // Small delay to ensure state is updated
        await Future.delayed(const Duration(milliseconds: 100));

        // Sync all notes from grid back to items list
        for (var row in stateManager!.rows) {
          final itemId = row.cells['id_stocktake_item']?.value;
          final notesValue = row.cells['notes']?.value;

          if (itemId != null) {
            final itemIndex = items.indexWhere(
              (item) => item.idStocktakeItem?.toDouble() == itemId?.toDouble(),
            );

            if (itemIndex >= 0 && notesValue != null) {
              items[itemIndex].notes = notesValue.toString();
              print("Synced notes for item $itemId: '$notesValue'");
            }
          }
        }
      }

      showCircleDialogLoading();

      // Prepare revision items - get latest notes from items list
      List<Map<String, dynamic>> revisionItems = selectedItems.map((selectedItem) {
        // Find the item in the main items list to get latest notes
        final latestItem = items.firstWhere(
          (item) => item.idStocktakeItem == selectedItem.idStocktakeItem,
          orElse: () => selectedItem,
        );

        DataMap data = {
          "id_stocktake_item": latestItem.idStocktakeItem,
        };

        final notesText = trimString(latestItem.notes);
        if (notesText.isNotEmpty && notesText != "-") {
          data["flag_reason"] = notesText;
        } else {
          data["flag_reason"] = alasan;
        }

        return data;
      }).toList();

      await ApiService.reviewSo(
        idSession: idSession!,
        reason: alasan,
        action: "REQUEST_REVISION",
        revisionItems: revisionItems,
      ).timeout(const Duration(seconds: 30));

      Get.back(); // Close loading dialog
      showDialogBase(content: const DialogBerhasil()).then((value) async {
        Get.back(); // Navigate back to previous screen
      });
    } catch (e) {
      Get.back();
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
          "Tidak Mendapat Respon Dari Server! Silakan coba lagi.",
          context,
        );
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  @override
  void dispose() {
    alasanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
