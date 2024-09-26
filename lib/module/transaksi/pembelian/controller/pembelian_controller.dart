import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class PembelianController extends State<PembelianView> {
  static late PembelianController instance;
  late PembelianView view;

  String page = "1";
  String size = "10";
  bool isAsc = true;
  TextEditingController pembelianNameController = TextEditingController();

  Future<dynamic>? dataFuture;

  bool isList = false;
  bool isDetail = false;

  DataPembelian dataCashInOut = DataPembelian();
  PembelianResult result = PembelianResult();
  List<String> listRoleView = [
    "id_pembelian",
    "tg_pembelian",
    "id_supplier",
    "jumlah",
    "total_harga_beli",
    "total_harga_jual",
    "jenis_pembayaran",
    "keterangan",
  ];

  cariDataPembelian({
    bool? isAsc,
    String? field,
  }) async {
    try {
      result = PembelianResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (trimString(pembelianNameController.text).toString().isNotEmpty) {
        dataCari
            .addAll({"keterangan": trimString(pembelianNameController.text)});
      }

      if (isAsc != null) {
        dataCari.addAll({
          "sort_order": [isAsc == true ? "asc" : "desc"]
        });
        dataCari.addAll({
          "sort_by": [field]
        });
      }

      result = await ApiService.listPembelian(
        data: dataCari,
      ).timeout(const Duration(seconds: 30));

      return result;
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
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
        isList = false;
        isDetail = true;
        dataList = result.data ?? [];

        update();
      }
    } catch (e) {
      Navigator.pop(context);

      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  postRemovePurchase(String id_pembelian) async {
    Get.back();
    showCircleDialogLoading();
    try {
      PembelianResult result = await ApiService.removePembelian(
        data: {"id_pembelian": id_pembelian},
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        dataFuture = cariDataPembelian();
        update();
      }
    } catch (e) {
      Navigator.pop(context);

      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  DataDetailPembelian dataDetail = DataDetailPembelian();
  DetailDataPembelian dataSupplier = DetailDataPembelian();

  List<DataDetailPembelian>? dataList = [];

  @override
  void initState() {
    instance = this;
    GlobalReference().supplierReference();
    dataFuture = cariDataPembelian();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
