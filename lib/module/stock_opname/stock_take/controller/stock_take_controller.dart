import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/model/stock_opname/detail_stock_take_model.dart';
import 'package:ksu_budidaya/module/stock_opname/stock_take/view/stock_take_view.dart';

class StockTakeController extends State<StockTakeView> {
  static late StockTakeController instance;
  late StockTakeView view;

  String page = "1";
  String size = "500";
  bool isAsc = true;
  TextEditingController supplierNameController = TextEditingController();

  bool? isSelisih;

  Future<dynamic>? dataFuture;

  String dropdown = "SEMUA";

  DataDetailStockTake dataStockOpname = DataDetailStockTake();
  DetailStockTakeResult result = DetailStockTakeResult();
  List<String> listRoleView = [
    "id_product",
    "nm_product",
    "divisi",
    "petugas",
    "stock",
    "total_harga_jual_stock",
    "stock_take",
    "total_harga_jual_stocktake",
    "selisih",
    "selisih_harga_jual",
    "is_selisih",
  ];

  String? field;

  cariDataStockOpname({
    bool? isAsc,
    String? field,
  }) async {
    try {
      result = DetailStockTakeResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
        "id_divisi": trimString(widget.idDivisi),
      };

      // if (trimString(supplierNameController.text).toString().isNotEmpty) {
      //   dataCari.addAll({"nm_product": trimString(supplierNameController.text)});
      // }

      // if (isAsc != null) {
      //   dataCari.addAll({
      //     "sort_order": [isAsc == true ? "asc" : "desc"]
      //   });
      // }
      // if (field != null) {
      //   dataCari.addAll({
      //     "sort_by": [field]
      //   });
      // }

      // if (field == null) {
      //   dataCari.removeWhere((key, value) => key == "sort_order");
      //   dataCari.removeWhere((key, value) => key == "sort_by");

      //   dataCari.addAll({
      //     "sort_order": ["desc"]
      //   });
      //   dataCari.addAll({
      //     "sort_by": ["created_at"]
      //   });
      // }

      if (isSelisih != null) {
        dataCari.addAll({"is_selisih": isSelisih});
      }

      result = await ApiService.detailStockTake(
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

  @override
  void initState() {
    instance = this;
    dataFuture = cariDataStockOpname();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
