import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/model/stock_opname/history_stock_opname_model.dart';
import 'package:ksu_budidaya/module/stock_opname/riwayat_stock_opname/view/riwayat_stock_opname_view.dart';

class RiwayatStockOpnameController extends State<RiwayatStockOpnameView> {
  static late RiwayatStockOpnameController instance;
  late RiwayatStockOpnameView view;

  String page = "1";
  String size = "100";
  bool isAsc = true;
  TextEditingController supplierNameController = TextEditingController();
  String dropdown = "SEMUA";

  bool? isSelisih;

  Future<dynamic>? dataFuture;

  DataHistoryStockOpname dataStockOpname = DataHistoryStockOpname();
  HistoryStockOpnameModel result = HistoryStockOpnameModel();
  List<String> listRoleView = [
    "tg_stocktake",
    "name",
    "nm_product",
    "stok_awal",
    "total_harga_jual_stock",
    "stok_akhir",
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
      result = HistoryStockOpnameModel();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (trimString(supplierNameController.text).toString().isNotEmpty) {
        dataCari.addAll({"nm_product": trimString(supplierNameController.text)});
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

      if (isSelisih != null) {
        dataCari.addAll({"is_selisih": isSelisih});
      }

      result = await ApiService.listHistoryStockOpname(
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
