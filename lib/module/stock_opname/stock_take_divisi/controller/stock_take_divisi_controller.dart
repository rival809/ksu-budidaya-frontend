import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/model/stock_opname/stock_take_model.dart';
import 'package:ksu_budidaya/module/stock_opname/stock_take_divisi/view/stock_take_divisi_view.dart';

class StockTakeDivisiController extends State<StockTakeDivisiView> {
  static late StockTakeDivisiController instance;
  late StockTakeDivisiView view;

  String page = "1";
  String size = "100";
  bool isAsc = true;
  TextEditingController supplierNameController = TextEditingController();

  bool? isSelisih;

  Future<dynamic>? dataFuture;

  String dropdown = "SEMUA";

  DataStockTake dataStockOpname = DataStockTake();
  StockTakeResult result = StockTakeResult();
  List<String> listRoleView = [
    "id_divisi",
    "nm_divisi",
    "stock",
    "total_harga_jual_stock",
    "stock_take",
    "total_harga_jual_stocktake",
    "selisih",
    "selisih_harga_jual",
  ];

  String? field;

  cariDataStockOpname({
    bool? isAsc,
    String? field,
  }) async {
    try {
      result = StockTakeResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
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

      result = await ApiService.listStockTake(
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
