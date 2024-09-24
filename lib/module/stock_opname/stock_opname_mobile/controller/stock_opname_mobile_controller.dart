import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ksu_budidaya/core.dart';

class StockOpnameMobileController extends State<StockOpnameMobileView> {
  static late StockOpnameMobileController instance;
  late StockOpnameMobileView view;

  TextEditingController textBarcodeController = TextEditingController();
  TextEditingController textNamaProdukController = TextEditingController();
  TextEditingController textCurrentStockController = TextEditingController();
  TextEditingController textStockController = TextEditingController();
  String stockEdit = "";
  Timer? _debounce;

  final stockOpnameKey = GlobalKey<FormState>();

  DetailProductResult dataResult = DetailProductResult();

  void onBarcodeChanged(String value) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(
      const Duration(seconds: 1),
      () {
        postDetailProduct(value);
      },
    );
  }

  postDetailProduct(String idProduct) async {
    showCircleDialogLoading(context);
    try {
      dataResult = DetailProductResult();
      textStockController.clear();
      textNamaProdukController.clear();
      textCurrentStockController.clear();
      stockEdit = "";

      DetailProductResult result = await ApiService.detailProduct(
        data: {"id_product": idProduct},
      ).timeout(const Duration(seconds: 30));
      Navigator.pop(context);

      if (result.success == true) {
        dataResult = result;
        textNamaProdukController.text = trimString(result.data?.nmProduct);
        textCurrentStockController.text =
            trimString(result.data?.jumlah.toString());
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

  postUpdateProduct(String idProduct, String jumlah) async {
    showCircleDialogLoading(context);
    try {
      ProductResult result = await ApiService.updateProduct(
        data: {
          "id_product": idProduct,
          "jumlah": jumlah,
        },
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        await showDialogBase(
          content: const DialogBerhasil(),
        );

        postDetailProduct(idProduct);
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

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
