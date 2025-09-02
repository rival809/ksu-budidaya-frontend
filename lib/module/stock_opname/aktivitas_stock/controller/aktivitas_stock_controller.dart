import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/model/stock_opname/aktivitas_stock_model.dart';
import 'package:ksu_budidaya/module/stock_opname/aktivitas_stock/view/aktivitas_stock_view.dart';
import 'package:ksu_budidaya/module/stock_opname/aktivitas_stock/widget/detail_pembelian.dart';

class AktivitasStockController extends State<AktivitasStockView> {
  static late AktivitasStockController instance;
  late AktivitasStockView view;

  String page = "1";
  String size = "500";
  bool isAsc = true;
  TextEditingController supplierNameController = TextEditingController();
  String dropdown = "SEMUA";

  bool? isSelisih;

  Future<dynamic>? dataFuture;

  DataAktivitasStock dataStockOpname = DataAktivitasStock();
  AktivitasStockModel result = AktivitasStockModel();
  List<String> listRoleView = [
    "tg_aktivitas",
    "tg_update_aktivitas",
    "id_product",
    "nm_product",
    "divisi",
    "jumlah",
    "aktivitas",
    "id_aktivitas",
    "user",
  ];

  List<DataDetailProduct> getDetailSuggestions(String query, List<DataDetailProduct>? states) {
    List<DataDetailProduct> matches = [];

    if (states != null) {
      matches.addAll(states);
      matches.retainWhere((s) =>
          (trimString(s.idProduct).toLowerCase().contains(query.toLowerCase()) ||
              trimString(s.nmProduct).toLowerCase().contains(query.toLowerCase())) &&
          s.statusProduct == true);
    }

    return matches;
  }

  String? field;

  cariDataStockOpname({
    bool? isAsc,
    String? field,
  }) async {
    try {
      result = AktivitasStockModel();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (trimString(supplierNameController.text).toString().isNotEmpty) {
        dataCari.addAll({"id_product": trimString(supplierNameController.text)});
      }

      if (isAsc != null) {
        dataCari.addAll({
          "sort_order": [isAsc == true ? "desc" : "asc"]
        });
      }
      if (field != null) {
        dataCari.addAll({
          "sort_by": [field]
        });
      }

      if (field == null) {
        dataCari.removeWhere((key, value) => key == "sort_order");
        dataCari.removeWhere((key, value) => key == "sort_by");

        dataCari.addAll({
          "sort_order": ["desc"]
        });
        dataCari.addAll({
          "sort_by": ["created_at"]
        });
      }

      result = await ApiService.listAktivitasStock(
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

  postDetailPurchase(String id_pembelian) async {
    showCircleDialogLoading();
    try {
      DetailPembelianResult result = await ApiService.detailPembelian(
        data: {"id_pembelian": id_pembelian},
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        Get.to(DetailPembelian(
          result: result,
        ));
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
    instance = this;
    dataFuture = cariDataStockOpname();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
