import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class ProdukController extends State<ProdukView> {
  static late ProdukController instance;
  late ProdukView view;

  String page = "1";
  String size = "500";
  bool isAsc = true;
  TextEditingController productNameController = TextEditingController();
  String? field;

  Future<dynamic>? dataFuture;

  DataProduct dataProduct = DataProduct();
  ProductResult result = ProductResult();

  // PlutoGrid StateManager untuk update tanpa rebuild
  PlutoGridStateManager? plutoGridStateManager;

  List<String> listProdukView = [
    "id_divisi",
    "id_product",
    "nm_product",
    "id_supplier",
    "harga_beli",
    "harga_jual",
    "jumlah",
    "total_beli",
    "total_jual",
  ];

  // Mandatory columns that are always visible
  List<String> get mandatoryColumns => [
        "id_divisi",
        "id_product",
        "harga_beli",
        "harga_jual",
      ];

  // Available columns with display names (excluding mandatory ones)
  List<ColumnOption> get availableColumns => [
        ColumnOption(field: "nm_product", displayName: "Nama Product"),
        ColumnOption(field: "id_supplier", displayName: "Supplier"),
        ColumnOption(field: "jumlah", displayName: "Stock"),
        ColumnOption(field: "total_beli", displayName: "Total Beli"),
        ColumnOption(field: "total_jual", displayName: "Total Jual"),
      ];

  // Selected optional columns with ValueNotifier for reactive updates
  late ValueNotifier<List<String>> selectedOptionalColumnsNotifier;

  // Get selected optional columns list
  List<String> get selectedOptionalColumns => selectedOptionalColumnsNotifier.value;

  // Get all visible columns (mandatory + selected optional)
  List<String> get selectedColumns => [
        ...mandatoryColumns,
        ...selectedOptionalColumns,
      ];

  void updateSelectedColumns(List<String> newSelection) {
    // Only update the optional columns (remove mandatory ones from selection)
    List<String> filteredSelection =
        newSelection.where((col) => !mandatoryColumns.contains(col)).toList();
    selectedOptionalColumnsNotifier.value = filteredSelection;

    // Clear state manager karena grid akan rebuild dengan columns yang berbeda
    plutoGridStateManager = null;

    // Just trigger a UI update without refetching data
    // The ValueNotifier will automatically rebuild the widget
    update();
  }

  void updateGridColumns() {
    // This method is no longer needed since we're using ValueNotifier
    // The UI will automatically rebuild when selectedOptionalColumnsNotifier changes
  }

  // Method untuk update single row di PlutoGrid tanpa rebuild
  void updateGridRow(DataDetailProduct updatedProduct) {
    if (plutoGridStateManager == null) return;

    // Find the row dengan id_product yang sama
    final rowIndex = plutoGridStateManager!.rows.indexWhere(
      (row) => row.cells['id_product']?.value == updatedProduct.idProduct,
    );

    if (rowIndex != -1) {
      final row = plutoGridStateManager!.rows[rowIndex];

      // Update cell values sesuai dengan selectedColumns
      for (String column in selectedColumns) {
        if (row.cells.containsKey(column)) {
          String newValue;

          switch (column) {
            case "id_product":
              newValue = trimString(updatedProduct.idProduct);
              break;
            case "id_divisi":
              newValue = getNamaDivisi(idDivisi: trimString(updatedProduct.idDivisi));
              break;
            case "id_supplier":
              newValue = getNamaSupplier(idSupplier: trimString(updatedProduct.idSupplier));
              break;
            case "nm_product":
              newValue = trimString(updatedProduct.nmProduct);
              break;
            case "harga_beli":
              newValue = trimString(updatedProduct.hargaBeli);
              break;
            case "harga_jual":
              newValue = trimString(updatedProduct.hargaJual);
              break;
            case "jumlah":
              newValue = trimString(updatedProduct.jumlah.toString());
              break;
            case "total_beli":
              newValue = trimString(updatedProduct.totalBeli.toString());
              break;
            case "total_jual":
              newValue = trimString(updatedProduct.totalJual.toString());
              break;
            default:
              newValue = trimStringStrip(updatedProduct.toJson()[column].toString());
          }

          // Update cell value
          plutoGridStateManager!.changeCellValue(
            row.cells[column]!,
            newValue,
            force: true,
            notify: false,
          );
        }
      }

      // Notify grid untuk refresh tampilan
      plutoGridStateManager!.notifyListeners();
    }
  }

  PlutoColumnType typeField(String field) {
    switch (field) {
      case "jumlah":
        return PlutoColumnType.number(locale: "id");
      case "harga_beli":
        return PlutoColumnType.number(locale: "id");
      case "harga_jual":
        return PlutoColumnType.number(locale: "id");
      case "total_jual":
        return PlutoColumnType.number(locale: "id");
      case "total_beli":
        return PlutoColumnType.number(locale: "id");

      default:
        return PlutoColumnType.text();
    }
  }

  List<dynamic> listData = [];

  bool step1 = true;
  bool step2 = false;

  onSwitchStep(String valueStep) {
    switch (valueStep) {
      case "1":
        step1 = true;
        step2 = false;
        page = "1";
        // Clear state manager karena akan rebuild grid
        plutoGridStateManager = null;
        update();
        break;
      case "2":
        step1 = false;
        step2 = true;
        page = "1";
        // Clear state manager karena akan rebuild grid
        plutoGridStateManager = null;
        update();
        break;

      default:
        step1 = true;
        step2 = false;
        // Clear state manager karena akan rebuild grid
        plutoGridStateManager = null;
        update();
    }
    update();
  }

  cariDataProduct({bool? isAsc, String? field}) async {
    try {
      result = ProductResult();
      DataMap dataCari = {
        "page": page,
        "status_product": step1,
        "size": size,
      };

      if (trimString(productNameController.text).toString().isNotEmpty) {
        dataCari.addAll({"nm_product": trimString(productNameController.text)});
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
      result = await ApiService.listProduct(
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

  postCreateProduct(DataMap dataCreate) async {
    Get.back();

    showCircleDialogLoading();
    try {
      ProductResult result = await ApiService.createProduct(
        data: dataCreate,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        GlobalReference().productReference();

        // Refresh data dari server untuk mendapatkan data terbaru
        dataFuture = cariDataProduct();
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

  postRemoveProduct(String idProduct) async {
    Get.back();
    showCircleDialogLoading();
    try {
      ProductResult result = await ApiService.removeProduct(
        data: {"id_product": idProduct},
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        GlobalReference().productReference();

        // Refresh data dari server untuk mendapatkan data terbaru
        dataFuture = cariDataProduct();
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

  postUpdateProduct(DataMap dataEdit) async {
    Get.back();

    showCircleDialogLoading();
    try {
      ProductResult result = await ApiService.updateProduct(
        data: dataEdit,
      ).timeout(const Duration(seconds: 30));

      if (result.success == true) {
        await refreshDataAndUpdateGrid(dataEdit["id_product"]);

        Navigator.pop(context);
        showDialogBase(
          content: const DialogBerhasil(),
        );

        GlobalReference().productReference();

        // Refresh data dari server dan update grid row yang spesifik
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

  // Method untuk mendapatkan data product terbaru dari grid
  DataDetailProduct? getProductFromGrid(String idProduct) {
    if (plutoGridStateManager == null) return null;

    // Find row dengan id_product yang sama
    PlutoRow? targetRow;
    try {
      targetRow = plutoGridStateManager!.rows.firstWhere(
        (row) => row.cells['id_product']?.value == idProduct,
      );
    } catch (e) {
      return null; // Row tidak ditemukan
    }

    if (targetRow.cells.isEmpty) return null;

    // Reconstruct DataDetailProduct dari grid cells
    try {
      Map<String, dynamic> productData = {};

      // Extract data dari grid cells
      for (String column in selectedColumns) {
        if (targetRow.cells.containsKey(column)) {
          String cellValue = targetRow.cells[column]!.value.toString();

          switch (column) {
            case "id_product":
              productData["id_product"] = cellValue;
              break;
            case "id_divisi":
              // Reverse lookup untuk mendapatkan id_divisi dari nama
              productData["id_divisi"] = "";
              for (var divisi in DivisiDatabase.dataDivisi.dataDivisi ?? []) {
                if (divisi.nmDivisi == cellValue) {
                  productData["id_divisi"] = divisi.idDivisi;
                  break;
                }
              }
              break;
            case "id_supplier":
              // Reverse lookup untuk mendapatkan id_supplier dari nama
              productData["id_supplier"] = "";
              for (var supplier in SupplierDatabase.dataSupplier.dataSupplier ?? []) {
                if (supplier.nmSupplier == cellValue) {
                  productData["id_supplier"] = supplier.idSupplier;
                  break;
                }
              }
              break;
            case "nm_product":
              productData["nm_product"] = cellValue;
              break;
            case "harga_beli":
              productData["harga_beli"] = cellValue;
              break;
            case "harga_jual":
              productData["harga_jual"] = cellValue;
              break;
            case "jumlah":
              productData["jumlah"] = int.tryParse(cellValue) ?? 0;
              break;
            case "total_beli":
              productData["total_beli"] = cellValue;
              break;
            case "total_jual":
              productData["total_jual"] = cellValue;
              break;
          }
        }
      }

      // Get status_product dari Aksi cell
      productData["status_product"] = targetRow.cells['Aksi']?.value ?? true;

      return DataDetailProduct.fromJson(productData);
    } catch (e) {
      return null;
    }
  }

  // Method untuk refresh data dan update single grid row tanpa rebuild
  Future<void> refreshDataAndUpdateGrid(String? idProduct) async {
    try {
      // Fetch data terbaru dari server
      final freshResult = await cariDataProduct();

      if (freshResult != null && freshResult.success == true) {
        // Update data source
        dataProduct = freshResult.data ?? DataProduct();

        // Jika ada id_product spesifik, update hanya row tersebut
        if (idProduct != null) {
          final updatedProduct =
              dataProduct.dataProduct?.firstWhere((element) => element.idProduct == idProduct);

          if (updatedProduct != null) {
            // Update single row di grid dengan data terbaru dari server
            updateGridRow(updatedProduct);
          }
        }
      }
    } catch (e) {
      // Jika error, fallback ke rebuild grid
      dataFuture = cariDataProduct();
      update();
    }
  }

  @override
  void initState() {
    instance = this;

    // Initialize ValueNotifier with default selected optional columns
    selectedOptionalColumnsNotifier = ValueNotifier([
      "nm_product",
      "id_supplier",
      "jumlah",
      "total_beli",
      "total_jual",
    ]);

    GlobalReference().divisiReference();
    GlobalReference().supplierReference();
    dataFuture = cariDataProduct();

    super.initState();
  }

  @override
  void dispose() {
    selectedOptionalColumnsNotifier.dispose();
    plutoGridStateManager = null; // Clear reference
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
